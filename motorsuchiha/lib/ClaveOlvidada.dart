import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:motorsuchiha/behaviors/hiddenScrollBehavior.dart';

class ClaveOlvidada extends StatefulWidget {
  @override
  _ClaveOlvidadaState createState() => _ClaveOlvidadaState();
}

class _ClaveOlvidadaState extends State<ClaveOlvidada> {
  final _formKey = GlobalKey<
      FormState>(); //objeto que sirve para la validacion de los txtfield
  final _scaffoldKey = GlobalKey<
      ScaffoldState>(); //llave al scaffold para los menus contextuales

  String _correo;
  bool _claveOlvi = false;

  claveOlvidada() async {
    //async (asincrono) para poder hacer una llamada al endpoint de firebase
    if (_claveOlvi) return; //si se registra no se quiere que siga ejecutando
    setState(() {
      _claveOlvi = true;
    });

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Ingresando..'),
    ));

    final form = _formKey
        .currentState; //hacemos una referencia al state del form para poder usar sus metodos

    if (!form.validate()) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      setState(() {
        _claveOlvi = false;
      });
      return;
    }

    form.save(); //nos llama todos los onSave de cada formField
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _correo); //llamamos el metodo de crear correo y contraseña
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content:
            Text('la Contraseña fue enviada a su correo, por favor reviselo'),
        duration: Duration(seconds: 10),
      ));
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
        _claveOlvi = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: new Text('Reestablecer contraseña'),
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
            key: _formKey,
            //Formulario para el registro
            child: ListView(
              //Para que no se nos sobreponga el teclado
              children: <Widget>[
                SizedBox(
                  height: 45.0,
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
                  height: 40,
                ),
                CupertinoButton(
                    //Boton del login
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(50.0),
                    child: Text('Enviar correo'),
                    onPressed: () {
                      claveOlvidada();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
