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
  Future<UserModel> downloadProfile() async {
    return await getIt.get<Repository>().userRepository.profile();
  }

  void logout() async {
    getIt.get<Repository>().sessionRepository.logout();
    await Navigator.popAndPushNamed(context, LoginPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  Widget appBar() {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      titleSpacing: 0,
      leading: FutureBuilder(
        future: downloadProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final user = snapshot.data;
            return Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.avatarUrl),
              ),
            );
          } else {
            return Center(
              child: CircleAvatar(
                backgroundColor: Colors.black12,
              ),
            );
          }
        },
      ),
      title: FutureBuilder(
        future: downloadProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final user = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  user.email,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                ),
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                loadingContainer(height: 20), // [height] = [fontSize] -> [user.fullName].
                SizedBox(
                  height: 4,
                ),
                loadingContainer(height: 12), // [height] = [fontSize] -> [user.email].
              ],
            );
          }
        },
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

  Widget loadingContainer({
    @required double height,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(height / 4),
      ),
    );
  }
}
