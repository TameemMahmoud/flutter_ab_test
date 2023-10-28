import 'package:dartz/dartz.dart';
import 'package:flutter_ab_test/data_source/add_item_data_source.dart';

import '../utils/errors/exceptions.dart';
import '../utils/errors/failures.dart';
import '../utils/network/connection/network_info.dart';

class AddItemRepo {
  NetworkInfo networkInfo;
  AddItemDataSource addItemDataSource;

  AddItemRepo({required this.networkInfo, required this.addItemDataSource,});

  Future<Either<Failure, String>> addItem(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    if (await networkInfo.isConnected) {
      try {
        String result =
        await addItemDataSource.addItem(body: body, headers: headers);
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