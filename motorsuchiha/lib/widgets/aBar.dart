import 'package:flutter/material.dart';
import 'package:motorsuchiha/Paginas/Carrito.dart';

AppBar aBar(context) {
  return AppBar(
    elevation: 0.1,
    backgroundColor: Colors.blue,
    title: Text('MotorsUchiha'),
    actions: <Widget>[
      new IconButton(
        icon: Icon(
          Icons.search,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
      new IconButton(
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => new Carrito()));
          })
    ],
  );
}
