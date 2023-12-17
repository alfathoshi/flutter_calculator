import 'dart:ui';
import 'dart:math' as math;
import 'package:firstly/buttons.dart';
import 'package:firstly/theme/darkmode.dart';
import 'package:firstly/theme/lightmode.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      darkTheme: darkTheme,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '';

  final myTextStyle = TextStyle(fontSize: 30, color: Colors.grey[900]);

  final List<String> buttons = [
    'AC',
    'C',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '00',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(userQuestion, style: TextStyle(fontSize: 50))),
                Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(userAnswer, style: TextStyle(fontSize: 50)))
              ],
            )),
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 24, top: 24, right: 24, bottom: 50),
                child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20),
                        //color: Colors.grey[800],
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.grey.shade800.withOpacity(0.5),
                            Colors.grey.shade800.withOpacity(0.1)
                          ]
                        ) 
                        ),
                    child: GridView.builder(
                        itemCount: buttons.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return MyButton(
                              buttonTapped: () {
                                setState(() {
                                  userQuestion = '';
                                  userAnswer = '';
                                });
                              },
                              buttonText: buttons[index],
                              color: Colors.grey[900],
                              textColor: isOperator(buttons[index])
                                  ? Colors.black
                                  : Colors.white,
                            );
                          } else if (index == 1) {
                            return MyButton(
                              buttonTapped: () {
                                setState(() {
                                  userQuestion = userQuestion.substring(
                                      0, userQuestion.length - 1);
                                });
                              },
                              buttonText: buttons[index],
                              color: Colors.grey[900],
                              textColor: isOperator(buttons[index])
                                  ? Colors.black
                                  : Colors.white,
                            );
                          } else if (index == buttons.length - 1) {
                            return MyButton(
                              buttonTapped: () {
                                setState(() {
                                  equalPressed();
                                });
                              },
                              buttonText: buttons[index],
                              color: isOperator(buttons[index])
                                  ? Colors.orange.shade400
                                  : Colors.orange.shade400,
                              textColor: isOperator(buttons[index])
                                  ? Colors.white
                                  : Colors.white,
                            );
                          } else {
                            return MyButton(
                              buttonTapped: () {
                                setState(() {
                                  
                                  userQuestion += buttons[index];
                                });
                              },
                              buttonText: buttons[index],
                              color: isOperator(buttons[index])
                                  ? Colors.orange.shade400
                                  : Colors.grey[900],
                              textColor: isOperator(buttons[index])
                                  ? Colors.white
                                  : Colors.white,
                            );
                          }
                        })),
              ))
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' ||
        x == '/' ||
        x == 'x' ||
        x == '+' ||
        x == '-' ||
        x == '-' ||
        x == '=') {
      return true;
    }
    return false;
  }


  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
    if (userAnswer.endsWith('.0')) userAnswer = userAnswer.replaceAll('.0', '');
  }
}
