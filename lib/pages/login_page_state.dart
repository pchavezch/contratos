// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modulo_contratos/clases/conection_path.dart';
import 'package:modulo_contratos/clases/result_login.dart';
import 'package:modulo_contratos/pages/home.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _iconAnimationController;
  late Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _iconAnimation = CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.bounceOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final _userTextEditingController = TextEditingController();
    final _passworEditingTextdcontroller = TextEditingController();
    void doLogin(BuildContext context) {
      //String url = "";
      Future<dynamic> _doLogin() async {
        final response = await http.post(
            Uri.parse(ConnectionPath().restApiLogin),
            headers: <String, String>{
              'Content-Type': 'application/json;charset=UTF-8'
            },
            body: jsonEncode(<String, String>{
              'username': _userTextEditingController.text,
              'password': _passworEditingTextdcontroller.text
            }));
        if (response.statusCode == 200) {
          ResultLogin result = ResultLogin.fromJson(jsonDecode(response.body));
          if (result.result == 1) {
            // Logged on
            //Save shared preferences for next access
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setBool("LOGGED", true);
            preferences.setString("USERNAME", result.data.Username);
            preferences.setString("NAME", result.data.Name);
            preferences.setString("LASTNAME", result.data.Lastname);
            preferences.setInt("USERID", result.data.Usersystemid);
            preferences.setString("WHEN", DateTime.now().toIso8601String());

            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home(result)));
          } else {
            //error usuario fallido
            doShowError(
                context, "Usuario/Contraseña errada. Intente nuevamente!");
          }
        } else {
          doShowError(context, 'Error al conectarse al site');
        }
      }

      try {
        _doLogin();
      } on Exception catch (_) {
        doShowError(
            context, "Error al conectar al server. Intente en unos minutos!");
        throw Exception("Error on server");
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightGreen,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Image(
                  image: new AssetImage("assets/Logo.png"),
                  width: _iconAnimation.value * 100,
                  height: _iconAnimation.value * 100,
                ),
                Form(
                  child: Theme(
                    data: ThemeData(
                        brightness: Brightness.dark,
                        primarySwatch: Colors.teal,
                        inputDecorationTheme: InputDecorationTheme(
                            labelStyle:
                                TextStyle(color: Colors.teal, fontSize: 20.0))),
                    child: Column(
                      children: <Widget>[
                        Padding(padding: const EdgeInsets.only(top: 10.0)),
                        _userLoginTextField(_userTextEditingController),
                        _passwordTextField(_passworEditingTextdcontroller),
                        Padding(padding: const EdgeInsets.only(top: 40.0)),
                        new MaterialButton(
                          height: 40.0,
                          minWidth: 100.0,
                          color: Colors.green[600],
                          textColor: Colors.white,
                          child: new Icon(
                            Icons.login,
                            size: 30.0,
                          ),
                          onPressed: () => {doLogin(context)},
                          splashColor: Colors.lightGreen,
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void doShowError(BuildContext context, String message) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Error al acceder"),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.error))
              ],
            ));
  }

  Widget _userLoginTextField(TextEditingController controller) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        alignment: Alignment.center,
        //padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(left: 20, right: 20, top: 1),
        padding: EdgeInsets.only(left: 20, right: 20),
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[200],
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5), blurRadius: 10, color: Colors.green),
          ],
        ),
        child: TextFormField(
          controller: controller,
          style: TextStyle(color: Colors.green),
          cursorColor: Colors.green,
          decoration: InputDecoration(
            focusColor: Colors.black,
            labelText: "Ingrese usuario",
            labelStyle: TextStyle(color: Colors.green, fontSize: 25),
            icon: Icon(
              Icons.people,
              color: Colors.green[300],
            ),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          keyboardType: TextInputType.text,
        ),
      );
    });
  }

  _passwordTextField(TextEditingController controller) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        alignment: Alignment.center,
        //padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(left: 20, right: 20, top: 5),
        padding: EdgeInsets.only(left: 20, right: 20),
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[200],
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5), blurRadius: 10, color: Colors.green),
          ],
        ),
        child: TextFormField(
          controller: controller,
          style: TextStyle(color: Colors.green),
          cursorColor: Colors.green,
          decoration: InputDecoration(
            focusColor: Colors.black,
            labelText: "Ingrese contraseña",
            labelStyle: TextStyle(color: Colors.green, fontSize: 25),
            icon: Icon(
              Icons.people,
              color: Colors.green[300],
            ),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          keyboardType: TextInputType.text,
          obscureText: true,
        ),
      );
    });
  }
}
