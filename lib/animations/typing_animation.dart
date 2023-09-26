import 'package:flutter/material.dart';
import 'dart:async';

class TypeWriter extends StatefulWidget {
  final String text;

  TypeWriter({required this.text});

  @override
  _TypeWriterState createState() => _TypeWriterState();
}

class _TypeWriterState extends State<TypeWriter> {
  String displayedText = "";
  int index = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      if (index < widget.text.length) {
        setState(() {
          displayedText += widget.text[index];
          index++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 800,
      child: Text(
        displayedText,
        style: TextStyle(fontSize: 30, color: Colors.white),
      ),
    );
  }
}
