import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:motorsuchiha/Paginas/searchpag.dart';

class SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Badge(
      child: IconButton(
        icon: Icon(
          Icons.search_rounded,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Search()),
          );
        },
      ),
    );
  }
}
