import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  /// Custom Components.
  AppButton({
    @required this.color,
    @required this.child,
    @required this.onPressed,
  });

  final Color color;
  final Widget child;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 50,
      minWidth: double.infinity,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: child,
      textColor: Colors.white,
      onPressed: onPressed,
    );
  }
}
