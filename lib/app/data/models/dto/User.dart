class UserData {
  String? userId;
  String? name;
  String? phone;
  String? email;
  String? profileUrl;

  UserData({
    this.userId,
    this.name,
    this.phone,
    this.email,
    this.profileUrl,
  });

  UserData.fromJson(dynamic json) {
    userId = json['userId'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    profileUrl = json['profileUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['profileUrl'] = this.profileUrl;
    return data;
  }
}
