import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Seguimiento extends StatefulWidget {
  @override
  _SeguimientoState createState() => _SeguimientoState();
}

class _SeguimientoState extends State<Seguimiento> {
  final TextStyle myStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  User _user = FirebaseAuth.instance.currentUser;
  CollectionReference _agregar;
  bool showFirstContainer = true;

  double containerHeight = 150;
  double containerWidth = 150;
  int cont = -1;
  bool valor = false;

  Widget _buildProduct() {
    _agregar = FirebaseFirestore.instance
        .collection('Usuarios')
        .doc(_user.uid)
        .collection('Pedidos');
    if (cont < 1) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Align(
              child: new Image(
                width: 275.0,
                height: 275.0,
                image: AssetImage('assets/images/seguir.jpg'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                  'Tu pedido y una copia de la factura han sido entregados al transportador para ser llevado a tu destino. Muy pronto podrás disfrutar de tus productos.'),
            ),
            Divider(
              color: Colors.transparent,
              height: 40,
            ),
            Center(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 1000),
                child: showFirstContainer
                    ? Container(
                        key: UniqueKey(),
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.amberAccent,
                        ),
                        child: Center(child: Text('PEDIDO RECIBIDO')))
                    : Container(
                        key: UniqueKey(),
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.redAccent,
                        ),
                        child: Center(child: Text('PREPARANDO PAQUETE'))),
                switchOutCurve: Curves.easeInOutCubic,
                switchInCurve: Curves.fastLinearToSlowEaseIn,
                transitionBuilder:
                    (Widget child, Animation<double> animation) =>
                        RotationTransition(
                  turns: animation,
                  child: child,
                ),
              ),
            ),
          ],
        ),
      );
    }
    if (cont >= 1) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Align(
              child: new Image(
                width: 275.0,
                height: 275.0,
                image: AssetImage('assets/images/seguir.jpg'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Tu pedido y una copia de la factura han sido entregados al transportador para ser llevado a tu destino.\nMuy pronto podrás disfrutar de tus productos.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.0,
                ),
              ),
            ),
            Divider(
              color: Colors.transparent,
              height: 30,
            ),
            Center(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 1000),
                child: showFirstContainer
                    ? Container(
                        key: UniqueKey(),
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.lightGreen,
                        ),
                        child: Center(
                          child: Center(
                            child: Text('PAQUETE EN CAMINO'),
                          ),
                        ))
                    : Container(
                        key: UniqueKey(),
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.lightBlue,
                        ),
                        child: Center(child: Text('PAQUETE ENTREGADO'))),
                switchOutCurve: Curves.easeInOutCubic,
                switchInCurve: Curves.fastLinearToSlowEaseIn,
                transitionBuilder:
                    (Widget child, Animation<double> animation) =>
                        RotationTransition(
                  turns: animation,
                  child: child,
                ),
              ),
            ),
          ],
        ),
      );
    }

    //Estas lineas sirven para no sobrepasar el ancho de de la pantala y del widget (AVERIGUAR MAS)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Seguimiento pedido',
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
            Navigator.of(context).pushReplacementNamed('/Final');
          },
        ),
      ),
      body: _buildProduct(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          cont++;
          setState(() {
            showFirstContainer = !showFirstContainer;
          });
        },
        label: Text('Estado de la compra'),
      ),
    );
  }
}
