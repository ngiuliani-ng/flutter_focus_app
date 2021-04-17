import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_focus_app/pages/auth/splash.dart';
import 'package:flutter_focus_app/pages/auth/login.dart';

void main() {
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
        /// Modificando il [primaryColor] con [Colors.White] possono eliminare [statusBarIconBrightness: Brightness.dark].
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: {
        SplashPage.routeName: (_) => SplashPage(),
        LoginPage.routeName: (_) => LoginPage(),
      },
      initialRoute: LoginPage.routeName,
    );
  }
}
