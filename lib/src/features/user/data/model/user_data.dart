import 'account.dart';
import 'group.dart';

class UserData {
  Account? account;
  String? email;
  String firstName;
  List<Group>? groups;
  int? id;
  bool? isActive;
  String lastName;
  String? phoneNumber;
  Object? profilePicture;
  String? status;
  String? username;
  String uuid;

  UserData({
    this.account,
    this.email,
    required this.firstName,
    this.groups,
    this.id,
    this.isActive,
    required this.lastName,
    this.phoneNumber,
    this.profilePicture,
    this.status,
    this.username,
    required this.uuid,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      account:
          json['account'] != null ? Account.fromJson(json['account']) : null,
      email: json['email'],
      firstName: json['first_name'],
      groups: json['groups'] != null
          ? (json['groups'] as List).map((i) => Group.fromJson(i)).toList()
          : null,
      id: json['id'],
      isActive: json['is_active'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      profilePicture:  json['profile_picture'],
      status: json['status'],
      username: json['username'],
      uuid: json['uuid'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['email'] = email;
    data['first_name'] = firstName;
    data['id'] = id;
    data['is_active'] = isActive;
    data['last_name'] = lastName;
    data['phone_number'] = phoneNumber;
    data['status'] = status;
    data['username'] = username;
    data['uuid'] = uuid;
    if (account != null) {
      data['account'] = account!.toJson();
    }
    if (groups != null) {
      data['groups'] = groups!.map((v) => v.toJson()).toList();
    }
    if (profilePicture != null) {
      data['profile_picture'] = profilePicture;
    }
    return data;
  }
}
