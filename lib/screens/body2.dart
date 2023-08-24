import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ko/screens/part/answer_part.dart';
import 'package:ko/screens/part/hexagon_painter.dart';
import 'package:ko/screens/part/question_part.dart';
import '../../constants.dart';
import '../../main.dart';
import 'end_page.dart';

class Body2 extends StatefulWidget {
  var question;
  var answer;
  final int seconds;
  Body2({this.question, this.answer, required this.seconds});

  @override
  State<Body2> createState() => Body2State();
}

class Body2State extends State<Body2> with QuestionPage, AnswerPage {
  int randomNumber = 0;
  int previousNumber = 0;

  String harfAl = 'Harf Al';
  final String appbarText = 'Kelime Oyunu';

  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  int previousLenght = 0;

  late Timer _timer;
  int _remainingSeconds = 0;
  int yazanPuan = 0;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.seconds;
    yazanPuan = widget.answer.toString().length * 100;
    _controllers = List<TextEditingController>.generate(
        widget.answer.toString().length, (index) => TextEditingController());
    _focusNodes = List<FocusNode>.generate(
        widget.answer.toString().length, (index) => FocusNode());

    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.length == 1) {
          if (i != _controllers.length - 1) {
            _focusNodes[i].unfocus();
            _focusNodes[i + 1].requestFocus();
          }
        } else if (_controllers[i].text.isEmpty) {
          if (i != 0) {
            _focusNodes[i].unfocus();
            _focusNodes[i - 1].requestFocus();
          }
        }
        previousLenght = _controllers[i].text.length;
        //print("Harf: ${_controllers[i].text}, Index: $i");
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    startTimer();
  }

  @override
  void deactivate() {
    _timer.cancel();
    super.deactivate();
  }

  @override
  void dispose() {
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].dispose();
      _focusNodes[i].dispose();
    }
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          if (_remainingSeconds < 1) {
            timer.cancel();
          } else {
            _remainingSeconds = _remainingSeconds - 1;
          }
        });
      },
    );
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    String minutesStr = (minutes < 10) ? '0$minutes' : '$minutes';
    String secondsStr =
        (remainingSeconds < 10) ? '0$remainingSeconds' : '$remainingSeconds';

    return '$minutesStr:$secondsStr';
  }

  int harfal = 0;

  harfAlButonuTiklandi() {
    harfal = generateRandomNumber(_controllers.length - 1);
    print(harfal);

    for (int i = 0; i < _controllers.length; i++) {
      if (i == harfal) {
        var deneme = alinanHarf(harfal, widget.answer.toString());
        // _controllers[harfal] = TextEditingController(text: "$deneme");
        // print(_controllers[harfal]);
        print(deneme);
        return deneme;
      }
    }
  }

  alinanHarf(int random, String cevap) {
    var kelime = cevap.toString().split('');
    for (int i = 0; i < cevap.length; i++) {
      var harf = kelime[random];
      return harf;
    }
  }

  String getWord(List<TextEditingController> controllers) {
    String word = '';
    for (var controller in controllers) {
      word += controller.text;
    }
    return word;
  }

  generateRandomNumber(int harfSayisi) {
    previousNumber = randomNumber;
    // Rastgele sayı üretme işlemi
    Random random = Random();
    do {
      randomNumber = random.nextInt(harfSayisi) + 1;
    } while (randomNumber == previousNumber);
    return randomNumber;
  }

  void alinanHarfteDusenPuan(int harfSayisi) {
    yazanPuan = (harfSayisi) * 100;
    print(yazanPuan);
  }

  void puanHesaplama(int gelenPuan) {
    print(gelenPuan); //3
    // if (gelenPuan < (widget.answer.toString().length)*100) {
    // } else

    if (gelenPuan < 0) {
      toplamPuan += yazanPuan;
    } else if (gelenPuan == 0) {
      toplamPuan += 0;
    } else {
      toplamPuan += gelenPuan;
    }
  }

  @override
  Widget build(BuildContext context) {
    int dortharfli = generateRandomNumber(30);
    int besharfli = generateRandomNumber(30);
    int altiharfli = generateRandomNumber(30);
    int yediharfli = generateRandomNumber(30);
    int sekizharfli = generateRandomNumber(30);
    int dokuzharfli = generateRandomNumber(30);
    int onharfli = generateRandomNumber(30);
    int qScore = widget.answer.toString().length;

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(appbarText),
          ),
          backgroundColor: redColor,
          elevation: 4),
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 25),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: score,
                    height: 20,
                    width: 50,
                    child: Center(
                      child: Text(toplamPuan.toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Container(
                    decoration:
                        BoxDecoration(color: backgroundColor, boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.9),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset:
                              const Offset(3, 3) // changes position of shadow
                          ),
                    ]),
                    height: 20,
                    width: 50,
                    child: Center(
                      child: Text('$yazanPuan',
                          style: TextStyle(
                              color: redColor, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 60,
                    width: 650,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _controllers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return HexagonContainer(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            previousLength: previousLenght,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius:
                          const BorderRadius.only(topRight: Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.9),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset:
                                const Offset(3, 3) // changes position of shadow
                            ),
                      ],
                    ),
                    height: 20,
                    width: 50,
                    child: Center(
                      child: Text(formatTime(_remainingSeconds),
                          style: TextStyle(
                              color: redColor, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: redColor,
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.9),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: const Offset(3, 3),
                                // changes position of shadow
                              ),
                            ]),
                        height: 80,
                        width: 450,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.question.toString(),
                            style: TextStyle(color: backgroundColor),
                          ),
                        ),
                      ),
                      const SizedBox(width: 50),
                      ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              harfAlButonuTiklandi();
                              alinanHarfteDusenPuan(--qScore);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            backgroundColor: redColor,
                            shape: const StadiumBorder(),
                          ),
                          child: Text(harfAl)),
                      const SizedBox(width: 30),
                      ElevatedButton(
                          onPressed: () async {
                            print('soru = $soruSayisi: ');
                            //setState(() {});
                            if (soruSayisi == 1) {
                              var question = await printFirestoreDocument(
                                  'dort-harfli', '$dortharfli');
                              var answer = await printAnswerDocument(
                                  'dort-harfli', '$dortharfli');
                              nextQuestion(qScore, question, answer);
                            } else if (soruSayisi == 2 || soruSayisi == 3) {
                              var question = await printFirestoreDocument(
                                  'bes-harfli', '$besharfli');
                              var answer = await printAnswerDocument(
                                  'bes-harfli', '$besharfli');
                              nextQuestion(qScore, question, answer);
                            } else if (soruSayisi == 4 || soruSayisi == 5) {
                              var question = await printFirestoreDocument(
                                  'alti-harfli', '$altiharfli');
                              var answer = await printAnswerDocument(
                                  'alti-harfli', '$altiharfli');
                              nextQuestion(qScore, question, answer);
                            } else if (soruSayisi == 6 || soruSayisi == 7) {
                              var question = await printFirestoreDocument(
                                  'yedi-harfli', '$yediharfli');
                              var answer = await printAnswerDocument(
                                  'yedi-harfli', '$yediharfli');
                              nextQuestion(qScore, question, answer);
                            } else if (soruSayisi == 8 || soruSayisi == 9) {
                              var question = await printFirestoreDocument(
                                  'sekiz-harfli', '$sekizharfli');
                              var answer = await printAnswerDocument(
                                  'sekiz-harfli', '$sekizharfli');
                              nextQuestion(qScore, question, answer);
                            } else if (soruSayisi == 10 || soruSayisi == 11) {
                              var question = await printFirestoreDocument(
                                  'dokuz-harfli', '$dokuzharfli');
                              var answer = await printAnswerDocument(
                                  'dokuz-harfli', '$dokuzharfli');
                              nextQuestion(qScore, question, answer);
                            } else if (soruSayisi == 12 || soruSayisi == 13) {
                              print('soru = $soruSayisi: ');
                              var question = await printFirestoreDocument(
                                  'on-harfli', '$onharfli');
                              var answer = await printAnswerDocument(
                                  'on-harfli', '$onharfli');
                              nextQuestion(qScore, question, answer);
                            } else if (soruSayisi == 14) {
                              if (widget.answer.toString().toUpperCase() ==
                                  getWord(_controllers).toUpperCase()) {
                                puanHesaplama(yazanPuan);
                              } else {
                                puanHesaplama(qScore - (2 * qScore));
                                print('puan azaldı');
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EndPage(
                                          puan: toplamPuan.toString())));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            backgroundColor: redColor,
                            shape: const StadiumBorder(),
                          ),
                          child: const Text('Cevapla')),
                    ],
                  ),
                  const SizedBox(height: 180),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  nextQuestion(int score, var question, var answer) {
    if (widget.answer.toString().toUpperCase() ==
        getWord(_controllers).toUpperCase()) {
      puanHesaplama(yazanPuan);
    } else {
      puanHesaplama(score - (2 * score));
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Body2(
                question: question,
                answer: answer,
                seconds: _remainingSeconds)));
    ++soruSayisi;
  }
}
