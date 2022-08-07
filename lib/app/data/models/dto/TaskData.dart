import 'package:todo/app/data/models/dto/User.dart';

class TaskData {
  TaskData({
    this.id,
    this.type,
    this.title,
    this.description,
    this.place,
    this.timeStamp,
    this.thingType,
    this.isCompleted,
    this.users,
    this.createdBy,
  });

  TaskData.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    title = json['title'];
    description = json['description'];
    place = json['place'];
    timeStamp = json['timeStamp'];
    thingType = json['thingType'];
    isCompleted = json['isCompleted'];
    createdBy =
        json['createdBy'] != null ? UserData.fromJson(json['createdBy']) : null;
    if (json['user'] != null) {
      users = [];
      json['user'].forEach((v) {
        users?.add(UserData.fromJson(v));
      });
    }
  }

  String? id;
  String? type;
  String? title;
  String? description;
  String? place;
  String? timeStamp;
  String? thingType;
  bool? isCompleted;
  UserData? createdBy;
  List<UserData>? users;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['title'] = title;
    map['description'] = description;
    map['place'] = place;
    map['timeStamp'] = timeStamp;
    map['thingType'] = thingType;
    map['isCompleted'] = isCompleted;

    if (createdBy != null) {
      map['createdBy'] = createdBy?.toJson();
    }
    if (users != null) {
      map['user'] = users?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
