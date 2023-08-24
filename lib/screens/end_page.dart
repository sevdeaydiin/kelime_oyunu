import 'package:flutter/material.dart';
import 'package:ko/main.dart';
import 'package:ko/screens/start_page.dart';

import '../constants.dart';

class EndPage extends StatelessWidget {
  final String puan;
  final String yenidenBaslat = 'Yeniden Başlat';
  const EndPage({Key? key, required this.puan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor,
      body: Container(
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
              Container(
                height: 100,
                width: 400,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    "\t\t Tebrikler\n Puanınız: $puan",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 30),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StartPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    textStyle: TextStyle(color: redColor),
                    backgroundColor: backgroundColor,
                    shape: const StadiumBorder(),
                  ),
                  child: Text(yenidenBaslat,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 18))),
            ],
          ),
        ),
      ),
    );
  }
}
