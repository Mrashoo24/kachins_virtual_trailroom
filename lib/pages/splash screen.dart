import 'package:flutter/material.dart';
import 'package:kachins/main.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:kachins/pages/home%20screen.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // var context;

  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
        (context), MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Clean Code',
        home: AnimatedSplashScreen(
            duration: 2000,
            splash: 'assets/images/Logo.png',
            nextScreen: HomeScreen(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.rightToLeft,
            backgroundColor: Color(0xFF9E3C0E)));
  }
}
