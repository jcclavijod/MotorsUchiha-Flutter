import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:motorsuchiha/model/products.dart';

class CategoryProvider with ChangeNotifier {
  Product alarmasData;

  List<Product> alarmas = [];
  // ignore: missing_return
  Future<void> getAlarmasData() async {
    List<Product> newList = [];
    // ignore: deprecated_member_use
    QuerySnapshot alarmasSnapShot = await Firestore.instance
        .collection("category")
        // ignore: deprecated_member_use
        .document("4ton5n1tQBHMnJ5jmJ4l")
        .collection("alarmas")
        // ignore: deprecated_member_use
        .getDocuments();
    alarmasSnapShot.docs.forEach(
      (element) {
        alarmasData = Product(
            image: element.data()["image"],
            name: element.data()["name"],
            precio: element.data()["precio"]);
        newList.add(alarmasData);
      },
    );
    alarmas = newList;
  }

  List<Product> searchAlarmasList(String query) {
    List<Product> searchAlarmas = alarmas.where((element) {
      return element.name.toUpperCase().contains(query) ||
          element.name.toLowerCase().contains(query);
    }).toList();
    return searchAlarmas;
  }

  List<Product> get getAlarmasList {
    return alarmas;
  }
}
