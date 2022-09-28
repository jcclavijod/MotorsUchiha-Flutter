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

@override
Drawer menu(context) {
  User _user;

  _salir() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/Login');
  }

  CollectionReference _agregar;
  _user = FirebaseAuth.instance.currentUser;
  _agregar = FirebaseFirestore.instance.collection('Usuarios');
  return Drawer(
    child: FutureBuilder<DocumentSnapshot>(
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
            new UserAccountsDrawerHeader(
              accountName: Text(data['Nombre']),
              accountEmail: Text(data['Correo']),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: new BoxDecoration(
                color: Colors.lightBlueAccent,
              ),
            ),
            Divider(),
            ///// Body menu
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new inicioPag()));
              },
              child: ListTile(
                title: Text('Inicio'),
                leading: Icon(Icons.home),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/MiCuenta');
              },
              child: ListTile(
                title: Text('Mi Cuenta'),
                leading: Icon(Icons.person),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/ListaGaraje');
              },
              child: ListTile(
                title: Text('Mi Garaje'),
                leading: Icon(Icons.car_repair),
              ),
            ),

            Divider(),
            InkWell(
              onTap: () {
                _salir();
              },
              child: ListTile(
                title: Text('Salir'),
                leading: Icon(
                  Icons.settings,
                  color: Colors.blue,
                ),
              ),
            ),
          ]);
        }),
  );
}
