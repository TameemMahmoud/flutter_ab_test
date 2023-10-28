import 'package:bloc/bloc.dart';
import 'package:flutter_ab_test/models/item_model.dart';
import 'package:flutter_ab_test/utils/app/my_app.dart';
import 'package:flutter_ab_test/utils/helper/hive_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';

import '../../data_source/home_data_source.dart';
import '../../repo/home_data_repo.dart';
import '../../utils/di/injection.dart';
import '../../utils/errors/failures.dart';
import '../../utils/network/connection/network_info.dart';
import '../../utils/resources/snackbar_widget.dart';
import 'get_home_state.dart';

class GetHomeCubit extends Cubit<GetHomeState> {
  GetHomeCubit() : super(GetHomeInitial());

  static GetHomeCubit get(context) => BlocProvider.of(context);

  final HomeDataRepo _homeDataRepo = HomeDataRepo(
    networkInfo: instance<NetworkInfoImp>(),
    homeDataSource: HomeDataSource(),
  );

  List<ItemModel>? itemList;

  void getHomeData(context) {
    emit(GetHomeDataLoadingState());
    // showLoadingDialog(context, dismissible: false);
    _homeDataRepo.getHomeData(
      body: {
        'email' : HiveHelper.getUserEmail(),
      }
    ).then((value) {
      // dismissLoadingDialog(context);
      value.fold((l) {
        String error = '';
        if (l is OffLineFailure) {
          error = 'Internet Connection';
          failSnackBar(
              'Internet Connection', 'Internet Connection', context);
        } else if (l is WrongDataFailure) {
          error = l.message.toString();

          failSnackBar(
              l.message.toString(), '', context);
        } else if (l is ServerFailure) {
          error = 'Server Failure ';

          failSnackBar('Server Failure ',
              'Please, try again. there is a Server Failure', context);
        }
        emit(GetHomeDataErrorState());
      }, (r) {
        itemList = r;
        emit(GetHomeDataSuccessState());
      });
    });
  }

  Future<void> deleteItem(context, String id) async {
    emit(GetHomeDataLoadingState());
    // showLoadingDialog(context, dismissible: false);
    await _homeDataRepo.deleteItem(
        body: {
          'email' : HiveHelper.getUserEmail(),
          'id' : id,
        }
    ).then((value) {
      // dismissLoadingDialog(context);
      value.fold((l) {
        String error = '';
        if (l is OffLineFailure) {
          error = 'Internet Connection';
          failSnackBar(
              'Internet Connection', 'Internet Connection', context);
        } else if (l is WrongDataFailure) {
          error = l.message.toString();

          failSnackBar(
              l.message.toString(), '', context);
        } else if (l is ServerFailure) {
          error = 'Server Failure ';

          failSnackBar('Server Failure ',
              'Please, try again. there is a Server Failure', context);
        }
        emit(GetHomeDataErrorState());
      }, (r) {
        r == 'successful'?
        getHomeData(context) : null;
        emit(GetHomeDataSuccessState());
      });
    });
  }
}
