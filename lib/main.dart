/// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';

///import 'package:trust_modulo_contratos/pages/combotest.dart';
//import 'package:trust_modulo_contratos/pages/home.dart';
import 'package:modulo_contratos/pages/splash_screen.dart';

// @dart=2.9
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: new SplashScreen(),
      //home: Home()
      //theme: new ThemeData(primaryColor: Colors.white),
    );
  }
}
