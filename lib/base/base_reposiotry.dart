import 'package:get/get.dart';
import 'package:todo/app/data/network/network_requester.dart';

class BaseRepositry {
  NetworkRequester get controller => GetInstance().find<NetworkRequester>();
}
