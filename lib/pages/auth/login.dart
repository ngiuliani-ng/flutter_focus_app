import 'package:flutter/material.dart';

import 'package:flutter_focus_app/components/appFormField.dart';
import 'package:flutter_focus_app/components/appButton.dart';

class LoginPage extends StatelessWidget {
  static String routeName = '/login';

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
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(
            'Non hai ancora un account?',
            style: TextStyle(
              color: Colors.black45,
            ),
          ),
        ),
      ],
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            Text(
              'Ben ritornato!',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Inserisci le tue credenziali per continuare',
              style: TextStyle(
                color: Colors.black45,
              ),
            ),
            SizedBox(
              height: 64,
            ),
            AppFormField(
              label: 'Email',
              icon: Icons.person,
              textInputType: TextInputType.emailAddress,
              hintText: 'Email',
              obscureText: false,
            ),
            SizedBox(
              height: 32,
            ),
            AppFormField(
              label: 'Password',
              icon: Icons.lock,
              textInputType: TextInputType.text,
              hintText: 'Password',
              obscureText: true,
            ),
            SizedBox(
              height: 64,
            ),
            AppButton(
              color: Colors.blue,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
