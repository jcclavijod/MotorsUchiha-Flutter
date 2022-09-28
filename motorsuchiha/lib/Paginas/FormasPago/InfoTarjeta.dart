import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_dialog/FancyAnimation.dart';
import 'package:fancy_dialog/FancyGif.dart';
import 'package:fancy_dialog/FancyTheme.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motorsuchiha/behaviors/hiddenScrollBehavior.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InfoTarjeta extends StatefulWidget {
  @override
  _InfoTarjetaState createState() => _InfoTarjetaState();
}

class _InfoTarjetaState extends State<InfoTarjeta> {
  CollectionReference agregar =
      FirebaseFirestore.instance.collection('Usuarios');

  final _formKey = GlobalKey<
      FormState>(); //objeto que sirve para la validacion de los txtfield
  final _scaffoldKey = GlobalKey<
      ScaffoldState>(); //llave al scaffold para los menus contextuales
  final TextStyle myStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  User _user;

  String _direccion;
  String _departamento;
  String _ciudad;
  String _barrio;
  String validar = "";
  bool _registrado = false;

  _validaciones() {
    if (_formKey.currentState.validate()) {
      _salir();
    }
  }

  @override
  Widget build(BuildContext context) {
    //Estas lineas sirven para no sobrepasar el ancho de de la pantala y del widget (AVERIGUAR MAS)
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: Container(
          height: 45,
          width: 100,
          child: RaisedButton(
              color: Colors.white,
              child: Text(
                "Continuar",
                style: myStyle,
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => FancyDialog(
                            title: "Validación tarjeta",
                            descreption: _algoritmoValidacion(),
                            animationType: FancyAnimation.BOTTOM_TOP,
                            theme: FancyTheme.FANCY,
                            gifPath:
                                FancyGif.MOVE_FORWARD, //'./assets/walp.png',
                            okFun: () => {
                              _salir().ok,
                            },
                          ));
                }
              })),
      appBar: AppBar(
        title: Text(
          'Validación Tarjeta',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/EleccionMetodo');
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ScrollConfiguration(
          behavior: HiddenScrollBehavior(),
          child: Form(
            key:
                _formKey, //key que nos permite usar el objeto dentro de nuestro fomulario
            //Formulario para el registro
            child: ListView(
              //Para que no se nos sobreponga el teclado
              children: <Widget>[
                Align(
                  child: new Image(
                    width: 275.0,
                    height: 275.0,
                    image: AssetImage('assets/images/tarjeta.jpg'),
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                Divider(
                  color: Colors.transparent,
                ),
                const Divider(
                  //Linea que separa
                  height: 1.0,
                ),
                TextFormField(
                    autocorrect: false,
                    decoration: InputDecoration(
                        labelText: 'Nombre de la tarjeta',
                        icon: Icon(Icons.near_me)),
                    validator: (val) {
                      if (RegExp('[a-zA-Z]').hasMatch(val)) {
                        return null;
                      } else {
                        return 'Por favor ingrese un nombre valido';
                      }
                    },
                    onSaved: (val) {
                      setState(() {
                        _direccion = val;
                      });
                    }),
                SizedBox(
                  height: 7,
                ),
                const Divider(
                  //Linea que separa
                  height: 1.0,
                ),
                TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Numero de la tarjeta',
                        icon: Icon(Icons.confirmation_number)),
                    validator: (val) {
                      if (RegExp(
                              r'^(?:4[0-9]{12}(?:[0-9]{3})?|[25][1-7][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$')
                          .hasMatch(
                              val.replaceAll(RegExp(r'\s+\b|\b\s'), " "))) {
                        return null;
                      } else {
                        return 'Numero de tarjeta invalido';
                      }
                    },
                    onSaved: (val) {
                      setState(() {
                        _departamento = val;
                      });
                    }),
                SizedBox(
                  height: 7,
                ),
                const Divider(
                  //Linea que separa
                  height: 1.0,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 160.0,
                      child: TextFormField(
                        autocorrect: false,
                        maxLength: 4,
                        decoration: InputDecoration(
                            labelText: 'Año', icon: Icon(Icons.calendar_today)),
                        validator: (val) {
                          if (val.isNotEmpty &&
                              int.parse(val) > 2000 &&
                              int.parse(val) < 2028) {
                            return null;
                          } else {
                            return 'Año invalido';
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Container(
                      width: 160.0,
                      child: TextFormField(
                        autocorrect: false,
                        maxLength: 2,
                        decoration: InputDecoration(
                            labelText: 'Mes', icon: Icon(Icons.calendar_today)),
                        validator: (val) {
                          if (val.isNotEmpty &&
                              int.parse(val) > 0 &&
                              int.parse(val) < 13) {
                            return null;
                          } else {
                            return 'Mes invalido';
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 7,
                ),
                const Divider(
                  //Linea que separa
                  height: 1.0,
                ),
                TextFormField(
                    autocorrect: false,
                    maxLength: 3,
                    decoration: InputDecoration(
                        labelText: 'CVC', icon: Icon(Icons.analytics)),
                    validator: (val) {
                      if (val.isNotEmpty && val.length > 2) {
                        return null;
                      } else {
                        return 'CVC invalido';
                      }
                    },
                    onSaved: (val) {
                      setState(() {
                        _barrio = val;
                      });
                    }),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _salir() {
    if (validar == "2" ||
        validar == "3" ||
        validar == "4" ||
        validar == "6" ||
        validar == "7" ||
        validar == "8" ||
        validar == "9") {
      Navigator.of(context).pushReplacementNamed('/Final');
    } else {
      Navigator.of(context).pushReplacementNamed('/EleccionMetodo');
    }
  }

  String _algoritmoValidacion() {
    String text;
    validar = random();
    if (validar == "2" ||
        validar == "3" ||
        validar == "4" ||
        validar == "6" ||
        validar == "7" ||
        validar == "8" ||
        validar == "9") {
      text = "Su tarjeta ha sido a aprobada, por favor de click en finalizar";
      return text;
    } else {
      return text = "Su Tarjeta no ha sido a aprobada... \nDe click en Ok!";
    }
  }
}

String random() {
  String numero;
  var rng = new Random();

  numero = (rng.nextInt(10)).toString();
  return numero;
}
