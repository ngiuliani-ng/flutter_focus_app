import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_focus_app/pages/auth/splashPage.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        SplashPage.routeName: (_) => SplashPage(),
      },
      initialRoute: SplashPage.routeName,
    );
  }
}
