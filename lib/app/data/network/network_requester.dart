import 'dart:developer';

import 'package:todo/app/data/values/constants.dart';
import 'package:todo/app/data/values/env.dart';
import 'package:todo/utils/helper/exception_handler.dart';

class NetworkRequester {
  NetworkRequester() {
    prepareRequest();
  }

  void prepareRequest() {}

  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? query,
  }) async {
    try {
      // final response = await _dio.get(path, queryParameters: query);
      // return response.data;
    } on Exception catch (exception) {
      return ExceptionHandler.handleError(exception);
    }
  }
}
