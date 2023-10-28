import 'package:dio/dio.dart';

import 'dio.dart';
import 'enum.dart';


class NetworkCall {
  DioHelper dioHelper;

  NetworkCall({required this.dioHelper});

  Future<Response> _request<T>(String url,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      required Options options,
      Map<String, dynamic>? headers,
      void Function(int, int)? onSendProgress}) async {
    if (headers != null) {
      dioHelper.dio.options.headers = headers;
    }
    return await dioHelper.dio.request(url,
        onSendProgress: onSendProgress,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken);
  }

  Future<Response> request(
    String url, {
    Object? params,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    required Options options,
  }) async {
    return await _request(
      url,
      data: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }


  Stream requestStream<Response>(
    Method method,
    String url, {
    Function(int code, String msg)? onError,
    Map<String, dynamic>? params,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    required Options options,
    Map<String, dynamic>? headers,
  }) {
    return Stream.fromFuture(_request(url,
        data: params,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        headers: headers));
  }


}
