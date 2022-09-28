import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motorsuchiha/behaviors/hiddenScrollBehavior.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AgregarDireccion extends StatefulWidget {
  @override
  _AgregarDireccionState createState() => _AgregarDireccionState();
}

class _AgregarDireccionState extends State<AgregarDireccion> {
  CollectionReference agregar =
      FirebaseFirestore.instance.collection('Usuarios');

  final _formKey = GlobalKey<
      FormState>(); //objeto que sirve para la validacion de los txtfield
  final _scaffoldKey = GlobalKey<
      ScaffoldState>(); //llave al scaffold para los menus contextuales

  User _user;

  String _direccion;
  String _departamento;
  String _ciudad;
  String _barrio;

  bool _registrado = false;

  Future<void> _registrarDireccion() async {
    _user = FirebaseAuth.instance.currentUser;
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Agregando dirección'),
    ));

    final form = _formKey.currentState;
    form.save();
    return agregar
        .doc(_user.uid)
        .collection('Direcciones')
        .doc()
        .set({
          'Direccion': _direccion,
          'Departamento': _departamento,
          'Ciudad': _ciudad,
          'Barrio': _barrio,
        }, SetOptions(merge: true))
        .then((value) => print("Dirección añadida"))
        .catchError((error) => print("Fallo al añadir la dirección: $error"));
  }

  @override
  Widget build(BuildContext context) {
    //Estas lineas sirven para no sobrepasar el ancho de de la pantala y del widget (AVERIGUAR MAS)
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed('/Direcciones'),
        ),
        title: new Text('Dirección alternativa'),
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
                    width: 355.0,
                    height: 270.0,
                    image: AssetImage('assets/images/map.jpg'),
                  ),
                ),
                const Divider(
                  //Linea que separa
                  height: 1.0,
                ),
                TextFormField(
                    autocorrect: false,
                    decoration: InputDecoration(
                        labelText: 'Dirección', icon: Icon(Icons.home)),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Por favor ingrese una direccion valida'; //si anda mal
                      } else {
                        return null; //Si todo esta bien
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
                    decoration: InputDecoration(
                        labelText: 'Departamento', icon: Icon(Icons.home)),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Por favor ingrese un departamento valido'; //si anda mal
                      } else {
                        return null; //Si todo esta bien
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
                TextFormField(
                    autocorrect: false,
                    decoration: InputDecoration(
                        labelText: 'Ciudad', icon: Icon(Icons.home)),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Por favor ingrese una ciudad valida'; //si anda mal
                      } else {
                        return null; //Si todo esta bien
                      }
                    },
                    onSaved: (val) {
                      setState(() {
                        _ciudad = val;
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
                    decoration: InputDecoration(
                        labelText: 'Barrio', icon: Icon(Icons.home)),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Por favor ingrese un barrio valido'; //si anda mal
                      } else {
                        return null; //Si todo esta bien
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
                CupertinoButton(

                    //Boton del login
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(50.0),
                    child: Text('Registrar dirección'),
                    onPressed: () {
                      _registrarDireccion();
                      Navigator.of(context)
                          .pushReplacementNamed('/Direcciones');
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
