import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:motorsuchiha/Paginas/Carrito.dart';
import 'package:motorsuchiha/Paginas/Fav.dart';

class CarritoSingle extends StatefulWidget {
  final String name;
  final String image;
  final double price;
  int cantidad;
  final int index;

  CarritoSingle({this.name, this.cantidad, this.image, this.price, this.index});

  @override
  _CarritoSingleState createState() => _CarritoSingleState();
}

TextStyle myStyle = TextStyle(
  fontSize: 18,
);

class _CarritoSingleState extends State<CarritoSingle> {
  @override
  Widget build(BuildContext context) {
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
                        Container(
                          height: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.name),
                              IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  productProvider
                                      .deleteCartProduct(widget.index);
                                },
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [Text("widget.color"), Text("data")],
                          ),
                        ),
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
