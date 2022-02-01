import 'package:flutter/material.dart';
import 'package:sisca_finnet/screen/login_screen.dart';
import 'package:sisca_finnet/screen/splash_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sisca Finnet',
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xFFF12A32),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
      },
    );
  }
}
