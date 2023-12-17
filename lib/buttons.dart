import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;

  MyButton({this.color, this.textColor, required this.buttonText, this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            color: color,
              boxShadow: [
              const BoxShadow(
                color: Colors.black,
                offset: Offset(4, 4),
                blurRadius: 15,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.grey.shade800,
                offset: Offset(-1, -1),
                blurRadius: 15,
                spreadRadius: 1,
              )
            ]),
            child: Center(
                child: Text(
              buttonText,
              style: TextStyle(
                color: textColor,
                fontSize: 28,
              ),
            ))),
      ),
    );
  }
}
