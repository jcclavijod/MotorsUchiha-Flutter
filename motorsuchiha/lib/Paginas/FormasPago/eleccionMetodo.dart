import 'package:flutter/material.dart';
import 'package:motorsuchiha/Paginas/Carrito.dart';
import 'package:motorsuchiha/Paginas/FormasPago/InfoTarjeta.dart';
import 'package:motorsuchiha/Paginas/checkout.dart';
import 'package:motorsuchiha/Paginas/inicioPag.dart';
import 'package:motorsuchiha/widgets/notification_button.dart';
import 'dart:async';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motorsuchiha/behaviors/hiddenScrollBehavior.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:fancy_dialog/FancyAnimation.dart';
import 'package:fancy_dialog/FancyGif.dart';
import 'package:fancy_dialog/FancyTheme.dart';
import 'package:fancy_dialog/fancy_dialog.dart';
import 'PagoEfectivo.dart';

class EleccionMetodo extends StatefulWidget {
  @override
  _EleccionMetodoState createState() => _EleccionMetodoState();
}

class _EleccionMetodoState extends State<EleccionMetodo> {
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
              Align(
                child: new Image(
                  width: 275.0,
                  height: 275.0,
                  image: AssetImage('assets/images/metodos.jpg'),
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
              Divider(
                color: Colors.transparent,
              ),
              Divider(
                color: Colors.purple,
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 200,
                    height: 80,
                    child: CupertinoButton(
                        //Boton del login
                        minSize: 10.0,
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(7000.0),
                        child: Text('PAGAR'),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => InfoTarjeta()),
                          );
                        }),
                  ),
                  Divider(
                    color: Colors.purple,
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    'Credito',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 21.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 100.0,
              ),
              Divider(
                color: Colors.purple,
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 200,
                    height: 80,
                    child: CupertinoButton(
                        //Boton del login
                        minSize: 10.0,
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(7000.0),
                        child: Text('PAGAR'),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => InfoTarjeta()),
                          );
                        }),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    'Debito',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 21.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 100.0,
              ),
              Divider(
                color: Colors.purple,
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 200,
                    height: 80,
                    child: CupertinoButton(
                        //Boton del login
                        minSize: 10.0,
                        color: Colors.lightGreen,
                        borderRadius: BorderRadius.circular(7000.0),
                        child: Text('PAGAR'),
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/PagoEfectivo');
                        }),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    'Efectivo ',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 21.0,
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
      appBar: AppBar(
        title: Text(
          'Métodos de pago',
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
              MaterialPageRoute(builder: (context) => Carrito()),
            );
          },
        ),
      ),
      body: _buildProduct(),
    );
  }
}
