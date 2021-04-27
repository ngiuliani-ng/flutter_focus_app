import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_focus_app/repositories/repository.dart';

import 'package:flutter_focus_app/pages/home/home.dart';
import 'package:flutter_focus_app/pages/auth/login.dart';

import 'package:flutter_focus_app/components/appButton.dart';

import 'package:flutter_focus_app/main.dart';

class SplashPage extends StatefulWidget {
  static String routeName = '/splash';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await getIt.get<Repository>().sessionRepository.init();
      bool isLogged = getIt.get<Repository>().sessionRepository.isLogged();

      if (isLogged) {
        await Future.delayed(Duration(seconds: 2));
        await Navigator.popAndPushNamed(context, HomePage.routeName); // Elimino e sostituisco la schermata corrente.
      } else {
        await Future.delayed(Duration(seconds: 2));
        await Navigator.popAndPushNamed(context, LoginPage.routeName); // Elimino e sostituisco la schermata corrente.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/splashPage-bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(32),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lavoriamo\nInsieme',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Funziona tutto meglio quando si collabora.',
                    style: TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  AppButton(
                    color: Colors.black,
                    child: SizedBox(
                      height: 25,
                      width: 25,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          accentColor: Colors.white,
                        ),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
