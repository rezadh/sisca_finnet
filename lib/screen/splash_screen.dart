import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisca_finnet/screen/main/main_screen.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void splashScreenStart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var duration = const Duration(seconds: 3);
    Timer(duration, () {
      int _valueSession = prefs.getInt('value');
      _valueSession == 1
          ? Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
              (route) => false,
            )
          : Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false,
            );
    });
  }

  @override
  void initState() {
    setState(() {
      splashScreenStart();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      backgroundColor: Color(0xFFF12A32),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          // padding: EdgeInsets.only(bottom: 41),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 3.5),
              Image.asset(
                'assets/images/fast_logo.png',
                width: 107,
                height: 107,
                color: Colors.white,
              ),
              SizedBox(
                height: 15
              ),
              Image.asset(
                'assets/images/fast_text.png',
                width: 205,
                height: 72,
                color: Colors.white,
              ),
              SizedBox(height: 187),
              Text(
                'PT Finnet Indonesia',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Roboto'),
              ),
              SizedBox(height: 6),
              Image.asset(
                'assets/images/2022.png',
                width: 37,
                height: 14,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
