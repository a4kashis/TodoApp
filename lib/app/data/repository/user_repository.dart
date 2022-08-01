import 'package:todo/app/data/models/dto/response.dart';
import 'package:todo/app/data/models/dto/user.dart';
import 'package:todo/app/data/models/request/auth_request.dart';
import 'package:todo/app/data/models/response/user_response.dart';
import 'package:todo/app/data/values/urls.dart';
import 'package:todo/base/base_reposiotry.dart';
import 'package:todo/utils/helper/exception_handler.dart';

class UserRepository extends BaseRepositry {

  // Future<RepoResponse<User>> signUp(SignUpRequest data) async {
  //   final response =
  //       await controller.post(path: URLs.signUp, data: data.toJson());
  //
  //   return response is APIException
  //       ? RepoResponse(error: response)
  //       : RepoResponse(data: UserResponse.fromJson(response).data);
  // }
}
