import 'dart:convert';

import 'package:dio/dio.dart';

import '../utils/di/injection.dart';
import '../utils/errors/exceptions.dart';
import '../utils/log/log.dart';
import '../utils/network/dio/enum.dart';
import '../utils/network/dio/network_call.dart';
import '../utils/network/urls/end_points.dart';

class EditItemDataSource {
  Future<String> editItem(
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    print(body);
    late Response response;
    try {
      response = await instance<NetworkCall>().request(EndPoints.edit,
          queryParameters: body,
          options: Options(method: Method.get.name, headers: headers));
    } catch (error) {
      print(error);
      throw ServerException();
    }
    var res = jsonDecode(response.data);
    Log.i(res.toString());
    if (response.statusCode == 200) {
      return res[0]['message'];
    } else {
      throw WrongDataException(res.toString());
    }
  }

}