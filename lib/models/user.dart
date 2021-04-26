import 'package:flutter/material.dart';

class UserModel {
  final String fullName;
  final String email;
  final String avatarUrl;

  UserModel({
    @required this.fullName,
    @required this.email,
    @required this.avatarUrl,
  });

  factory UserModel.fromData(dynamic data) {
    final fullName = data['fullName'];
    final email = data['email'];
    final avatarUrl = data['avatarUrl'];

    return UserModel(
      fullName: fullName,
      email: email,
      avatarUrl: avatarUrl,
    );
  }
}
