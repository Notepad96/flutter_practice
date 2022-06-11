import 'package:example03/settings.dart';
import 'package:flutter/material.dart';
import 'package:example03/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import './timer.dart';
import './timerModel.dart';
import './settings.dart';
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
  double defaultPadding = 5.0;
  final CountDownTimer countTime = CountDownTimer();

  @override
  Widget build(BuildContext context) {
    countTime.startWork();
    final List<PopupMenuItem<String>> menuItems = [];
    menuItems.add(PopupMenuItem(value: 'Settings', child: Text('Settings')));

    return Scaffold(
        appBar: AppBar(
          title: Text('My Work Timer'),
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return menuItems.toList();
              },
              onSelected: (s) {
                if (s == 'Settings') {
                  goToSettings(context);
                }
              },
            )
          ],
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          double availableWidth = constraints.maxWidth;
          return Column(children: [
            Row(children: [
              Padding(padding: EdgeInsets.all(defaultPadding)),
              Expanded(
                  child: ProductivityButton(
                color: Color(0xff009688),
                text: "Work",
                onPressed: () => countTime.startWork(),
              )),
              Padding(padding: EdgeInsets.all(defaultPadding)),
              Expanded(
                  child: ProductivityButton(
                color: Color(0xff607D8b),
                text: "Short Break",
                onPressed: () => countTime.startBreak(true),
              )),
              Padding(padding: EdgeInsets.all(defaultPadding)),
              Expanded(
                  child: ProductivityButton(
                color: Color(0xff455a64),
                text: "Long Break",
                onPressed: () => countTime.startBreak(false),
              )),
              Padding(padding: EdgeInsets.all(defaultPadding)),
            ]),
            Expanded(
                child: StreamBuilder(
              initialData: '00:00',
              stream: countTime.stream(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                TimerModel timer = (snapshot.data == '00:00')
                    ? TimerModel('00:00', 1)
                    : snapshot.data;
                return Container(
                  child: CircularPercentIndicator(
                    radius: availableWidth / 4,
                    lineWidth: 10.0,
                    percent: timer.percent,
                    center: Text(
                      "30:00",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    progressColor: Color(0xff009688),
                  ),
                );
              },
            )),
            Row(
              children: [
                Padding(padding: EdgeInsets.all(defaultPadding)),
                Expanded(
                    child: ProductivityButton(
                  color: Color(0xff212121),
                  text: 'Stop',
                  onPressed: () => countTime.stopTimer(),
                )),
                Padding(padding: EdgeInsets.all(defaultPadding)),
                Expanded(
                    child: ProductivityButton(
                  color: Color(0xff009688),
                  text: 'Restart',
                  onPressed: () => countTime.startTimer(),
                )),
                Padding(padding: EdgeInsets.all(defaultPadding)),
              ],
            ),
          ]);
        }));
  }

  void goToSettings(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsScreen()));
  }
}
