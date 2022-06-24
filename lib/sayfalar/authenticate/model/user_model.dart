import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String email;
  String userId;
  Timestamp? createdAt;
  String username;

  UserModel({
    required this.userId,
    required this.email,
    required this.username,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] as String,
      userId: json['uid'] as String,
      email: json['email'] as String,
      createdAt: json['created_at'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': userId,
        'email': email,
        'created_at': createdAt,
      };
}
