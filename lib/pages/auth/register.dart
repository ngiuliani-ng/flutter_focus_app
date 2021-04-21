import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:flutter_focus_app/utility/isValid.dart';

import 'package:flutter_focus_app/models/plansType.dart';

import 'package:flutter_focus_app/components/appFormField.dart';
import 'package:flutter_focus_app/components/appButton.dart';

class RegisterPage extends StatefulWidget {
  static String routeName = '/register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();

  File _userAvatar;
  bool _isPremiumAccount = false;
  PageController _pageController = PageController();
  int _pageIndex = 0;
  PlansType _selectedPlanType = PlansType.Base;

  String nameError;
  String surnameError;
  String emailError;
  String passwordError;
  String passwordConfirmError;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _pageIndex = _pageController.page.toInt();
      });
    });
  }

  void switchAccountType(bool value) {
    setState(() {
      _isPremiumAccount = value;
    });
  }

  void switchPlanType(PlansType type) {
    setState(() {
      _selectedPlanType = type;
    });
  }

  getPlanPrice() {
    switch (_selectedPlanType) {
      case PlansType.Base:
        return 1.99;
      case PlansType.Advanced:
        return 4.99;
      case PlansType.Pro:
        return 9.99;
      default:
        return 0.00;
    }
  }

  void onSubmit() {
    if (_pageIndex == 0) {
      final name = nameController.text.trim();
      final surname = surnameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final passwordConfirm = passwordConfirmController.text.trim();

      setState(() {
        nameError = null;
        surnameError = null;
        emailError = null;
        passwordError = null;
        passwordConfirmError = null;
      });

      final valid = isValidBlock((bool Function(bool, Function) when) {
        when(name.isEmpty, () => setState(() => nameError = 'Inserisci il nome'));
        when(surname.isEmpty, () => setState(() => surnameError = 'Inserisci il cognome'));
        when(email.isEmpty, () => setState(() => emailError = 'Inserisci un indirizzo email'));
        when(email.isNotEmpty && !isValidEmail(email), () => setState(() => emailError = 'Inserisci un indirizzo email valido'));
        when(password.isEmpty, () => setState(() => passwordError = 'Inserisci una password'));
        when(password.isNotEmpty && password.length < 8, () => setState(() => passwordError = 'Inserisci una password almeno di 8 caratteri'));
        when(passwordConfirm.isEmpty, () => setState(() => passwordConfirmError = 'Inserisci una password'));
        when(password.isNotEmpty && passwordConfirm.isEmpty && password != passwordConfirm,
            () => setState(() => passwordConfirmError = 'Le password non corrispondono'));
        when(password.isNotEmpty && passwordConfirm.isNotEmpty && password != passwordConfirm,
            () => setState(() => passwordConfirmError = 'Le password non corrispondono'));
      });

      if (valid && !_isPremiumAccount) {
        print('Registrazione Account Standard');
      } else if (valid && _isPremiumAccount) {
        _pageController.animateToPage(1, duration: Duration(milliseconds: 250), curve: Curves.linear);
      }
    } else if (_pageIndex == 1) {
      print('Registrazione Account Premium');
    }
  }

  void selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _userAvatar = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: PageView.builder(
        itemCount: 2,
        itemBuilder: (context, index) => index == 0 ? data() : plans(),
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Hai già un account?',
            style: TextStyle(
              color: Color(0xff1a73e8),
            ),
          ),
        ),
      ],
    );
  }

  Widget data() {
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
              'Crea il tuo account!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Inserisci i tuoi dati',
              style: TextStyle(
                color: Colors.black45,
              ),
            ),
            SizedBox(
              height: 64,
            ),
            GestureDetector(
              onTap: selectImage,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black12,
                      backgroundImage: _userAvatar == null ? null : FileImage(_userAvatar),
                      radius: 60,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Immagine',
                      style: TextStyle(
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            AppFormField(
              label: 'Nome',
              icon: Icons.person,
              textInputType: TextInputType.text,
              hintText: 'Nome',
              obscureText: false,
              controller: nameController,
              error: nameError,
            ),
            SizedBox(
              height: 32,
            ),
            AppFormField(
              label: 'Cognome',
              icon: Icons.person,
              textInputType: TextInputType.text,
              hintText: 'Cognome',
              obscureText: false,
              controller: surnameController,
              error: surnameError,
            ),
            SizedBox(
              height: 32,
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
              height: 32,
            ),
            AppFormField(
              label: 'Conferma Password',
              icon: Icons.lock,
              textInputType: TextInputType.text,
              hintText: 'Conferma Password',
              obscureText: true,
              controller: passwordConfirmController,
              error: passwordConfirmError,
            ),
            SizedBox(
              height: 32,
            ),
            SwitchListTile(
              activeColor: Color(0xff1a73e8),
              title: Text(
                'Registra un account premium',
                style: TextStyle(
                  color: Colors.black45,
                ),
              ),
              contentPadding: EdgeInsets.all(0),
              value: _isPremiumAccount,
              onChanged: (value) => switchAccountType(value),
            ),
            SizedBox(
              height: 64,
            ),
            AppButton(
              color: Color(0xff1a73e8),
              child: Text(_isPremiumAccount ? 'Personalizza il tuo account' : 'Crea il tuo account'),
              onPressed: onSubmit,
            ),
          ],
        ),
      ),
    );
  }

  Widget plans() {
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
              'Scegli il tuo piano!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Seleziona i tuoi vantaggi',
              style: TextStyle(
                color: Colors.black45,
              ),
            ),
            SizedBox(
              height: 64,
            ),
            buildRadioListTile(
              title: 'Piano Base',
              subtitle: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
              value: PlansType.Base,
            ),
            SizedBox(
              height: 32,
            ),
            buildRadioListTile(
              title: 'Piano Advanced',
              subtitle: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
              value: PlansType.Advanced,
            ),
            SizedBox(
              height: 32,
            ),
            buildRadioListTile(
              title: 'Piano Pro',
              subtitle: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
              value: PlansType.Pro,
            ),
            SizedBox(
              height: 64,
            ),
            AppButton(
              color: Color(0xff1a73e8),
              child: Text('Attiva il tuo piano | € ${getPlanPrice()}'),
              onPressed: onSubmit,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRadioListTile({
    @required String title,
    @required String subtitle,
    @required PlansType value,
  }) {
    return RadioListTile(
      activeColor: Color(0xff1a73e8),
      value: value,
      groupValue: _selectedPlanType,
      onChanged: (type) => switchPlanType(type),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle),
    );
  }
}
