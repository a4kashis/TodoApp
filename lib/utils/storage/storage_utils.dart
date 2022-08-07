import 'package:get_storage/get_storage.dart';
import 'package:todo/app/data/models/dto/User.dart';
import 'package:todo/app/data/models/response/app_config_response.dart';

class Storage {
  Storage._privateConstructor();

  static final _box = GetStorage();

  static AppConfig getAppConfig() =>
      AppConfig.fromJson(_box.read(StorageKeys.APP_CONFIG));

  static void setAppConfig(AppConfig appConfig) =>
      _box.write(StorageKeys.APP_CONFIG, appConfig.toJson());

  static UserData getUser() => UserData.fromJson(_box.read(StorageKeys.USER));

  static void setUser(UserData? user) =>
      _box.write(StorageKeys.USER, user?.toJson());

  static bool isUserExists() => _box.read(StorageKeys.USER) != null;

  static Future<void> clearStorage() => _box.erase();
}

class StorageKeys {
  StorageKeys._privateConstructor();

  static const APP_CONFIG = 'app_config';
  static const USER = 'user';
}
