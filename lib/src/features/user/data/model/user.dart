import 'user_data.dart';

class User {
  String accessToken;
  String refreshToken;
  String tenantUUID;
  UserData? userData;
  String uuid;

  User({
    required this.accessToken,
    required this.refreshToken,
    required this.tenantUUID,
    required this.userData,
    required this.uuid,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      tenantUUID: json['tenant_uuid'],
      userData: json['user'] != null ? UserData.fromJson(json['user']) : null,
      uuid: json['uuid'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['tenant_uuid'] = tenantUUID;
    data['uuid'] = uuid;
    if (userData != null) {
      data['user'] = userData!.toJson();
    }
    return data;
  }
}
