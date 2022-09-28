import 'package:flutter/material.dart';

class FavoritoModel {
  final String name;
  final String image;
  final double precio;
  final int cantidad;
  FavoritoModel(
      {@required this.cantidad,
      @required this.image,
      @required this.name,
      @required this.precio});
}
