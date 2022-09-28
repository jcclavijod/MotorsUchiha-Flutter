import 'package:flutter/material.dart';
import 'package:motorsuchiha/Paginas/Carrito.dart';
import 'package:motorsuchiha/Paginas/inicioPag.dart';
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

class MiCuenta extends StatefulWidget {
  @override
  _MiCuentaState createState() => _MiCuentaState();
}

class _MiCuentaState extends State<MiCuenta> {
  CollectionReference agregar =
      FirebaseFirestore.instance.collection('Usuarios');

  final _formKey = GlobalKey<
      FormState>(); //objeto que sirve para la validacion de los txtfield
  final _scaffoldKey = GlobalKey<
      ScaffoldState>(); //llave al scaffold para los menus contextuales

  User _user;

  _salir() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/Login');
  }

  CollectionReference _agregar;

  @override
  Widget build(BuildContext context) {
    _user = FirebaseAuth.instance.currentUser;
    _agregar = FirebaseFirestore.instance.collection('Usuarios');
    //Estas lineas sirven para no sobrepasar el ancho de de la pantala y del widget (AVERIGUAR MAS)
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: new Text('Mis Datos'),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed('/InicioPag'),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: _agregar.doc(_user.uid).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            Map<String, dynamic> data = snapshot.data.data();
            return ListView(children: <Widget>[
              //header

              Align(
                child: new Image(
                  width: 275.0,
                  height: 275.0,
                  image: AssetImage('assets/images/usuario1.png'),
                ),
              ),

              ///// Body menu
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text(data['Nombre']),
                  leading: Icon(Icons.person),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {},
                child: ListTile(
                  title: Text(data['Correo']),
                  leading: Icon(Icons.mail),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text(data['Telefono']),
                    leading: Icon(Icons.phone_android)),
              ),

              Divider(),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/Direcciones');
                },
                child: ListTile(
                  title: Text("Mis direcciones"),
                  leading: Icon(
                    Icons.maps_ugc_rounded,
                    color: Colors.blue,
                  ),
                ),
              ),
            ]);
          }),
    );
  }
}
