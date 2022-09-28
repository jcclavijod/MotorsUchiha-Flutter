import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motorsuchiha/behaviors/hiddenScrollBehavior.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Registro extends StatefulWidget {
  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  CollectionReference agregar =
      FirebaseFirestore.instance.collection('Usuarios');

  final _formKey = GlobalKey<
      FormState>(); //objeto que sirve para la validacion de los txtfield
  final _scaffoldKey = GlobalKey<
      ScaffoldState>(); //llave al scaffold para los menus contextuales

  User _user;

  String _nombre;
  String _correo;
  String _clave;
  String _telefono;
  String _direccion;
  String _departamento;
  String _ciudad;
  String _barrio;

  bool _registrado = false;

  Future<void> _registrarDireccion() async {
    _user = FirebaseAuth.instance.currentUser;
    return agregar
        .doc(_user.uid)
        .collection('Direcciones')
        .doc()
        .set({
          'Direccion': _direccion,
          'Departamento': _departamento,
          'Ciudad': _ciudad,
          'Barrio': _barrio,
        })
        .then((value) => print("Direccion Añadida"))
        .catchError((error) => print("Fallo al añadir el usuario: $error"));
  }

  Future<void> _registrarDatos() async {
    _user = FirebaseAuth.instance.currentUser;
    return agregar
        .doc(_user.uid)
        .set({
          'Nombre': _nombre,
          'Correo': _correo,
          'Telefono': _telefono,
        })
        .then((value) => print("Usiuario añadido"))
        .catchError((error) => print("Fallo al añadir el usuario: $error"));
  }

  _registroAuth() async {
    //async (asincrono) para poder hacer una llamada al endpoint de firebase
    if (_registrado) return; //si se registra no se quiere que siga ejecutando
    setState(() {
      _registrado = true;
    });

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Registrando usuario'),
    ));

    final form = _formKey
        .currentState; //hacemos una referencia al state del form para poder usar sus metodos

    if (!form.validate()) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      setState(() {
        _registrado = false;
      });
      return;
    }

    form.save(); //nos llama todos los onSave de cada formField
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _correo,
              password:
                  _clave); //llamamos el metodo de crear correo y contraseña
      _registrarDatos();
      _registrarDireccion();
      Navigator.of(context).pushReplacementNamed('/AgregarDireccion1');
    } catch (e) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(e.message),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
              label: "Descartar",
              onPressed: () {
                _scaffoldKey.currentState.hideCurrentSnackBar();
              })));
    } finally {
      setState(() {
        _registrado = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //Estas lineas sirven para no sobrepasar el ancho de de la pantala y del widget (AVERIGUAR MAS)
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: new Text('Registro'),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pushReplacementNamed('/Login'),
        ),
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
                const Divider(
                  //Linea que separa
                  height: 1.0,
                ),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: 'Nombre', icon: Icon(Icons.verified_user)),
                  onSaved: (val) {
                    setState(() {
                      _nombre = val;
                    });
                  },
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
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'Correo', icon: Icon(Icons.email)),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Por favor ingrese un correo valido'; //si anda mal
                    } else {
                      return null; //Si todo esta bien
                    }
                  },
                  onSaved: (val) {
                    setState(() {
                      _correo = val;
                    });
                  },
                ),
                SizedBox(
                  height: 7,
                ),
                const Divider(
                  //Linea que separa
                  height: 1.0,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Contraseña', icon: Icon(Icons.vpn_key)),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Por favor ingrese una contraseña valida'; //si anda mal
                    } else {
                      return null; //Si todo esta bien
                    }
                  },
                  onSaved: (val) {
                    setState(() {
                      _clave = val;
                    });
                  },
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
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        labelText: 'Telefono', icon: Icon(Icons.phone)),
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Por favor ingrese un numero valido'; //si anda mal
                      } else {
                        return null; //Si todo esta bien
                      }
                    },
                    onSaved: (val) {
                      setState(() {
                        _telefono = val;
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
                    child: Text('Registrarse'),
                    onPressed: () {
                      _registroAuth();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
