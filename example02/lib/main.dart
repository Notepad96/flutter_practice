import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final Map<String, int> _measuresMap = {
    'meters': 0,
    'kilometers': 1,
    'grams': 2,
    'kilogram': 3,
    'feet': 4,
    'miles': 5,
    'pounds (lbs)': 6,
    'ounces': 7,
  };
  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilogram',
    'feet',
    'miles',
    'pounds(lbs)',
    'ounces'
  ];
  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };

  late double _numberFrom;
  late String _startMeasure;
  late String _convertedMeasure;

  // ============== Style Top ==============
  final TextStyle inputStyle = TextStyle(
    fontSize: 20,
    color: Colors.blue[900],
  );
  final TextStyle labelStyle = TextStyle(
    fontSize: 24,
    color: Colors.grey[700],
  );

  // ============== Style Bottom ==============

  @override
  void initState() {
    _numberFrom = 0;
    _startMeasure = 'meters';
    _convertedMeasure = 'meters';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Mile Converter',
        home: Scaffold(
            appBar: AppBar(
              title: Text('Mile Converter'),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    'Value',
                    style: labelStyle,
                  ),
                  Spacer(),
                  TextField(
                    style: inputStyle,
                    decoration:
                        InputDecoration(hintText: 'Please insert measure'),
                    onChanged: (text) {
                      var rv = double.tryParse(text);
                      if (rv != null) {
                        setState(() {
                          _numberFrom = rv;
                        });
                      }
                    },
                  ),
                  Spacer(),
                  Text(
                    'From',
                    style: labelStyle,
                  ),
                  DropdownButton(
                    value: _startMeasure,
                    isExpanded: true,
                    items: _measures.map((value) {
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: inputStyle,
                          ));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _startMeasure = value.toString();
                      });
                    },
                  ),
                  Spacer(),
                  Text(
                    "To",
                    style: labelStyle,
                  ),
                  DropdownButton(
                    value: _convertedMeasure,
                    isExpanded: true,
                    items: _measures.map((value) {
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: inputStyle,
                          ));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _convertedMeasure = value.toString();
                      });
                    },
                  ),
                  Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        if (_startMeasure.isEmpty ||
                            _convertedMeasure.isEmpty ||
                            _numberFrom == 0) {
                          return;
                        } else {
                          convert(
                              _numberFrom, _startMeasure, _convertedMeasure);
                        }
                      },
                      child: Text(
                        'Convert',
                        style: inputStyle,
                      )),
                  Spacer(
                    flex: 2,
                  ),
                  Text(
                    (_resultMessage == null) ? '' : _resultMessage,
                    style: labelStyle,
                  ),
                  Spacer(
                    flex: 8,
                  ),
                ],
              ),
            )));
  }

  String _resultMessage = '';

  void convert(double value, String from, String to) {
    int nFrom = _measuresMap[from] ?? 0;
    int nTo = _measuresMap[to] ?? 0;
    var multiplier = _formulas[nFrom.toString()][nTo];
    var result = value * multiplier;

    if (result == 0) {
      _resultMessage = 'This conversion cannot be performed';
    } else {
      _resultMessage =
          '$_numberFrom $_startMeasure are $result $_convertedMeasure';
    }
    setState(() {
      _resultMessage = _resultMessage;
    });
  }
}
