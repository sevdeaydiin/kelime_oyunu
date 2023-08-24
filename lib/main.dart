import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ko/constants.dart';
import 'package:ko/screens/start_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const KelimeOyunu());
}

int soruSayisi = 0;
int cevapSayisi = 1;
int toplamPuan = 0;

class KelimeOyunu extends StatelessWidget {
  final String title = 'Kelime Oyunu';
  const KelimeOyunu({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          buttonColor: redColor,
        ),
      ),
      title: title,
      debugShowCheckedModeBanner: false,
      home: const StartPage(),
    );
  }
}
