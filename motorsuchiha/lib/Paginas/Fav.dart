import 'dart:ui';
import '../provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:motorsuchiha/Paginas/Carrito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Fav extends StatefulWidget {
  final String name;
  final String image;
  final double price;
  int cantidad;

  Fav({this.name, this.cantidad, this.image, this.price});

  @override
  _FavState createState() => _FavState();
}

final TextStyle myStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
ProductProvider productProvider;
  User _user;
class _FavState extends State<Fav> {
  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Container(
      height: 150,
      width: double.infinity,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Container(
                  height: 130,
                  width: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.image),
                    ),
                  ),
                ),
                Container(
                  height: 140,
                  width: 200,
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.name),
                        Text(
                          "\$${widget.price.toString()}",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 30,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                GestureDetector(
                                  child: Icon(Icons.remove),
                                  onTap: () {
                                    setState(() {
                                      if (widget.cantidad > 1) {
                                        widget.cantidad--;
                                      }
                                    });
                                  },
                                ),
                                Text(widget.cantidad.toString(),
                                    style: myStyle),
                                GestureDetector(
                                  child: Icon(Icons.add),
                                  onTap: () {
                                    setState(() {
                                      widget.cantidad++;
                                    });
                                  },
                                ),
                              ]),
                        ),
                        Container(
                          height: 30,
                          width: 120,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Colors.redAccent,
                            child: Text(
                              "Add Carrito",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              _user = FirebaseAuth.instance.currentUser;
          FirebaseFirestore.instance
          .collection('Usuarios')
          .doc(_user.uid)
          .collection('MiCarrito')
          .doc()
          .set({
            'Nombreproducto': widget.name,
            'Cantidad': widget.cantidad,
            'Precio': widget.price,
            'Imagen': widget.image,
          })
          .then((value) => print("Carro añadido"))
          .catchError((error) => print("Fallo al añadir el carro: $error"));
                              
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (ctx) => Carrito(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
