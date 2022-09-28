import 'package:flutter/material.dart';
import 'package:motorsuchiha/Paginas/Carrito.dart';
import 'package:motorsuchiha/Paginas/details.dart';
import 'package:motorsuchiha/Paginas/listproducts.dart';
import 'package:motorsuchiha/Paginas/searchpag.dart';
import 'package:motorsuchiha/provider/category_provider.dart';
import 'package:motorsuchiha/widgets/myButtonSearch.dart';
import 'package:motorsuchiha/widgets/notification_button.dart';
import 'package:motorsuchiha/widgets/singeproduct.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:motorsuchiha/model/products.dart';
import '../model/products.dart';

// ignore: camel_case_types
class inicioPag extends StatefulWidget {
  @override
  _inicioPagState createState() => _inicioPagState();
}

Product volanteData;
CategoryProvider provider;
Product camaraData;

var nuevoSnapshot;
var destacadoSnapshot;

///Categorias///
var alarmas;
var farolas;
var llantas;
var localizadores;
var volantes;

///Nuevos Productos////
Product aspiradoraData;
Product farolaData;

class _inicioPagState extends State<inicioPag> {
  bool carrocolor = false;
  bool garajercolor = false;
  bool inciocolor = true;
  bool salircolor = false;

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  Widget _buildCategoryProduct({String image, int color}) {
    return CircleAvatar(
      maxRadius: 37,
      backgroundColor: Color(color),
      child: Container(
          height: 40,
          child: Image(
              color: Colors.white, image: AssetImage("assets/images/$image"))),
    );
  }

  Widget _buildMyDrawer() {
    User _user;

    _salir() async {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacementNamed('/Login');
    }

    CollectionReference _agregar;
    _user = FirebaseAuth.instance.currentUser;
    _agregar = FirebaseFirestore.instance.collection('Usuarios');
    return Drawer(
      child: FutureBuilder<DocumentSnapshot>(
          future: _agregar.doc(_user.uid).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            Map<String, dynamic> data = snapshot.data.data();
            return ListView(children: <Widget>[
              //header
              new UserAccountsDrawerHeader(
                accountName: Text(data['Nombre']),
                accountEmail: Text(data['Correo']),
                currentAccountPicture: GestureDetector(
                  child: new CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
                decoration: new BoxDecoration(
                  color: Colors.lightBlueAccent,
                ),
              ),
              Divider(),
              ///// Body menu
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new inicioPag()));
                },
                child: ListTile(
                  title: Text('Inicio'),
                  leading: Icon(Icons.home),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/MiCuenta');
                },
                child: ListTile(
                  title: Text('Mi Cuenta'),
                  leading: Icon(Icons.person),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/ListaGaraje');
                },
                child: ListTile(
                  title: Text('Mi Garaje'),
                  leading: Icon(Icons.car_repair),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/Carrito');
                },
                child: ListTile(
                  title: Text('Mi carrito'),
                  leading: Icon(Icons.shopping_cart),
                ),
              ),

              Divider(),
              InkWell(
                onTap: () {
                  _salir();
                },
                child: ListTile(
                  title: Text('Salir'),
                  leading: Icon(
                    Icons.settings,
                    color: Colors.blue,
                  ),
                ),
              ),
            ]);
          }),
    );
  }

  Widget _buildImage() {
    return Container(
      height: 200,
      child: Carousel(
        dotColor: Colors.white,
        autoplay: true,
        showIndicator: false,
        dotSize: 20,
        images: [
          AssetImage("assets/images/gps.jpg"),
          AssetImage("assets/images/pantalla.jpg"),
          AssetImage("assets/images/camara.jpg"),
        ],
      ),
    );
  }

  Widget _buildCategory() {
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Categorias",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          height: 52,
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ListProducts(
                        name: "Volantes",
                        snapShot: volantes,
                      ),
                    ),
                  );
                },
                child: _buildCategoryProduct(
                    image: "volante.png", color: 0xff33dcfd),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ListProducts(
                          name: "Alarmas",
                          snapShot: alarmas,
                        ),
                      ),
                    );
                  },
                  child: _buildCategoryProduct(
                      image: "sensor.png", color: 0xff4ff2af)),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => ListProducts(
                          name: "Farolas",
                          snapShot: farolas,
                        ),
                      ),
                    );
                  },
                  child: _buildCategoryProduct(
                      image: "puerta.png", color: 0xff38dcdd)),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ListProducts(
                          name: "Llantas",
                          snapShot: llantas,
                        ),
                      ),
                    );
                  },
                  child: _buildCategoryProduct(
                      image: "llanta.png", color: 0xff74acf7)),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => ListProducts(
                          name: "Localizadores",
                          snapShot: localizadores,
                        ),
                      ),
                    );
                  },
                  child: _buildCategoryProduct(
                      image: "ubi.png", color: 0xfffc6c8d)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDestacados() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Destacados',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => ListProducts(
                          name: "Destacados",
                          snapShot: nuevoSnapshot,
                        )));
              },
              child: Text(
                "Ver todo",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Row(children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Details(
                      image: volanteData.image,
                      price: volanteData.precio,
                      name: volanteData.name),
                ),
              );
            },
            child: SingleProduct(
                image: volanteData.image,
                price: volanteData.precio,
                name: volanteData.name),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Details(
                      image: camaraData.image,
                      price: camaraData.precio,
                      name: camaraData.name),
                ),
              );
            },
            child: SingleProduct(
                image: camaraData.image,
                price: camaraData.precio,
                name: camaraData.name),
          ),
        ]),
      ],
    );
  }

  Widget _buildNuevos() {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Nuevos',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => ListProducts(
                                name: "Nuevos",
                                snapShot: destacadoSnapshot,
                              )));
                    },
                    child: Text(
                      "Ver todo",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => Details(
                              image: aspiradoraData.image,
                              price: aspiradoraData.precio,
                              name: aspiradoraData.name),
                        ),
                      );
                    },
                    child: SingleProduct(
                        image: aspiradoraData.image,
                        price: aspiradoraData.precio,
                        name: aspiradoraData.name),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => Details(
                              image: farolaData.image,
                              price: farolaData.precio,
                              name: farolaData.name),
                        ),
                      );
                    },
                    child: SingleProduct(
                        image: farolaData.image,
                        price: farolaData.precio,
                        name: farolaData.name),
                  ),
                ]),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    /*rovider = Provider.of<CategoryProvider>(context);
    provider.getAlarmasData();*/
    return Scaffold(
        key: _key,
        drawer: _buildMyDrawer(),
        appBar: AppBar(
          title: Text(
            'Inicio',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.grey[100],
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              _key.currentState.openDrawer();
            },
          ),
          actions: <Widget>[
            SearchButton(),
            notificationButton(),
          ],
        ),
        body: FutureBuilder(
            // ignore: deprecated_member_use
            future: Firestore.instance
                .collection("products")
                // ignore: deprecated_member_use
                .document("vRSyQNgh8OnuT0s7zS5y")
                .collection("featureproduct")
                // ignore: deprecated_member_use
                .getDocuments(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<DocumentSnapshot> docs = snapshot.data.docs;
              nuevoSnapshot = snapshot;
              volanteData = Product(
                  // ignore: deprecated_member_use
                  image: docs[0].data()['image'],
                  // ignore: deprecated_member_use
                  name: docs[0].data()['name'],
                  // ignore: deprecated_member_use
                  precio: docs[0].data()['precio']);
              camaraData = Product(
                  // ignore: deprecated_member_use
                  image: docs[4].data()['image'],
                  // ignore: deprecated_member_use
                  name: docs[4].data()['name'],
                  // ignore: deprecated_member_use
                  precio: docs[4].data()['precio']);
              return FutureBuilder(
                  // ignore: deprecated_member_use
                  future: Firestore.instance
                      .collection("category")
                      // ignore: deprecated_member_use
                      .document("4ton5n1tQBHMnJ5jmJ4l")
                      .collection("alarmas")
                      // ignore: deprecated_member_use
                      .getDocuments(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> alarmasSnapshot) {
                    if (alarmasSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    List<DocumentSnapshot> docs = snapshot.data.docs;
                    alarmas = alarmasSnapshot;

                    ///farolas///
                    return FutureBuilder(
                        // ignore: deprecated_member_use
                        future: Firestore.instance
                            .collection("category")
                            // ignore: deprecated_member_use
                            .document("4ton5n1tQBHMnJ5jmJ4l")
                            .collection("farolas")
                            // ignore: deprecated_member_use
                            .getDocuments(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot> farolasSnapshot) {
                          if (farolasSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          // ignore: unused_local_variable
                          List<DocumentSnapshot> docs = snapshot.data.docs;
                          farolas = farolasSnapshot;

                          ///Volantes///
                          return FutureBuilder(
                              // ignore: deprecated_member_use
                              future: Firestore.instance
                                  .collection("category")
                                  // ignore: deprecated_member_use
                                  .document("4ton5n1tQBHMnJ5jmJ4l")
                                  .collection("volantes")
                                  // ignore: deprecated_member_use
                                  .getDocuments(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot>
                                      volantesSnapshot) {
                                if (volantesSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                // ignore: unused_local_variable
                                List<DocumentSnapshot> docs =
                                    snapshot.data.docs;
                                volantes = volantesSnapshot;

                                ///Localizadores///
                                return FutureBuilder(
                                    // ignore: deprecated_member_use
                                    future: Firestore.instance
                                        .collection("category")
                                        // ignore: deprecated_member_use
                                        .document("4ton5n1tQBHMnJ5jmJ4l")
                                        .collection("localizadores")
                                        // ignore: deprecated_member_use
                                        .getDocuments(),
                                    builder: (context,
                                        AsyncSnapshot<QuerySnapshot>
                                            localizadoresSnapshot) {
                                      if (localizadoresSnapshot
                                              .connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      // ignore: unused_local_variable
                                      List<DocumentSnapshot> docs =
                                          snapshot.data.docs;
                                      localizadores = localizadoresSnapshot;

                                      ///Llantas///
                                      return FutureBuilder(
                                          // ignore: deprecated_member_use
                                          future: Firestore.instance
                                              .collection("category")
                                              // ignore: deprecated_member_use
                                              .document("4ton5n1tQBHMnJ5jmJ4l")
                                              .collection("llantas")
                                              // ignore: deprecated_member_use
                                              .getDocuments(),
                                          builder: (context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  llantasSnapshot) {
                                            if (llantasSnapshot
                                                    .connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                            // ignore: unused_local_variable
                                            List<DocumentSnapshot> docs =
                                                snapshot.data.docs;
                                            llantas = llantasSnapshot;

                                            return FutureBuilder(
                                                // ignore: deprecated_member_use
                                                future: Firestore.instance
                                                    .collection("products")
                                                    // ignore: deprecated_member_use
                                                    .document(
                                                        "vRSyQNgh8OnuT0s7zS5y")
                                                    .collection("newachives ")
                                                    // ignore: deprecated_member_use
                                                    .getDocuments(),
                                                builder: (context,
                                                    AsyncSnapshot<QuerySnapshot>
                                                        snapShot) {
                                                  if (snapShot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  }
                                                  List<DocumentSnapshot> docs =
                                                      snapShot.data.docs;
                                                  destacadoSnapshot = snapShot;
                                                  aspiradoraData = Product(
                                                      // ignore: deprecated_member_use
                                                      image: docs[0]
                                                          .data()['image'],
                                                      // ignore: deprecated_member_use
                                                      name: docs[0]
                                                          .data()['name'],
                                                      // ignore: deprecated_member_use
                                                      precio: docs[0]
                                                          .data()['precio']);
                                                  farolaData = Product(
                                                      // ignore: deprecated_member_use
                                                      image: docs[1]
                                                          .data()['image'],
                                                      // ignore: deprecated_member_use
                                                      name: docs[1]
                                                          .data()['name'],
                                                      // ignore: deprecated_member_use
                                                      precio: docs[1]
                                                          .data()['precio']);

                                                  return Container(
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    child: ListView(
                                                      children: <Widget>[
                                                        Column(
                                                          children: <Widget>[
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          10),
                                                              child: Container(
                                                                height: 600,
                                                                width: double
                                                                    .infinity,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: <
                                                                      Widget>[
                                                                    _buildImage(),
                                                                    _buildCategory(),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    _buildDestacados(),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            _buildNuevos(),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                });
                                          });
                                    });
                              });
                        });
                  });
            }));
  }
}
