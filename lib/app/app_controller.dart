import 'package:todo/app/data/repository/config_repository.dart';
import 'package:todo/base/base_controller.dart';

class AppController extends BaseController<ConfigRepository> {
  @override
  void onInit() {
    super.onInit();
    // repository.saveAppConfig();
  }
}
