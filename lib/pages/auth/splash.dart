import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  static String routeName = '/splash';

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
                  MaterialButton(
                    height: 50,
                    minWidth: double.infinity,
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
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
