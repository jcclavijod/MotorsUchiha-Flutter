import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function onPressed;
  final String name;

  MyButton({this.name, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.0),
      height: 45,
      width: double.infinity,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Text(
          name,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        color: Colors.redAccent,
        onPressed: onPressed,
      ),
    );
  }
}
