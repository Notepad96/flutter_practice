import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Work Timer',
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        home: TimerHomePage());
  }
}


class TimerHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Work Timer'),
        ),
        body: Center(
          child: Column(),
        ));
  }
}