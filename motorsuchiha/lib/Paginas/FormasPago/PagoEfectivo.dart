import 'dart:math';
import 'package:flutter/material.dart';
import 'package:motorsuchiha/Paginas/FormasPago/eleccionMetodo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PagoEfectivo extends StatefulWidget {
  @override
  _PagoEfectivoState createState() => _PagoEfectivoState();
}

class _PagoEfectivoState extends State<PagoEfectivo> {
  final TextStyle myStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  int count = 1;
  User _user;
  List<DocumentSnapshot> docs2;
  final _formKey = GlobalKey<
      FormState>(); //objeto que sirve para la validacion de los txtfield
  final _scaffoldKey = GlobalKey<
      ScaffoldState>(); //llave al scaffold para los menus contextuales
  CollectionReference _agregar;
  final _scrollController = ScrollController();
  var _firstScroll = true;
  bool _enabled = false;

  Widget _buildProduct() {
    _user = FirebaseAuth.instance.currentUser;
    _agregar = FirebaseFirestore.instance
        .collection('Usuarios')
        .doc(_user.uid)
        .collection('MiCarrito');
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (_enabled && _firstScroll) {
            _scrollController
                .jumpTo(_scrollController.position.pixels - details.delta.dy);
          }
        },
        onVerticalDragEnd: (_) {
          if (_enabled) _firstScroll = false;
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Divider(
                color: Colors.transparent,
              ),
              Divider(
                color: Colors.transparent,
              ),
              Align(
                child: new Image(
                  width: 275.0,
                  height: 275.0,
                  image: AssetImage('assets/images/efecty.jpg'),
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
              Divider(
                color: Colors.transparent,
              ),
              Divider(
                color: Colors.transparent,
              ),
              Divider(
                color: Colors.transparent,
              ),
              Text(
                'Código efecty ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 31.0,
                ),
              ),
              SizedBox(
                width: 200.0,
              ),
              Divider(
                color: Colors.transparent,
              ),
              Divider(
                color: Colors.transparent,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 5.0,
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.black),
                      shape: BoxShape.circle,
                      color: Colors.blueGrey,
                    ),
                    child: Center(
                      child: Text(
                        random(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 31.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.black),
                      shape: BoxShape.circle,
                      color: Colors.amberAccent,
                    ),
                    child: Center(
                      child: Text(random(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 31.0,
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.black),
                      shape: BoxShape.circle,
                      color: Colors.lightGreen,
                    ),
                    child: Center(
                      child: Text(random(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 31.0,
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.black),
                      shape: BoxShape.circle,
                      color: Colors.lightBlue,
                    ),
                    child: Center(
                      child: Text(random(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 31.0,
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    //Estas lineas sirven para no sobrepasar el ancho de de la pantala y del widget (AVERIGUAR MAS)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Navigator.of(context).pushReplacementNamed('/Final');
            }),
      ),
      appBar: AppBar(
        title: Text(
          'Pago en efectivo',
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
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => EleccionMetodo()),
            );
          },
        ),
      ),
      body: _buildProduct(),
    );
  }
}

String random() {
  String numero;
  var rng = new Random();

  numero = (rng.nextInt(10)).toString();
  return numero;
}
