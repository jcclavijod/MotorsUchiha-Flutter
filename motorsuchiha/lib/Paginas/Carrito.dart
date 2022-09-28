import 'package:flutter/material.dart';
import 'package:motorsuchiha/Paginas/eleccionDireccion.dart';
import 'package:motorsuchiha/Paginas/inicioPag.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fancy_dialog/FancyAnimation.dart';
import 'package:fancy_dialog/FancyGif.dart';
import 'package:fancy_dialog/FancyTheme.dart';
import 'package:fancy_dialog/fancy_dialog.dart';

class Carrito extends StatefulWidget {
  final double price;
  final String name;
  final String image;
  Carrito({this.image, this.name, this.price});

  @override
  _CarritoState createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  final TextStyle myStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  int count = 1;
  int contador = 0;
  User _user;
  List<DocumentSnapshot> docs2;
  final _formKey = GlobalKey<
      FormState>(); //objeto que sirve para la validacion de los txtfield
  final _scaffoldKey = GlobalKey<
      ScaffoldState>(); //llave al scaffold para los menus contextuales
  CollectionReference _agregar;
  CollectionReference _agregarPedido =
      FirebaseFirestore.instance.collection('Usuarios');
  final _scrollController = ScrollController();
  var _firstScroll = true;
  bool _enabled = false;
  String _costo;

  Widget _buildProduct() {
    _user = FirebaseAuth.instance.currentUser;
    _agregar = FirebaseFirestore.instance
        .collection('Usuarios')
        .doc(_user.uid)
        .collection('MiCarrito');
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (_enabled && _firstScroll) {
            _scrollController
                .jumpTo(_scrollController.position.pixels - details.delta.dy);
          }
        },
        onVerticalDragEnd: (_) {
          if (_enabled) _firstScroll = false;
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder(
                stream: _agregar.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<DocumentSnapshot> docs = snapshot.data.docs;
                  docs2 = docs;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> data = docs[index].data();
                      return Column(children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2.0),
                            child: Column(
                              children: <Widget>[
                                Row(children: <Widget>[
                                  new Container(
                                    child: data['Imagen'] == ""
                                        ? Text("Sin Imagen")
                                        : Image.network(
                                            data['Imagen'] + '?alt=media',
                                            fit: BoxFit.fill,
                                            height: 120.0,
                                            width: 120.0,
                                          ),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        data['Nombreproducto'],
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 21.0,
                                        ),
                                      ),
                                      Text(
                                        data['Precio'].toString(),
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 21.0,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            '    ',
                                            style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 21.0,
                                            ),
                                          ),
                                          Container(
                                            width: 150,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color: Colors.red[600],
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 6.0,
                                                    color: Colors.blue[400],
                                                    offset: Offset(0.0, 1.0),
                                                  )
                                                ],
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(50.0),
                                                )),
                                            margin: EdgeInsets.only(top: 20.0),
                                            padding: EdgeInsets.all(2.0),
                                            child: new Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 0.0,
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.remove),
                                                  onPressed: () {
                                                    _disminuirCant(
                                                        docs2, index);
                                                    valorTotal(docs2);
                                                  },
                                                  color: Colors.yellow,
                                                ),
                                                Text(
                                                    data['Cantidad'].toString(),
                                                    style: new TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 22.0,
                                                        color: Colors.white)),
                                                IconButton(
                                                  icon: Icon(Icons.add),
                                                  onPressed: () {
                                                    _agregarCant(docs2, index);
                                                    valorTotal(docs2);
                                                  },
                                                  color: Colors
                                                      .yellow, // print(_cart);
                                                ),
                                                SizedBox(
                                                  height: 18.0,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Text(
                                    ' ',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 21.0,
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        _showDialog(
                                            _agregar, docs, context, index);
                                      }),
                                ]),
                              ],
                            )),
                        Divider(
                          color: Colors.purple,
                        ),
                      ]);
                    },
                  );
                },
              ),
              SizedBox(
                width: 10.0,
              ),
              pagoTotal(),
            ],
          ),
        ),
      ),
    );
  }

  double valorTotal(List<DocumentSnapshot> docs) {
    double total = 0.0;
    for (int i = 0; i < docs.length; i++) {
      total = total + docs[i].data()['Precio'] * docs[i].data()['Cantidad'];
    }
    return total;
  }

  double ivaCompra(double docs) {
    double iva = 0.0;
    iva = docs * 0.19;
    return iva;
  }

  String totalPagar(double subtotal, double iva) {
    double completo = 0.0;
    completo = subtotal + iva;
    return completo.toStringAsFixed(2);
  }

  _agregarCant(List<DocumentSnapshot> docs, int position) {
    int _valor;
    setState(() {
      _valor = docs[position].data()['Cantidad'] + 1;
      _agregar
          .doc(docs[position].id)
          .set({
            'Cantidad': _valor,
          }, SetOptions(merge: true))
          .then((value) => print("Cantidad aumentada"))
          .catchError((error) => print("Fallo al añadir la dirección: $error"));
    });
  }

  _disminuirCant(List<DocumentSnapshot> docs, int position) {
    int _valor;
    setState(() {
      if (docs[position].data()['Cantidad'] > 1) {
        _valor = docs[position].data()['Cantidad'] - 1;
        _agregar
            .doc(docs[position].id)
            .set({
              'Cantidad': _valor,
            }, SetOptions(merge: true))
            .then((value) => print("Cantidad disminuida"))
            .catchError(
                (error) => print("Fallo al añadir la dirección: $error"));
      }
    });
  }

  Container pagoTotal() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(left: 120),
      height: 70,
      width: 400,
      color: Colors.grey[200],
      child: Row(
        children: <Widget>[
          StreamBuilder(
              stream: _agregar.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<DocumentSnapshot> docs = snapshot.data.docs;
                _costo =
                    totalPagar(valorTotal(docs), ivaCompra(valorTotal(docs)));
                return Text(
                    "Subtotal: " +
                        valorTotal(docs).toStringAsFixed(2) +
                        "\nIva 19%: " +
                        ivaCompra(valorTotal(docs)).toStringAsFixed(2) +
                        "\nValor a pagar: " +
                        totalPagar(
                            valorTotal(docs), ivaCompra(valorTotal(docs))),
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.black));
              }),
          // Text("Total:  \$${valorTotal(_cart)}",
          //Text("Total:  ",
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 45,
        width: 100,
        child: RaisedButton(
            color: Colors.white,
            child: Text(
              "Pagar",
              style: myStyle,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => FancyDialog(
                        title: "ACEPTA PAGAR LA COMPRA?",
                        descreption: "Bien pues, Click OK",
                        animationType: FancyAnimation.BOTTOM_TOP,
                        theme: FancyTheme.FANCY,
                        gifPath: FancyGif.MOVE_FORWARD, //'./assets/walp.png',
                        okFun: () => {
                          _salir().ok,
                        },
                      ));
            }),
      ),
      appBar: AppBar(
        title: Text(
          'Carrito de compras',
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
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => inicioPag()),
            );
          },
        ),
      ),
      body: _buildProduct(),
    );
  }

  _salir() {
    Navigator.of(context).pushReplacementNamed('/eleccionDireccion');
  }
}

void _showDialog(CollectionReference _agregar, List<DocumentSnapshot> docs,
    context, position) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alerta'),
        content:
            Text('¿Estas seguro de querer eliminar este producto del carrito?'),
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
      .then((value) => print("El producto ha sido eliminado"))
      .catchError((error) => print("Failed to delete user: $error"));
  Navigator.of(context).pop();
}
