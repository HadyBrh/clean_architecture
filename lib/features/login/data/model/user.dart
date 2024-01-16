class User {
  int id;
  String username;
  String firstname;
  String lastname;
  String? bio;
  String? photo;
  bool active;

  User({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    this.bio,
    this.photo,
    required this.active,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      bio: json['bio'],
      photo: json['photo'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'bio': bio,
      'photo': photo,
      'active': active,
    };
  }
}
