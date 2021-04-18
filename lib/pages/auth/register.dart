import 'package:flutter/material.dart';

import 'package:flutter_focus_app/models/plansType.dart';

import 'package:flutter_focus_app/components/appFormField.dart';
import 'package:flutter_focus_app/components/appButton.dart';

class RegisterPage extends StatefulWidget {
  static String routeName = '/register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isPremiumAccount = false;
  PageController _pageController = PageController();
  int _pageIndex = 0;
  PlansType _selectedPlansType = PlansType.Base;

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

  void switchPlansType(PlansType type) {
    setState(() {
      _selectedPlansType = type;
    });
  }

  getPlansPrice() {
    switch (_selectedPlansType) {
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

  void onSubmitData() {
    if (!_isPremiumAccount && _pageIndex == 0) {
      print('Registrazione Standard');
    } else if (_isPremiumAccount && _pageIndex == 0) {
      _pageController.animateToPage(1, duration: Duration(milliseconds: 250), curve: Curves.linear);
    } else if (_isPremiumAccount && _pageIndex == 1) {
      print('Registrazione Premium');
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
              color: Colors.black45,
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
              'Inserisci i dati richiesti per creare il tuo account',
              style: TextStyle(
                color: Colors.black45,
              ),
            ),
            SizedBox(
              height: 64,
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black12,
                    maxRadius: 48,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Carica immagine',
                    style: TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                ],
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
              height: 32,
            ),
            AppFormField(
              label: 'Conferma Password',
              icon: Icons.lock,
              textInputType: TextInputType.text,
              hintText: 'Conferma Password',
              obscureText: true,
            ),
            SizedBox(
              height: 32,
            ),
            SwitchListTile(
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
              color: Colors.blue,
              child: Text(_isPremiumAccount ? 'Personalizza il tuo account' : 'Crea il tuo account'),
              onPressed: onSubmitData,
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
              'A seconda del piano scelto avrai diversi vantaggi',
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
              color: Colors.blue,
              child: Text('Attiva il tuo piano | € ${getPlansPrice()}'),
              onPressed: onSubmitData,
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
      value: value,
      groupValue: _selectedPlansType,
      onChanged: (type) => switchPlansType(type),
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
