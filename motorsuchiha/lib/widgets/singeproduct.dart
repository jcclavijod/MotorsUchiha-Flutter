import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  final double price;
  final String name;
  SingleProduct({this.image, this.price, this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Container(
          height: 250,
          width: 170,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 170,
                width: 160,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill, image: NetworkImage(image))),
              ),
              Text(
                "\$ ${price.toString()}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Color(0xff9b96d6)),
              ),
              Text(
                name,
                style: TextStyle(fontSize: 17),
              )
            ],
          ),
        ),
      ),
    );
  }
}
