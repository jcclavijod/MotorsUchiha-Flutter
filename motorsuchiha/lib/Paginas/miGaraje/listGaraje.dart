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

class ListaGaraje extends StatefulWidget {
  @override
  _ListaGarajeState createState() => _ListaGarajeState();
}

class _ListaGarajeState extends State<ListaGaraje> {
  User _user;

  final _formKey = GlobalKey<
      FormState>(); //objeto que sirve para la validacion de los txtfield
  final _scaffoldKey = GlobalKey<
      ScaffoldState>(); //llave al scaffold para los menus contextuales
  CollectionReference _agregar;

  @override
  Widget build(BuildContext context) {
    _user = FirebaseAuth.instance.currentUser;
    _agregar = FirebaseFirestore.instance
        .collection('Usuarios')
        .doc(_user.uid)
        .collection('MiGaraje');
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed('/InicioPag'),
        ),
        title: new Text('Mi Garaje'),
      ),
      body: StreamBuilder(
        stream: _agregar.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<DocumentSnapshot> docs = snapshot.data.docs;
          return Center(
            child: ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data = docs[index].data();
                return Column(children: <Widget>[
                  Divider(
                    height: 2.0,
                  ),
                  Container(
                      padding: new EdgeInsets.all(3.0),
                      child: Card(
                        child: Row(children: <Widget>[
                          new Container(
                            padding: new EdgeInsets.all(5.0),
                            child: data['Imagen'] == ""
                                ? Text("Sin Imagen")
                                : Image.network(
                                    data['Imagen'] + '?alt=media',
                                    fit: BoxFit.fill,
                                    height: 150.0,
                                    width: 150.0,
                                  ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                data['Nombre auto'],
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 21.0,
                                ),
                              ),
                              subtitle: Text(
                                data['Marca'],
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 21.0,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                _showDialog(_agregar, docs, context, index);
                              }),
                        ]),
                      )),
                ]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.pinkAccent,
        onPressed: () =>
            Navigator.of(context).pushReplacementNamed('/AgregarCarro'),
      ),
    );
    //Estas lineas sirven para no sobrepasar el ancho de de la pantala y del widget (AVERIGUAR MAS)
  }
}

void _showDialog(CollectionReference _agregar, List<DocumentSnapshot> docs,
    context, position) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alerta'),
        content: Text('¿Estas seguro de querer eliminar este Auto?'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.purple,
            ),
            onPressed: () => _deleteProduct(
              context,
              _agregar,
              docs,
              position,
            ),
          ),
          new FlatButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void _deleteProduct(BuildContext context, CollectionReference _agregar,
    List<DocumentSnapshot> docs, int position) {
  _agregar
      .doc(docs[position].id)
      .delete()
      .then((value) => print("El auto ha sido eliminado"))
      .catchError((error) => print("Failed to delete user: $error"));
  Navigator.of(context).pop();
}
