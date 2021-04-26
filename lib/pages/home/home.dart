import 'package:flutter/material.dart';

import 'package:flutter_focus_app/repositories/repository.dart';

import 'package:flutter_focus_app/models/user.dart';

import 'package:flutter_focus_app/pages/auth/login.dart';

import 'package:flutter_focus_app/main.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void logout() async {
    getIt.get<Repository>().sessionRepository.logout();
    await Navigator.popAndPushNamed(context, LoginPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final UserModel userData = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: appBar(userData),
      body: body(),
    );
  }

  Widget appBar(UserModel userData) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      titleSpacing: 0,
      leading: Center(
        child: CircleAvatar(
          backgroundColor: Colors.black12,
          backgroundImage: NetworkImage(userData.avatarUrl),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userData.fullName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            userData.email,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black45,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: logout,
        ),
      ],
    );
  }

  Widget body() {
    return Container(
      color: Colors.grey.shade100,
    );
  }
}
