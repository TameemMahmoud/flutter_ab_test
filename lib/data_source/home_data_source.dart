import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_ab_test/models/item_model.dart';

import '../utils/di/injection.dart';
import '../utils/errors/exceptions.dart';
import '../utils/log/log.dart';
import '../utils/network/dio/enum.dart';
import '../utils/network/dio/network_call.dart';
import '../utils/network/urls/end_points.dart';

class HomeDataSource {
  Future<List<ItemModel>> getHomeData(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    late Response response;
    try {
      response = await instance<NetworkCall>().request(EndPoints.read,
          queryParameters: body,
          options: Options(method: Method.get.name, headers: headers));
    } catch (error) {
      print(error);
      throw ServerException();
    }
    var res = jsonDecode(response.data);
    Log.i(res.toString());
    if (response.statusCode == 200) {
      if (res is List && res.isNotEmpty && res[0]['id'] != null) {
        List<ItemModel> items = [];
        for (var item in res) {
          items.add(ItemModel.fromJson(item));
        }
        return items;
      } else if (res is List && res.isNotEmpty && res[0]['message'] == 'No post') {
        List<ItemModel> items = [];
        return items;
      } else {
        throw WrongDataException(res[0]['message'].toString());
      }
    } else {
      throw WrongDataException(res.toString());
    }
  }
  Future<String> DeleteItem(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    late Response response;
    try {
      response = await instance<NetworkCall>().request(EndPoints.delete,
          queryParameters: body,
          options: Options(method: Method.delete.name, headers: headers));
    } catch (error) {
      print(error);
      throw ServerException();
    }
    var res = jsonDecode(response.data);
    Log.i(res.toString());
    // status code always = 200, so we lost the status code usage by this way, also in add and edit
    if (response.statusCode == 200) {
      return res[0]['message'];
    } else {
      throw WrongDataException(res.toString());
    }
  }

}