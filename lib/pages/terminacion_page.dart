import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:modulo_contratos/clases/conection_path.dart';
import 'package:modulo_contratos/clases/result_contract.dart';
import 'package:http/http.dart' as http;
import 'package:modulo_contratos/clases/result_login.dart';
import 'package:modulo_contratos/clases/result_options.dart';
import 'package:modulo_contratos/pages/pdfscreen.dart';
// ParentWidget manages the state for TapboxB.

//------------------------ ParentWidget --------------------------------

class TerminationWidget extends StatefulWidget {
  final ResultLogin resultLogin;
  const TerminationWidget(this.resultLogin, {Key? key}) : super(key: key);

  @override
  _TerminationWidgetState createState() => _TerminationWidgetState(resultLogin);
}

class _TerminationWidgetState extends State<TerminationWidget> {
  final ResultLogin resultLogin;
  OptionParm _currentOptions = OptionParm("1", "1", "1");
  late List<Contract> _currentDataContracts;
  late List<Option> _currentDataValuesFormat;
  late List<Option> _currentDataValuesCustomer;
  late List<Option> _currentDataValuesAgency;
  int indexSelectedFormat = 0;
  int indexSelectedCustomer = 0;
  int indexSelectedAgency = 0;
  bool _isLoadingData = false;
  //late int _dropdownValueCustomer;
  //late int _dropdownValueAgency;
  //late int _dropdownValueFormat;

  Future<List<Option>> _doLoadDataValuesFormat() async {
    // var list;////
    //Future<List<Option>> _ddCustomer;
    _currentOptions =
        OptionParm("1", resultLogin.data.Usersystemid.toString(), "");
    final response = await http.post(
        Uri.parse(ConnectionPath().restApiGetValues),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          "option": _currentOptions.option,
          "userid": _currentOptions.userid,
          "value1": _currentOptions.value1
        }));
    //List<Option> _options = [];
    _currentDataValuesFormat = [];
    if (response.statusCode == 200) {
      ResultOptions result = ResultOptions.fromJson(jsonDecode(response.body));
      if (result.result == 1) {
        final jsonData = jsonDecode(response.body);
        for (var item in jsonData["data"]) {
          _currentDataValuesFormat.add(Option(
              optionid: item['optionid'],
              description: item['description'],
              descriptionshort: item['descriptionshort']));
        }
        setState(() {
          _isLoadingData = true;
        });
        //_dropdownValueFormat = _currentDataValuesFormat[0].optionid;
        //DoLoad

        //_myJson = result.data as List<Map>?;

      } else {
        //error usuario fallido
        //doShowError(context, "Usuario/Contraseña errada. Intente nuevamente!");
      }
    } else {
      _isLoadingData = false;
      doShowError(context, 'Errro al recuperar Formatos',
          'Error al conectarse al site');
    }
    return _currentDataValuesFormat;
  }

  Future<List<Option>> _doLoadDataValuesCustomer() async {
    // var list;////
    //Future<List<Option>> _ddCustomer;
    final response = await http.post(
        Uri.parse(ConnectionPath().restApiGetValues),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          "option": "2",
          "userid": resultLogin.data.Usersystemid.toString(),
          "value1": ""
        }));
    //List<Option> _options = [];
    _currentDataValuesCustomer = [];
    if (response.statusCode == 200) {
      ResultOptions result = ResultOptions.fromJson(jsonDecode(response.body));
      if (result.result == 1) {
        final jsonData = jsonDecode(response.body);
        for (var item in jsonData["data"]) {
          _currentDataValuesCustomer.add(Option(
              optionid: item['optionid'],
              description: item['description'],
              descriptionshort: item['descriptionshort']));
        }
        setState(() {
          _isLoadingData = true;
        });
      } else {
        //error usuario fallido
        //doShowError(context, "Usuario/Contraseña errada. Intente nuevamente!");
      }
    } else {
      _isLoadingData = false;
      doShowError(context, 'Errro al recuperar Customer',
          'Error al conectarse al site');
    }
    return _currentDataValuesCustomer;
  }

  Future<List<Option>> _doLoadDataValuesAgency() async {
    // var list;////
    //Future<List<Option>> _ddCustomer;
    final response = await http.post(
        Uri.parse(ConnectionPath().restApiGetValues),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          "option": "3",
          "userid": resultLogin.data.Usersystemid.toString(),
          "value1": _currentDataValuesCustomer[indexSelectedCustomer]
              .optionid
              .toString()
        }));
    //List<Option> _options = [];
    _currentDataValuesAgency = [];
    if (response.statusCode == 200) {
      ResultOptions result = ResultOptions.fromJson(jsonDecode(response.body));
      if (result.result == 1) {
        final jsonData = jsonDecode(response.body);
        for (var item in jsonData["data"]) {
          _currentDataValuesAgency.add(Option(
              optionid: item['optionid'],
              description: item['description'],
              descriptionshort: item['descriptionshort']));
        }
        setState(() {
          _isLoadingData = true;
        });
      } else {
        //error usuario fallido
        //doShowError(context, "Usuario/Contraseña errada. Intente nuevamente!");
      }
    } else {
      _isLoadingData = false;
      doShowError(context, 'Errro al recuperar Agencias',
          'Error al conectarse al site');
    }
    return _currentDataValuesCustomer;
  }

  _TerminationWidgetState(this.resultLogin);
  @override
  void initState() {
    super.initState();
    //_currentDataValuesFormat = [];
    _currentDataValuesAgency = [];
    _currentDataValuesCustomer = [];
    _currentDataValuesAgency = [];
    _LoadDataValuesForChangeFormat();
    _LoadDataValuesForChangeCustomer();
    //_LoadDataValuesForChangeAgency();
    //_dropdownValueCustomer = 2;
    //_dropdownValueAgency = 182;
    //_dropdownValueFormat = 1;
    _currentDataContracts = [];
    //_currentDataValuesFormat = [];////
  }

  Future<List<Contract>> _doLoadContracts() async {
    //String url = "http://192.168.1.105:7000/api/ContratosAdh/GetContracts";
    Future<List<Contract>> _doLoad() async {
      _isLoadingData = true;
      final response = await http.post(
          Uri.parse(ConnectionPath().restApiGetContractsAdh),
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8'
          },
          body: jsonEncode(<String, String>{
            'typeContract': '2',
            'userid': _currentOptions.userid,
            'customerid': _currentDataValuesCustomer[indexSelectedCustomer]
                .optionid
                .toString(),
            'agencyid': _currentDataValuesAgency[indexSelectedAgency]
                .optionid
                .toString(),
            'formatid': _currentDataValuesFormat[indexSelectedFormat]
                .optionid
                .toString(),
            'cedula': _controllerCedula.text,
          }));
      _currentDataContracts = [];
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['result'].toString() == '1') {
          for (var item in jsonData["data"]) {
            _currentDataContracts.add(Contract(
                contractid: item['contractID'],
                applicant: item['applicant'],
                customer: item['customer'],
                customerid: item['customerid'],
                vehicle: item['vehicle'],
                path: item['path']));
          }
          setState(() {
            _isLoadingData = true;
          });
        }
      } else {
        _isLoadingData = false;
        doShowError(
            context, 'Error al recuperar datos', 'Error al conectarse al site');
      }
      return _currentDataContracts;
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

  void _LoadDataValuesForChangeFormat() {
    setState(() {
      _getValuesFormat();
    });
  }

  void _LoadDataValuesForChangeCustomer() {
    setState(() {
      _getValuesCustomer();
    });
  }

  void _LoadDataValuesForChangeAgency() {
    setState(() {
      _getValuesAgency();
    });
  }

  void _LoadContractsForChange() {
    setState(() {
      _getProducts();
    });
  }

  _getValuesFormat() async {
    _currentDataValuesFormat = [];
    await _doLoadDataValuesFormat();
  }

  _getValuesCustomer() async {
    _currentDataValuesCustomer = [];
    await _doLoadDataValuesCustomer();
  }

  _getValuesAgency() async {
    _currentDataValuesAgency = [];
    await _doLoadDataValuesAgency();
  }

  _getProducts() async {
    _currentDataContracts = [];
    await _doLoadContracts();
  }

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
              //isDense: true,
              /* onTap: () => {
                setState(() {
                  _currentOptions.value1 = _dropdownValueFormat.toString();
                })
              },*/
              items: _currentDataValuesFormat.map(
                (Option val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text(
                      val.description,
                      style: TextStyle(fontSize: 14.0),
                    ),
                  );
                },
              ).toList(),
              value: _currentDataValuesFormat.length == 0
                  ? null
                  : _currentDataValuesFormat[indexSelectedFormat],
              onChanged: (newvalue) {
                setState(() {
                  indexSelectedFormat =
                      _currentDataValuesFormat.indexOf(newvalue as Option);
                  _getValuesCustomer();
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
              items: _currentDataValuesAgency.map(
                (Option val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text(
                      val.description,
                      style: TextStyle(fontSize: 14.0),
                    ),
                  );
                },
              ).toList(),
              value: _currentDataValuesAgency.length == 0
                  ? null
                  : _currentDataValuesAgency[indexSelectedAgency],
              onChanged: (newvalue) {
                setState(() {
                  indexSelectedAgency =
                      _currentDataValuesAgency.indexOf(newvalue as Option);
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
              items: _currentDataValuesCustomer.map(
                (Option val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text(
                      val.description,
                      style: TextStyle(fontSize: 14.0),
                    ),
                    onTap: () => null,
                  );
                },
              ).toList(),
              value: _currentDataValuesCustomer.length == 0
                  ? null
                  : _currentDataValuesCustomer[indexSelectedCustomer],
              onChanged: (newvalue) {
                setState(() {
                  indexSelectedCustomer =
                      _currentDataValuesCustomer.indexOf(newvalue as Option);
                  _getValuesAgency();
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

  var _controllerCedula = TextEditingController();
  getTextFieldCedula() {
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
              controller: _controllerCedula,
              decoration: InputDecoration(
                hintText: 'Cédula/Nombre/Razón Social/Chasis',
                suffixIcon: IconButton(
                  onPressed: _controllerCedula.clear,
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
                  onPressed: () => {_LoadContractsForChange()},
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
    return SizedBox(
      child: Column(
        children: [
          doForm(),
          Expanded(
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 500.0,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: _currentDataContracts.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, int index) {
                      return ListTile(
                        focusColor: Colors.lightGreen[200],
                        title: Text(
                          _currentDataContracts[index].customerid +
                              " - " +
                              _currentDataContracts[index]
                                  .contractid
                                  .toString(),
                          style: TextStyle(fontSize: 10),
                        ),
                        subtitle: Text(
                          _currentDataContracts[index].applicant +
                              "\n" +
                              _currentDataContracts[index].vehicle,
                          style: TextStyle(fontSize: 11.0),
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          child: Image(
                            image: AssetImage("assets/Logo.png"),
                            width: 40,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 10.0,
                        ),
                        onTap: () async {
                          var urlToNavigate = baseURLDocuments +
                              "/" +
                              _currentDataContracts[index]
                                  .path
                                  .replaceAll('/', '\\');
                          print("TO LOAD:" + urlToNavigate);
                          final response =
                              await http.get(Uri.parse(urlToNavigate));

                          if (response.statusCode == 200) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PDFScreen(
                                  urlToDoc: urlToNavigate,
                                  titleForDoc: _currentDataContracts[index]
                                          .customerid +
                                      " - " +
                                      _currentDataContracts[index]
                                          .contractid
                                          .toString() +
                                      "[" +
                                      _currentDataContracts[index].applicant +
                                      "]",
                                ),
                              ),
                            );
                          } else {
                            doShowError(context, 'Error al recuperar contrato',
                                "Documento no se encuentra disponible o no ha sido generado aún.\nCoordine con el administrador la generación del contrato antes de visualizar.");
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            )),
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _LoadContractsForChange();
            },
          ),
        ],
      ),
    );
  }
}

//------------------------- TapboxB ----------------------------------


