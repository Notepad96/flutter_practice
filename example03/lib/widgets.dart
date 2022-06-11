import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors

typedef CallbackSetting = void Function(String, int);

class ProductivityButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final VoidCallback onPressed;

  ProductivityButton(
      {required this.color,
      required this.text,
      required this.onPressed,
      this.size = 0});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      minWidth: size,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  final Color color;
  final String text;
  final int value;

  final double size;
  final String setting;
  final CallbackSetting callback;

  SettingsButton(this.color, this.text, this.value, this.size, this.setting, this.callback);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: size,
      onPressed: () => callback(setting, value),
      color: color,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
