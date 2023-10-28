import 'package:flutter/material.dart';
import 'package:flutter_ab_test/data_source/add_item_data_source.dart';
import 'package:flutter_ab_test/repo/add_item_repo.dart';
import 'package:flutter_ab_test/view/home_screen/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';

import '../../data_source/edit_item_data_source.dart';
import '../../repo/edit_item_repo.dart';
import '../../utils/di/injection.dart';
import '../../utils/errors/failures.dart';
import '../../utils/helper/hive_helper.dart';
import '../../utils/network/connection/network_info.dart';
import '../../utils/resources/snackbar_widget.dart';
import 'edit_item_state.dart';

class EditItemCubit extends Cubit<EditItemState> {
  EditItemCubit() : super(EditItemInitial());

  static EditItemCubit get(context) => BlocProvider.of(context);

  final EditItemRepo _addItemRepo = EditItemRepo(
    networkInfo: instance<NetworkInfoImp>(),
    editItemDataSource: EditItemDataSource(),
  );

  void editItem(context, {
    required String id,
    required String imageLink,
    required String title,
    required String description,
  }) {
    emit(EditItemLoadingState());
    // showLoadingDialog(context, dismissible: false);
    _addItemRepo.editItem(
        body: {
          'email' : HiveHelper.getUserEmail(),
          "id" : id,
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
        emit(EditItemErrorState());
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
        emit(EditItemSuccessState());
      });
    });
  }

}
