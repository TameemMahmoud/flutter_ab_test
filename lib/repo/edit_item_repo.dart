import 'package:dartz/dartz.dart';
import 'package:flutter_ab_test/data_source/add_item_data_source.dart';

import '../data_source/edit_item_data_source.dart';
import '../utils/errors/exceptions.dart';
import '../utils/errors/failures.dart';
import '../utils/network/connection/network_info.dart';

class EditItemRepo {
  NetworkInfo networkInfo;
  EditItemDataSource editItemDataSource;

  EditItemRepo({required this.networkInfo, required this.editItemDataSource,});

  Future<Either<Failure, String>> editItem(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    if (await networkInfo.isConnected) {
      try {
        String result =
        await editItemDataSource.editItem(body: body, headers: headers);
        return right(result);
      } on WrongDataException catch (message) {
        return left(WrongDataFailure(message: message.message));
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

}