import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motorsuchiha/behaviors/hiddenScrollBehavior.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

import 'package:uuid/uuid.dart';

class AgregarAuto1 extends StatefulWidget {
  @override
  _AgregarAuto1State createState() => _AgregarAuto1State();
}

class _AgregarAuto1State extends State<AgregarAuto1> {
  CollectionReference agregar =
      FirebaseFirestore.instance.collection('Usuarios');

  final _formKey = GlobalKey<
      FormState>(); //objeto que sirve para la validacion de los txtfield
  final _scaffoldKey = GlobalKey<
      ScaffoldState>(); //llave al scaffold para los menus contextuales
  final picker = ImagePicker();
  File _image;
  User _user;
  String _nombreAuto;
  String _marca;
  String _year;
  String _numeroVin;
  String _numeroChasis;

  bool _registrado = false;

  Future<void> _registrarAuto() async {
    final form = _formKey.currentState; //hac
    form.save();
    _user = FirebaseAuth.instance.currentUser;
    if (_image != null) {
      var nombreImagen = Uuid().v1();
      var imagenpath = "/usuarios/$_user/$nombreImagen.jpg";
      final StorageReference storageReference =
          FirebaseStorage().ref().child(imagenpath);

      final StorageUploadTask uploadTask = storageReference.putFile(_image);

      final StreamSubscription<StorageTaskEvent> streamSubscription =
          uploadTask.events.listen((event) {
        print('EVENT ${event.type}');
      });

      // Cancel your subscription when done.
      await uploadTask.onComplete;
      streamSubscription.cancel();
      agregar
          .doc(_user.uid)
          .collection('MiGaraje')
          .doc()
          .set({
            'Nombre auto': _nombreAuto,
            'Marca': _marca,
            'Año': _year,
            'Numero VIN': _numeroVin,
            'Imagen': (await storageReference.getDownloadURL()).toString(),
          }, SetOptions(merge: true))
          .then((value) => print("Carro añadido"))
          .catchError((error) => print("Fallo al añadir el carro: $error"));
      Navigator.of(context).pushReplacementNamed('/InicioPag');
    }
  }

  Future _AlertaImagen() {
    AlertDialog alerta = AlertDialog(
      content: Text('Seleccione de la galeria la imagen de su auto.'),
      title: Text('Seleccione Imagen'),
      actions: <Widget>[
        FlatButton(
          onPressed: () async {
            var pickedFile = await picker.getImage(source: ImageSource.gallery);
            setState(() {
              if (pickedFile != null) {
                _image = File(pickedFile.path);
              } else {
                print('Imagen no seleccionada');
              }
              Navigator.of(context, rootNavigator: true).pop();
            });
          },
          child: Row(
            children: <Widget>[Text('Galeria'), Icon(Icons.image)],
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
    showDialog(context: context, child: alerta);
  }

  @override
  Widget build(BuildContext context) {
    //Estas lineas sirven para no sobrepasar el ancho de de la pantala y del widget (AVERIGUAR MAS)
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: new Text('Agregar automovil'),
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
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: _AlertaImagen,
                      ),
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.0, color: Colors.black),
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: _image == null
                                  ? AssetImage('assets/images/camara.png')
                                  : FileImage(_image))),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text('click para cambiar foto'),
                Padding(
                  padding: EdgeInsets.only(top: 10),
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
                    decoration: InputDecoration(
                        labelText: 'Nombre del auto',
                        icon: Icon(Icons.car_rental)),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Por favor ingrese una direccion valida'; //si anda mal
                      } else {
                        return null; //Si todo esta bien
                      }
                    },
                    onSaved: (val) {
                      setState(() {
                        _nombreAuto = val;
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
                        labelText: 'Marca',
                        icon: Icon(Icons.mobile_screen_share_sharp)),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Por favor ingrese un departamento valido'; //si anda mal
                      } else {
                        return null; //Si todo esta bien
                      }
                    },
                    onSaved: (val) {
                      setState(() {
                        _marca = val;
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
                        labelText: 'Año',
                        icon: Icon(Icons.calendar_today_sharp)),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Por favor ingrese una ciudad valida'; //si anda mal
                      } else {
                        return null; //Si todo esta bien
                      }
                    },
                    onSaved: (val) {
                      setState(() {
                        _year = val;
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
                        labelText: 'Vin', icon: Icon(Icons.qr_code_scanner)),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Por favor ingrese un barrio valido'; //si anda mal
                      } else {
                        return null; //Si todo esta bien
                      }
                    },
                    onSaved: (val) {
                      setState(() {
                        _numeroVin = val;
                      });
                    }),
                SizedBox(
                  height: 7,
                ),
                const Divider(
                  //Linea que separa
                  height: 1.0,
                ),
                SizedBox(
                  height: 7,
                ),
                const Divider(
                  //Linea que separa
                  height: 1.0,
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: <Widget>[
                    CupertinoButton(

                        //Boton del login
                        child: Text(
                          'Omitir',
                          style: TextStyle(color: Colors.grey),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/InicioPag');
                        }),
                    CupertinoButton(
                        //Boton del login
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(50.0),
                        child: Text('Registrar Auto'),
                        onPressed: () {
                          _registrarAuto();
                        })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
