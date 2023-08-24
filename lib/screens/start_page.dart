import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ko/main.dart';
import 'package:ko/screens/body2.dart';
import 'package:ko/screens/part/answer_part.dart';
import 'package:ko/screens/part/hexagon_painter.dart';
//import 'package:ko/screens/part/question_part.dart';
import 'package:ko/widgets/start_container.dart';
import '../constants.dart';

class StartPage extends StatefulWidget {
  const StartPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

String tp = '0';

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor,
      body: const StartContainer(),
    );
  }
}

class StartHexagon extends StatelessWidget {
  String letter = '';
  StartHexagon(this.letter, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.transparent,
      child: CustomPaint(
        painter: HexagonPainter(),
        child: Center(
          child: Text(
            letter,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
