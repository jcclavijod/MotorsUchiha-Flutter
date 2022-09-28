import 'package:flutter/material.dart';

class CarritoModel {
  final String name;
  final String image;
  final double precio;
  final int cantidad;
  CarritoModel(
      {@required this.cantidad,
      @required this.image,
      @required this.name,
      @required this.precio});
}
