import 'package:flutter/material.dart';
import 'package:flutter_ab_test/data_source/add_item_data_source.dart';
import 'package:flutter_ab_test/repo/add_item_repo.dart';
import 'package:flutter_ab_test/view/home_screen/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';

import '../../utils/di/injection.dart';
import '../../utils/errors/failures.dart';
import '../../utils/helper/hive_helper.dart';
import '../../utils/network/connection/network_info.dart';
import '../../utils/resources/snackbar_widget.dart';
import 'add_item_state.dart';

class AddItemCubit extends Cubit<AddItemState> {
  AddItemCubit() : super(AddItemInitial());

  static AddItemCubit get(context) => BlocProvider.of(context);

  final AddItemRepo _addItemRepo = AddItemRepo(
    networkInfo: instance<NetworkInfoImp>(),
    addItemDataSource: AddItemDataSource(),
  );

  void addItem(context, {
    required String imageLink,
    required String title,
    required String description,
  }) {
    emit(AddItemLoadingState());
    // showLoadingDialog(context, dismissible: false);
    _addItemRepo.addItem(
        body: {
          'email' : HiveHelper.getUserEmail(),
          'title' : title,
          'img_link' : imageLink,
          'description' : description,
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
        emit(AddItemErrorState());
      }, (r) {
        r == 'successful'?
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: r,
          onConfirmBtnTap: (){
            Navigator.of(context)
                .pushNamedAndRemoveUntil(HomeScreen.routeName, (Route<dynamic> route) => false);

          }
        ) : QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: r,
            onConfirmBtnTap: (){
Navigator.pop(context);
            }
        );
        emit(AddItemSuccessState());
      });
    });
  }

}
