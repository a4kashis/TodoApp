import 'package:todo/app/data/models/response/app_config_response.dart';
import 'package:todo/app/data/values/urls.dart';
import 'package:todo/base/base_reposiotry.dart';
import 'package:todo/utils/helper/exception_handler.dart';
import 'package:todo/utils/storage/storage_utils.dart';

class ConfigRepository extends BaseRepositry {
  saveAppConfig() async {
    final response = await controller.get(path: URLs.appConfig);
    if (!(response is APIException))
      Storage.setAppConfig(AppConfigResponse.fromJson(response).data);
  }
}
