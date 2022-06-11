import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './widgets.dart';
// ignore_for_file: prefer_const_constructors

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Settings());
  }
}

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextStyle textStyle = TextStyle(fontSize: 24);
  late TextEditingController txtWork;
  late TextEditingController txtShort;
  late TextEditingController txtLong;
  static const String WORKTIMWE = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";

  late SharedPreferences prefs;
  double buttonSize = 10.0;

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 3,
        scrollDirection: Axis.vertical,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          Text("Work", style: textStyle),
          Text(""),
          Text(""),
          SettingsButton(
              Color(0xff455a64), "-", -1, buttonSize, WORKTIMWE, updateSetting),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtWork,
          ),
          SettingsButton(
              Color(0xff009688), "+", 1, buttonSize, WORKTIMWE, updateSetting),
          Text(
            "Short",
            style: textStyle,
          ),
          Text(""),
          Text(""),
          SettingsButton(Color(0xff455a64), "-", -1, buttonSize, SHORTBREAK,
              updateSetting),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtShort,
          ),
          SettingsButton(
              Color(0xff009688), "+", 1, buttonSize, SHORTBREAK, updateSetting),
          Text(
            "Long",
            style: textStyle,
          ),
          Text(""),
          Text(""),
          SettingsButton(
              Color(0xff455a64), "-", -1, buttonSize, LONGBREAK, updateSetting),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtLong,
          ),
          SettingsButton(
              Color(0xff009688), "+", 1, buttonSize, LONGBREAK, updateSetting),
        ],
      ),
    );
  }

  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    if(prefs.getInt(WORKTIMWE) == null) {
      prefs.setInt(WORKTIMWE, 30);
    }
    int workTime = prefs.getInt(WORKTIMWE)!;

    if(prefs.getInt(SHORTBREAK) == null) {
      prefs.setInt(SHORTBREAK, 5);
    }
    int shortBreak = prefs.getInt(SHORTBREAK)!;

    if(prefs.getInt(LONGBREAK) == null) {
      prefs.setInt(LONGBREAK, 20);
    }
    int longBreak = prefs.getInt(LONGBREAK)!;

    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  void updateSetting(String key, int value) {
    switch (key) {
      case WORKTIMWE:
        {
          int workTime = prefs.getInt(WORKTIMWE)!;
          workTime += value;
          if (workTime >= 1 && workTime <= 180) {
            prefs.setInt(WORKTIMWE, workTime);
            setState(() {
              txtWork.text = workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          int short = prefs.getInt(SHORTBREAK)!;
          short += value;
          if (short >= 1 && short <= 180) {
            prefs.setInt(SHORTBREAK, short);
            setState(() {
              txtShort.text = short.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          int long = prefs.getInt(LONGBREAK)!;
          long += value;
          if (long >= 1 && long <= 180) {
            prefs.setInt(LONGBREAK, long);
            setState(() {
              txtLong.text = long.toString();
            });
          }
        }
        break;
    }
  }
}
