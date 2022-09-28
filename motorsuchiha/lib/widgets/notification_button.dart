import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

import 'package:motorsuchiha/Paginas/favorito.dart';

class notificationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Badge(
      child: IconButton(
        icon: Icon(
          Icons.favorite_border_outlined,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Favorito()),
          );
        },
      ),
    );
  }
}
