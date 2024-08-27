import 'package:flutter/material.dart';
import 'dart:async';

import 'package:scopeindia_student/home.dart'; // Import the timer library

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Start a timer that will navigate to the home screen after 3 seconds
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff071e67),
      body: Center(
        child: Hero(
          tag: 'logo',
          child: Image.asset(
            'Image/scope-india-logo-bird.png',
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }
}
