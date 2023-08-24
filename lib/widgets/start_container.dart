import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ko/main.dart';
import 'package:ko/screens/body2.dart';
import '../constants.dart';
import '../screens/part/question_part.dart';
import '../screens/start_page.dart';
import 'package:ko/screens/part/answer_part.dart';

class StartContainer extends StatefulWidget {
  const StartContainer({Key? key}) : super(key: key);

  @override
  State<StartContainer> createState() => _StartContainerState();
}

class _StartContainerState extends State<StartContainer>
    with QuestionPage, AnswerPage {
  int firstQuestion = Random().nextInt(30) + 1;
  int firstAnswer = Random().nextInt(30) + 1;
  final String text = 'Başlat';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/arka.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StartHexagon('K'),
                StartHexagon('E'),
                StartHexagon('L'),
                StartHexagon('İ'),
                StartHexagon('M'),
                StartHexagon('E'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StartHexagon('O'),
                StartHexagon('Y'),
                StartHexagon('U'),
                StartHexagon('N'),
                StartHexagon('U'),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: nextPage,
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  textStyle: TextStyle(color: redColor),
                  backgroundColor: backgroundColor,
                  shape: const StadiumBorder(),
                ),
                child: Text(text,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 18))),
          ],
        ),
      ),
    );
  }

  nextPage() async {
    toplamPuan = 0;
    var soru = await printFirestoreDocument('dort-harfli', '$firstQuestion');
    var cevap = await printAnswerDocument('dort-harfli', '$firstQuestion');
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Body2(
                    question: soru,
                    answer: cevap,
                    seconds: 240,
                  )));
      print(++soruSayisi);
    });
  }
}
