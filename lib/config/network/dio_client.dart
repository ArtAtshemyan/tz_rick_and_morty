import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '/common/constants/app_urls.dart';

const int apiTimeOut = 90000;

class DioClient {
  late final Dio _dio;

  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: AppUrls.baseUrl,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Accept': 'application/json'
            },
            responseType: ResponseType.json,
            receiveTimeout: const Duration(milliseconds: apiTimeOut),
            sendTimeout: const Duration(milliseconds: apiTimeOut),
            connectTimeout: const Duration(milliseconds: apiTimeOut),
          ),
        ) {
    if (!kReleaseMode) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
  }
  // GET METHOD
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException {
      rethrow;
    }
  }
}
