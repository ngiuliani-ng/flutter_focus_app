import 'package:flutter/material.dart';

class AppFormField extends StatelessWidget {
  /// Custom Components.
  AppFormField({
    @required this.label,
    @required this.icon,
    @required this.textInputType,
    @required this.hintText,
    @required this.obscureText,
  });

  final String label;
  final IconData icon;
  final TextInputType textInputType;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black45,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black26,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.black45,
                size: 22,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextFormField(
                  keyboardType: textInputType,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                  ),
                  obscureText: obscureText,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
