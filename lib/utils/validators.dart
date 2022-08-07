import 'package:get/get.dart';
import 'package:todo/app/data/values/strings.dart';

String? mandatoryValidator(String? value) {
  if (value == null || value.isEmpty) {
    return ErrorMessages.mandatory;
  }
  return null;
}

String? emailValidator(String? value) {
  if (!GetUtils.isEmail(value ?? "")) {
    return ErrorMessages.invalidEmail;
  }
  return null;
}
