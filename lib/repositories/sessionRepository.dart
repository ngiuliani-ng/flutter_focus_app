import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_focus_app/repositories/repository.dart';

class SessionRepository {
  Repository repository;

  SessionRepository(this.repository);

  String token;

  void init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    this.token = sharedPreferences.getString('TOKEN');
  }

  void setToken({@required String token}) async {
    this.token = token;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('TOKEN', token);
  }

  bool isLogged() {
    return this.token != null;
  }
}
