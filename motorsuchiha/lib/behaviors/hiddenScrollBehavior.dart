import 'package:flutter/material.dart';

//Quita la sombre del ListView
class HiddenScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
