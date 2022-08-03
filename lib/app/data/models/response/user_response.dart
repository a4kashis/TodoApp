import 'package:todo/app/data/models/dto/User.dart';

class UserResponse {
  late UserData? data;
  late int statusCode;

  UserResponse({required this.data, required this.statusCode});

  UserResponse.fromJson(Map<String, dynamic> json) {
    this.data = json['data'] == null ? null : UserData.fromJson(json['data']);
    this.statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['data'] = this.data?.toJson();
    data['statusCode'] = this.statusCode;
    return data;
  }
}
