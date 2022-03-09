import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modulo_contratos/clases/result_login.dart';

import 'package:modulo_contratos/pages/adhesion_page.dart';
import 'package:modulo_contratos/pages/estadistica_page.dart';

import 'package:modulo_contratos/pages/splash_screen.dart';
import 'package:modulo_contratos/pages/terminacion_page.dart';

class Home extends StatefulWidget {
  final ResultLogin resultLogin;
  const Home(this.resultLogin, {Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState(resultLogin);
}

class _HomeState extends State<Home> {
  int _currentPage = 0;
  ResultLogin resultLogin;

  Widget getPage(index) {
    switch (index) {
      case 0:
        return AdhesionWidget(resultLogin);
      case 1:
        return TerminationWidget(resultLogin);
      case 2:
      default:
        //return StatisticsPage(resultLogin);
        return Statistics();
    }
  }

  /*List<Widget> _paginas = [
    ,
    
    StatisticsPage(resultLogin)
  ];
*/
  _HomeState(this.resultLogin) {
    //print(this.resultLogin);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightGreen,
              ),
              child: Image(image: AssetImage("assets/Logo.png")),
            ),
            ListTile(
              title: const Text(
                'Cerrar Sesion',
                style: TextStyle(fontSize: 12.0),
              ),
              trailing: Icon(Icons.exit_to_app),
              onTap: () {
                //Navigator.of(context).restorablePush(_dialogBuilder);
                //Go to login page, destroy permanent data for direct access
                //if (isAcceptCloseSession(context)) {
                //releaseSession();
                //} else
                //Navigator.pop(context);
                showAlertDialog(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Módulo de Contratos[' + widget.resultLogin.data.Username + "]",
          style: TextStyle(fontSize: 18.0),
        ),
        backgroundColor: Colors.lightGreen,
      ),
      body: getPage(_currentPage),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        currentIndex: _currentPage,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home), label: "Adhesión"),
          BottomNavigationBarItem(
              icon: const Icon(Icons.access_alarm), label: "Terminación"),
          BottomNavigationBarItem(
              icon: const Icon(Icons.access_alarm), label: "Estadisticas"),
        ],
      ),
    );
  }

  void closeSession() {
    releaseSession();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SplashScreen()));
  }

  void returnToPage(context) {
    Navigator.pop(context);
  }

  void releaseSession() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("LOGGED", false);
    preferences.setString("WHEN", DateTime.now().toIso8601String());
  }

  showAlertDialog(BuildContext context) {
    Widget remindButton = TextButton(
      child: Text("Cancelar"),
      onPressed: () {
        returnToPage(context);
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cerrar sesión"),
      onPressed: () {
        closeSession();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cerrar sesión?"),
      content: Text(
          "Seguro de cerrar la sesión actual?. Tendrá que ingresar nuevamente con el usuario asignado."),
      actions: [
        remindButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
