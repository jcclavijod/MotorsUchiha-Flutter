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

class Direcciones extends StatefulWidget {
  @override
  _DireccionesState createState() => _DireccionesState();
}

class _DireccionesState extends State<Direcciones> {
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
        .collection('Direcciones');
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed('/InicioPag'),
        ),
        title: new Text('Mis direcciones'),
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
                            child: new Image(
                              width: 105.0,
                              height: 105.0,
                              image: AssetImage('assets/images/map.jpg'),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                data['Direccion'],
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 21.0,
                                ),
                              ),
                              subtitle: Text(
                                data['Ciudad'],
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 21.0,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.view_list_rounded,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                _showDialog(
                                    _agregar, docs, data, context, index);
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
            Navigator.of(context).pushReplacementNamed('/AgregarDireccion'),
      ),
    );
    //Estas lineas sirven para no sobrepasar el ancho de de la pantala y del widget (AVERIGUAR MAS)
  }
}

void _showDialog(CollectionReference _agregar, List<DocumentSnapshot> docs,
    Map<String, dynamic> data, context, position) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        title: Text('Mi Dirección'),
        content: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            new Container(
              padding: new EdgeInsets.all(20.0),
              child: new Image(
                width: 255.0,
                height: 205.0,
                image: AssetImage('assets/images/map.jpg'),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                  title: Text("Direccion: " + data['Direccion']),
                  leading: Icon(Icons.home)),
            ),
            SizedBox(
              height: 15,
            ),
            Divider(),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Departamento: " + data['Departamento']),
                leading: Icon(Icons.dashboard),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Divider(),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Ciudad: " + data['Ciudad']),
                leading: Icon(Icons.location_city),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Divider(),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text("Barrio: " + data['Barrio']),
                leading: Icon(
                  Icons.edit_location,
                  //color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          new FlatButton(
            child: Text('Volver'),
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
