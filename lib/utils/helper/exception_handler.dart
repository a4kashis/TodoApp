import 'package:get/get.dart';
import 'package:todo/app/data/models/response/error_response.dart';
import 'package:todo/app/data/values/strings.dart';

class APIException implements Exception {
  final String message;

  APIException({required this.message});
}

class ExceptionHandler {
  ExceptionHandler._privateConstructor();

  static APIException handleError(dynamic error) {
    return APIException(message: error);
  }
}

class HandleError {
  HandleError._privateConstructor();

  static handleError(APIException? error) {
    Get.rawSnackbar(message: error?.message ?? ErrorMessages.networkGeneral);
  }
}
