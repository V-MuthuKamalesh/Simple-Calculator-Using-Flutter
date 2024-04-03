import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _displayText = '';
  double _firstNumber = 0;
  double _secondNumber = 0;
  String _operation = '';
  bool _isResultDisplayed = false;

  void _clear() {
    setState(() {
      _displayText = '';
      _firstNumber = 0;
      _secondNumber = 0;
      _operation = '';
      _isResultDisplayed = false;
    });
  }

  void _calculateResult() {
    double result = 0;
    if (_operation == '+') {
      result = _firstNumber + _secondNumber;
    } else if (_operation == '-') {
      result = _firstNumber - _secondNumber;
    } else if (_operation == '*') {
      result = _firstNumber * _secondNumber;
    } else if (_operation == '/') {
      if (_secondNumber != 0) {
        result = _firstNumber / _secondNumber;
      } else {
        result = double.nan;
      }
    }
    setState(() {
      _displayText = result.toString();
      _isResultDisplayed = true;
    });
  }

  void _appendToDisplay(String value) {
    if (_isResultDisplayed) {
      _displayText = '';
      _isResultDisplayed = false;
    }
    setState(() {
      _displayText += value;
    });
  }

  void _setOperation(String op) {
    _firstNumber = double.parse(_displayText);
    _operation = op;
    _displayText = '';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculator'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.all(20),
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Result',
                  ),
                  controller: TextEditingController(text: _displayText),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
                _buildOperationButton('/'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('4'),
                _buildButton('5'),
                _buildButton('6'),
                _buildOperationButton('*'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
                _buildOperationButton('-'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('0'),
                _buildButton('.'),
                _buildEqualsButton(),
                _buildOperationButton('+'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildClearButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return ElevatedButton(
      onPressed: () {
        _appendToDisplay(buttonText);
      },
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 24),
      ),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(80, 80)),
      ),
    );
  }

  Widget _buildOperationButton(String operation) {
    return ElevatedButton(
      onPressed: () {
        _setOperation(operation);
      },
      child: Text(
        operation,
        style: TextStyle(fontSize: 24),
      ),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(80, 80)),
      ),
    );
  }

  Widget _buildEqualsButton() {
    return ElevatedButton(
      onPressed: () {
        if (_displayText.isNotEmpty) {
          _secondNumber = double.parse(_displayText);
          _calculateResult();
        }
      },
      child: Text(
        '=',
        style: TextStyle(fontSize: 24),
      ),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(80, 80)),
      ),
    );
  }

  Widget _buildClearButton() {
    return ElevatedButton(
      onPressed: () {
        _clear();
      },
      child: Text(
        'C',
        style: TextStyle(fontSize: 24),
      ),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(80, 80)),
      ),
    );
  }
}
