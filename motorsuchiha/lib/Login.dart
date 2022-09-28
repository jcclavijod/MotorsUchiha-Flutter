import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motorsuchiha/behaviors/hiddenScrollBehavior.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<
      FormState>(); //objeto que sirve para la validacion de los txtfield
  final _scaffoldKey = GlobalKey<ScaffoldState>(); //llave al

  String _correo;
  String _clave;
  bool _registrado = false;

  _ingresar() async {
    //async (asincrono) para poder hacer una llamada al endpoint de firebase
    if (_registrado) return; //si se registra no se quiere que siga ejecutando
    setState(() {
      _registrado = true;
    });

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Ingresando..'),
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
          .signInWithEmailAndPassword(
              email: _correo,
              password:
                  _clave); //llamamos el metodo de crear correo y contraseña
      Navigator.of(context).pushReplacementNamed('/InicioPag');
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
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ScrollConfiguration(
          behavior: HiddenScrollBehavior(),
          child: Form(
            key: _formKey,
            //Formulario para el registro
            child: ListView(
              //Para que no se nos sobreponga el teclado
              children: <Widget>[
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    'MotorsUchiha',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold, //Fuente de la letra
                        fontSize: 45.0,
                        color: Colors.blueGrey),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  child: new Image(
                    width: 275.0,
                    height: 275.0,
                    image: AssetImage('assets/images/carrito.png'),
                  ),
                ),
                SizedBox(
                  height: 30,
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
                  height: 30,
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
                      return 'Por favor ingrese un correo valido'; //si anda mal
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
                  height: 40,
                ),
                CupertinoButton(
                    //Boton del login
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(50.0),
                    child: Text('Ingresar'),
                    onPressed: () {
                      _ingresar();
                    }),
                Row(
                  children: <Widget>[
                    CupertinoButton(
                        //Boton del login
                        child: Text(
                          'Olvide mi contraseña',
                          style: TextStyle(color: Colors.red[300]),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/ClaveOlvidada');
                        }),
                    CupertinoButton(
                        //Boton del login
                        child: Text('Registrarse',
                            style: TextStyle(color: Colors.green)),
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/Registro');
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
