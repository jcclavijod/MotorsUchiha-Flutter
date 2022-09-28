import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EleccionDireccion extends StatefulWidget {
  @override
  _EleccionDireccionState createState() => _EleccionDireccionState();
}

class _EleccionDireccionState extends State<EleccionDireccion> {
  var _listKey;
  User _user;

  //objeto que sirve para la validacion de los txtfield
  final _scaffoldKey = GlobalKey<
      ScaffoldState>(); //llave al scaffold para los menus contextuales
  CollectionReference _agregar;
  final TextStyle myStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  bool check;

  @override
  Widget build(BuildContext context) {
    _user = FirebaseAuth.instance.currentUser;
    _agregar = FirebaseFirestore.instance
        .collection('Usuarios')
        .doc(_user.uid)
        .collection('Direcciones');
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
              Navigator.of(context).pushReplacementNamed('/EleccionMetodo');
            }),
      ),
      appBar: AppBar(
        title: Text(
          'Dirección entrega',
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
            Navigator.of(context).pushReplacementNamed('/Carrito');
          },
        ),
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
                int numer = docs.length;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    RadioListTile(
                        value: 1,
                        groupValue: data['Eleccion'],
                        title: Text(data['Direccion'] + ' - ' + data['Barrio']),
                        subtitle:
                            Text(data['Departamento'] + ', ' + data['Ciudad']),
                        activeColor: Colors.green,
                        onChanged: (value) async {
                          print(check);

                          setState(
                            () {
                              for (int idx = 0; idx < numer; idx++) {
                                if (idx == index) {
                                  _pedido(docs, index);
                                  print('hola');
                                } else {
                                  FirebaseFirestore.instance
                                      .collection('Usuarios')
                                      .doc(_user.uid)
                                      .collection('Direcciones')
                                      .doc(docs[idx].id)
                                      .set({
                                    'Eleccion': 0,
                                  }, SetOptions(merge: true));
                                }
                              }
                              FirebaseFirestore.instance
                                  .collection('Usuarios')
                                  .doc(_user.uid)
                                  .collection('Direcciones')
                                  .doc(docs[index].id)
                                  .set({
                                'Eleccion': value,
                              }, SetOptions(merge: true));
                              check = value;
                            },
                          );
                        }),
                    Divider(
                      height: 20,
                      color: Colors.green,
                    )
                  ],
                );
              },
            ),
          );
        },
      ),
    );
    //Estas lineas sirven para no sobrepasar el ancho de de la pantala y del widget (AVERIGUAR MAS)
  }

  Future<void> _pedido(List<DocumentSnapshot> docs, int index) async {
    return FirebaseFirestore.instance
        .collection('Usuarios')
        .doc(_user.uid)
        .collection('Pedidos')
        .doc(_user.uid)
        .set({
          'Direccion': docs[index].data()['Direccion'],
          'Barrio': docs[index].data()['Barrio'],
          'Localidad': docs[index].data()['Departamento'],
          'Ciudad': docs[index].data()['Ciudad'],
        })
        .then((value) => print("Direccion Añadida"))
        .catchError((error) => print("Fallo al añadir el usuario: $error"));
  }
}
