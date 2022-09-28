import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Ajustes extends StatefulWidget {
  @override
  _AjustesState createState() => _AjustesState();
}

class _AjustesState extends State<Ajustes> {
  CollectionReference datos = FirebaseFirestore.instance.collection('Usuarios');
  User _user;
  String nombre;
  String correo;
  _salir() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/Login');
  }

  _datosUsuario() async {
    _user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
      ),
      body: Center(
        child: FlatButton(
          onPressed: () {
            //_salir();
            Navigator.of(context).pushReplacementNamed('/ListaGaraje');
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Mi Garaje'),
              //Spacer(),
              Icon(
                Icons.exit_to_app,
              ),
              FlatButton(
                onPressed: () {
                  _salir();
                  //Navigator.of(context).pushReplacementNamed('/AgregarCarro');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Salir'),
                    //Spacer(),
                    Icon(
                      Icons.exit_to_app,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
