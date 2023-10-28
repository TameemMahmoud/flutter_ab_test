import 'package:dartz/dartz.dart';

import '../data_source/home_data_source.dart';
import '../models/item_model.dart';
import '../utils/errors/exceptions.dart';
import '../utils/errors/failures.dart';
import '../utils/network/connection/network_info.dart';

class HomeDataRepo {
  NetworkInfo networkInfo;
  HomeDataSource homeDataSource;

  HomeDataRepo({required this.networkInfo, required this.homeDataSource,});


  Future<Either<Failure, List<ItemModel>>> getHomeData(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    if (await networkInfo.isConnected) {
      try {
        List<ItemModel> result =
        await homeDataSource.getHomeData(body: body, headers: headers);
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

  Future<Either<Failure, String>> deleteItem(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    if (await networkInfo.isConnected) {
      try {
        String result =
        await homeDataSource.DeleteItem(body: body, headers: headers);
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