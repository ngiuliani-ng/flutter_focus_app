import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get_it/get_it.dart';

import 'package:flutter_focus_app/repositories/repository.dart';

import 'package:flutter_focus_app/pages/auth/splash.dart';
import 'package:flutter_focus_app/pages/auth/login.dart';
import 'package:flutter_focus_app/pages/auth/register.dart';
import 'package:flutter_focus_app/pages/home/home.dart';

final getIt = GetIt.instance;

void main() {
  getIt.registerSingleton(Repository());

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        /// Modificando il [primaryColor] con [Colors.White] posso eliminare [statusBarIconBrightness: Brightness.dark].
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: {
        SplashPage.routeName: (_) => SplashPage(),
        LoginPage.routeName: (_) => LoginPage(),
        RegisterPage.routeName: (_) => RegisterPage(),
        HomePage.routeName: (_) => HomePage(),
      },
      initialRoute: SplashPage.routeName,
    );
  }
}
