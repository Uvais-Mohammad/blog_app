import 'dart:convert';

class User {
  final String uid;
  final String email;
  final String? userName;
  final String? profilePhoto;
  User({
    this.userName,
    required this.uid,
    required this.email,
    this.profilePhoto,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'userName': userName,
      'profilePhoto': profilePhoto,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] as String,
      uid: map['uid'] as String,
      userName: map['userName'] as String,
      profilePhoto: map['profilePhoto'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
