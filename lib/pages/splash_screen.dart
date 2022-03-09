import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modulo_contratos/clases/result_login.dart';
import 'package:modulo_contratos/pages/home.dart';

import 'login_page_state.dart';

void main() {
  runApp(SplashScreen());
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = Duration(seconds: 4);
    return new Timer(duration, route);
  }

  route() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isLogged = preferences.getBool("LOGGED") ?? false;
    if (isLogged) {
      User userLogged = User(
          Usersystemid: preferences.getInt("USERID") ?? 0,
          Username: preferences.getString("USERNAME") ?? "",
          Address: "",
          Ballot: "",
          CityRestricted: false,
          Cityagencyid: 0,
          Cityid: 0,
          Createuserid: 0,
          Customerid: 0,
          Identitynumber: "",
          Lastname: preferences.getString("LASTNAME") ?? "",
          Name: preferences.getString("NAME") ?? "",
          Mail: "",
          Movil: "",
          Password: "",
          Profileid: 0,
          Profiletype: 0,
          Status: true,
          Telephone: "",
          Title: "",
          Totalaccess: 0,
          Updateuserid: 0);
      //Create resultLogin for send as parameter to Home
      ResultLogin result = ResultLogin(
          result: 1, data: userLogged, message: "WAS LOGGED PREVIOUS");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home(result)));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: new Color(0xffF5591F),
                gradient: LinearGradient(
                    colors: [Colors.green, Colors.lightGreen],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(height: 100),
                Container(
                  height: 200,
                  child: Image.asset("assets/logooficial.png"),
                ),
                Expanded(
                  child: SizedBox(
                    height: 400,
                    child: Image.asset(
                      "assets/faro-trust.png",
                      scale: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
