import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:modulo_contratos/clases/conection_path.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:modulo_contratos/clases/result_contract.dart';
import 'package:modulo_contratos/clases/result_options.dart';
import 'package:modulo_contratos/pages/pdfscreen.dart';

//String baseUrl = "http://contratos.trustfiduciaria.com";

class AdhesionPage extends StatefulWidget {
  const AdhesionPage({Key? key}) : super(key: key);

  @override
  State<AdhesionPage> createState() => _AdhesionPageState();
}

class _AdhesionPageState extends State<AdhesionPage> {
  late String _dropdownValueCustomer;
  late String _dropdownValueAgency;
  late String _dropdownValueFormat;
  Future<List<Contract>>? _listadoContratos;
  //Future<List<Option>>? _myJson;
  List<Option>? __dropdownItems;
  @override
  void initState() {
    super.initState();

    _dropdownValueCustomer = 'FIDEICOMISO VEHÍCULOS BANCO DEL AUSTRO TF-C-263';
    _dropdownValueAgency = 'QUITO';
    _dropdownValueFormat = 'Personas Naturales';
    //_myJson = [];
    //__dropdownItems = _getData();
    //_listadoContratos = _doLoadContracts();
  }

  Future<List<Option>> _getData() async {
    // var list;////
    //Future<List<Option>> _ddCustomer;
    final response = await http.post(
        Uri.parse(ConnectionPath().restApiGetValues),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(
            <String, String>{"option": "1", "userid": "7", "value1": "4"}));
    List<Option> _options = [];
    if (response.statusCode == 200) {
      //print(response.body);

      ResultOptions result = ResultOptions.fromJson(jsonDecode(response.body));
      if (result.result == 1) {
        final jsonData = jsonDecode(response.body);
        _options = [];
        for (var item in jsonData["data"]) {
          _options.add(Option(
              optionid: item['optionid'],
              description: item['description'],
              descriptionshort: item['descriptionshort']));
        }
        //DoLoad

        //_myJson = result.data as List<Map>?;

      } else {
        //error usuario fallido
        //doShowError(context, "Usuario/Contraseña errada. Intente nuevamente!");
      }
    } else {
      doShowError(context, 'Errro al recuperar Formatos',
          'Error al conectarse al site');
    }
    return _options;
  }

  List<String> lstCustomer = [
    'FIDEICOMISO VEHÍCULOS BANCO DEL AUSTRO TF-C-263',
    'FIDEICOMISO DE ADMINISTRACION DE GARANTIAS TF-G-566 CRESAFE',
    'FIDEICOMISO DE ADMINISTRACION DE GARANTIAS TF-G-565 MOVILIZA',
    'FIDEICOMISO DE ADMINISTRACION DE CARTERA CFC TF-G-553',
    'ENCARGO FIDUCIARIO FUENTE DE PAGO'
  ];
  List<String> lstAgency = ['QUITO', 'GUAYAQUIL', 'CUENCA'];
  List<String> lstFormat = [
    'Personas Juridicas con deudores',
    'Personas Naturales con deudores',
    'Personas Juridicas',
    'Personas Naturales',
    'BA-PERSONAS JURIDICAS CON DEUDORES',
    'BA-PERSONAS NATURALES CON DEUDORES',
    'BA-PERSONA JURIDICA',
    'BA-PERSONAS NATURALES',
    'TERM 020-SIN COMP-SIN CESION',
    'TERM 020-SIN COMP-CON CESION',
    'TERM 358-SIN COMP-SIN CESION',
    'TERM 358-SIN COMP-CON CESION',
    'TERM 020-PERS NATURAL-CON CESION',
    'TERM 358-PERS NATURAL-CON CESION',
    'CFC - PERSONA NATURAL SOLTERA',
    'CFC - PERSONA NATURAL SOLTERA C/DEUDOR',
    'CFC - PERSONA NATURAL CASADA C/SOCIEDAD CONYUGAL',
    'CFC - PERSONA NATURAL CASADA C/SOCIEDAD CONYUGAL CON COMPARECENCIA DE APODERADO',
    'CFC - PERSONA NATURAL CASADA C/SOCIEDAD C/DEUDOR',
    'CFC - PERSONA NATURAL CASADA C/SOCIEDAD CONYUGAL CON COMPARECENCIA DE APODERADO C/DEUDOR',
    'CFC - PERSONA JURIDICA',
    'CFC - PERSONA JURIDICA CON COMPARECENCIA DE APODERADO',
    'CFC - PERSONA JURIDICA C/DEUDOR',
    'CFC - PERSONA JURIDICA C/DEUDOR CON COMPARECENCIA DE APODERADO'
  ];
  getDropDownFormat() {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.lightGreen,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5.0,
                  spreadRadius: 0.5,
                  offset: Offset(1.0, 1.0),
                ),
              ],
            ),
            padding: EdgeInsets.only(left: 44.0),
            margin: EdgeInsets.only(top: 0.0, left: 16.0, right: 16.0),
            child: DropdownButton(
              isExpanded: true,
              items: lstFormat.map(
                (val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              value: _dropdownValueFormat,
              onChanged: (value) {
                setState(() {
                  _dropdownValueFormat = value as String;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0, left: 28.0),
            child: Icon(
              Icons.account_tree,
              color: Colors.black38,
              size: 20.0,
            ),
          ),
        ],
      ),
    );
  }

  getDropDownAgency() {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.lightGreen,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5.0,
                  spreadRadius: 0.5,
                  offset: Offset(1.0, 1.0),
                ),
              ],
            ),
            padding: EdgeInsets.only(left: 44.0),
            margin: EdgeInsets.only(top: 0.0, left: 16.0, right: 16.0),
            child: DropdownButton(
              isExpanded: true,
              items: lstAgency.map(
                (val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              value: _dropdownValueAgency,
              onChanged: (value) {
                setState(() {
                  _dropdownValueAgency = value as String;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0, left: 28.0),
            child: Icon(
              Icons.access_time_filled_sharp,
              color: Colors.black38,
              size: 20.0,
            ),
          ),
        ],
      ),
    );
  }

  getDropDownCustomer() {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.lightGreen,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5.0,
                  spreadRadius: 0.5,
                  offset: Offset(1.0, 1.0),
                ),
              ],
            ),
            padding: EdgeInsets.only(left: 44.0),
            margin: EdgeInsets.only(top: 0.0, left: 16.0, right: 16.0),
            child: DropdownButton(
              isExpanded: true,
              items: lstCustomer.map(
                (val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              value: _dropdownValueCustomer,
              onChanged: (value) {
                setState(() {
                  _dropdownValueCustomer = value as String;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0, left: 28.0),
            child: Icon(
              Icons.person,
              color: Colors.black38,
              size: 20.0,
            ),
          ),
        ],
      ),
    );
  }

  getTextFieldCedula() {
    var _controller = TextEditingController();
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.lightGreen,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5.0,
                  spreadRadius: 0.5,
                  offset: Offset(1.0, 1.0),
                ),
              ],
            ),
            padding: EdgeInsets.only(left: 44.0),
            margin: EdgeInsets.only(top: 0.0, left: 16.0, right: 16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Cédula/Nombre/Razón Social',
                suffixIcon: IconButton(
                  onPressed: _controller.clear,
                  icon: Icon(Icons.clear),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0, left: 28.0),
            child: Icon(
              Icons.access_time_filled_sharp,
              color: Colors.black38,
              size: 20.0,
            ),
          ),
        ],
      ),
    );
  }

  doForm() {
    return Column(
      children: [
        Form(
          child: Theme(
            data: ThemeData(
                brightness: Brightness.dark,
                primarySwatch: Colors.teal,
                inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.teal, fontSize: 20.0))),
            child: Column(
              children: <Widget>[
                Padding(padding: const EdgeInsets.only(top: 10.0)),
                getDropDownFormat(),
                Padding(padding: const EdgeInsets.only(top: 10.0)),
                getDropDownCustomer(),
                Padding(padding: const EdgeInsets.only(top: 10.0)),
                getDropDownAgency(),
                Padding(padding: const EdgeInsets.only(top: 10.0)),
                getTextFieldCedula(),
                MaterialButton(
                  height: 40.0,
                  minWidth: 100.0,
                  color: Colors.lightGreen,
                  textColor: Colors.white,
                  child: new Icon(
                    Icons.find_in_page,
                    size: 30.0,
                  ),
                  onPressed: () => {doQuery(context)},
                  splashColor: Colors.redAccent,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        doForm(),
        /*  Center(
          child: Container(
            //width: 600.0,
            height: 430.0,
            child: MaterialApp(
                title: "Modulo Contratos - Contratos Adhesión",
                home: Scaffold(
                    body: FutureBuilder(
                  future: _doLoadContracts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.count(
                        childAspectRatio:
                            7, // Ver como calcularlo automaticamente
                        crossAxisCount: 1,
                        children: _listContratos(snapshot.data),
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text("error");
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ))),
          ),
        )*/
      ],
    );
  }

  List<Widget> _listContratos(data) {
    List<Widget> contracts = [];
    for (Contract contract in data) {
      contracts.add(Container(
          height: 20,
          child: ListTile(
            focusColor: Colors.orange[200],
            onTap: () async {
              var urlToNavigate =
                  baseURLDocuments + "/" + contract.path.replaceAll('/', '\\');

              final response = await http.get(Uri.parse(urlToNavigate));

              if (response.statusCode == 200) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PDFScreen(
                      urlToDoc: urlToNavigate,
                      titleForDoc: contract.customerid +
                          " - " +
                          contract.contractid.toString() +
                          "[" +
                          contract.applicant +
                          "]",
                    ),
                  ),
                );
              } else {
                doShowError(context, 'Error al recuperar contrato',
                    "Documento no se encuentra disponible o no ha sido generado aún.\nCoordine con el administrador la generación del contrato antes de visualizar.");
              }
            },
            title: Text(
              contract.customerid + " - " + contract.contractid.toString(),
              style: TextStyle(fontSize: 10),
            ),
            subtitle: Text(contract.applicant + "\n" + contract.vehicle),
            leading: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              child: Image(image: AssetImage("assets/Logo.png")),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 10.0,
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
          )));
    }
    return contracts;
  }

  Future<List<Contract>> _doLoadContracts() async {
    //String url = "http://192.168.1.105:7000/api/ContratosAdh/GetContracts";
    Future<List<Contract>> _doLoad() async {
      final response = await http.post(
          Uri.parse(ConnectionPath().restApiGetContractsAdh),
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8'
          },
          body: jsonEncode(<String, String>{
            'userid': '7',
            'customerid': '4',
            'agencyid': '182',
            'formatid': '4',
            'cedula': '',
          }));
      List<Contract> contracts = [];
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['result'].toString() == '1') {
          for (var item in jsonData["data"]) {
            contracts.add(Contract(
                contractid: item['contractID'],
                applicant: item['applicant'],
                customer: item['customer'],
                customerid: item['customerid'],
                vehicle: item['vehicle'],
                path: item['path']));
          }
        }
      } else {
        doShowError(
            context, 'Error al recuperar datos', 'Error al conectarse al site');
      }
      return contracts;
    }

    return _doLoad();
  }

  void doShowError(BuildContext context, String title, String message) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) => AlertDialog(
              title: Text(title),
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

  doQuery(BuildContext context) {
    _listadoContratos = _doLoadContracts();
  }
}
