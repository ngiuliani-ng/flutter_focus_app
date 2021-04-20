import 'package:flutter/material.dart';

import 'package:flutter_focus_app/utility/isValid.dart';

import 'package:flutter_focus_app/pages/auth/register.dart';

import 'package:flutter_focus_app/components/appFormField.dart';
import 'package:flutter_focus_app/components/appButton.dart';

class LoginPage extends StatefulWidget {
  static String routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String emailError;
  String passwordError;

  void onSubmit() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Reset error.
    setState(() {
      emailError = null;
      passwordError = null;
    });

    final valid = isValidBlock((bool Function(bool, Function) when) {
      when(email.isEmpty, () => setState(() => emailError = 'Campo obbligatorio'));
      when(email.isNotEmpty && !isValidEmail(email), () => setState(() => emailError = 'Email non valida'));
      when(password.isEmpty, () => setState(() => passwordError = 'Campo obbligatorio'));
    });

    // bool valid = true;
    //
    // setState(() {
    //   emailError = null;
    //   passwordError = null;
    // });
    //
    // if (email.isEmpty) {
    //   setState(() {
    //     emailError = 'Campo obbligatorio';
    //     valid = false;
    //   });
    // }
    //
    // if (password.isEmpty) {
    //   setState(() {
    //     passwordError = 'Campo obbligatorio';
    //     valid = false;
    //   });
    // }

    if (valid) {
      print('Login');
    }
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
      actions: [
        TextButton(
          onPressed: () => Navigator.pushNamed(context, RegisterPage.routeName),
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
      /// Qui il [Padding] è stato incapsulato all'interno del [SingleChildScrollView]
      /// per risolvere il problema della sovrapposizione della tastiera virtuale sull'[AppButton].
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            Text(
              'Bentornato!',
              style: TextStyle(
                fontSize: 30,
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
              icon: Icons.email,
              textInputType: TextInputType.emailAddress,
              hintText: 'Email',
              obscureText: false,
              controller: emailController,
              error: emailError,
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
              controller: passwordController,
              error: passwordError,
            ),
            SizedBox(
              height: 64,
            ),
            AppButton(
              color: Colors.blue,
              child: Text('Login'),
              onPressed: onSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
