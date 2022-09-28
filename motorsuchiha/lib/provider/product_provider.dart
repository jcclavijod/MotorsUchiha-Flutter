import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motorsuchiha/model/Favoritomodel.dart';
import 'package:motorsuchiha/model/carritomodel.dart';
import 'package:flutter/material.dart';
import 'package:motorsuchiha/model/products.dart';

class ProductProvider with ChangeNotifier {
  List<Product> feature = [];
  Product featureData;
  List<CarritoModel> carritoModelList = [];
  CarritoModel cartModel;
  List<FavoritoModel> favoritoModelList = [];
  FavoritoModel favModel;

  void getCartData({
    String name,
    double precio,
    String image,
    int cantidad,
  }) {
    cartModel = CarritoModel(
        cantidad: cantidad, image: image, name: name, precio: precio);
    carritoModelList.add(cartModel);
  }

  List<CarritoModel> get getCarritoModelList {
    return List.from(carritoModelList);
  }

  int get getCarritoModelListLength {
    return carritoModelList.length;
  }

  void getFavData({
    String name,
    double precio,
    String image,
    int cantidad,
  }) {
    favModel = FavoritoModel(
        cantidad: cantidad, image: image, name: name, precio: precio);
    favoritoModelList.add(favModel);
  }

  List<FavoritoModel> get getfavoritoModelList {
    return List.from(favoritoModelList);
  }

  int get getfavoritoModelListLength {
    return favoritoModelList.length;
  }

  void deleteCartProduct(int index) {
    carritoModelList.removeAt(index);
  }

  void deletefavorit(int index) {
    favoritoModelList.removeAt(index);
    notifyListeners();
  }

  Future<void> getFeatureData() async {
    List<Product> newList = [];
    QuerySnapshot featureSnapShot = await FirebaseFirestore.instance
        .collection("products")
        .doc("vRSyQNgh8OnuT0s7zS5y")
        .collection("featureproduct")
        .get();
    featureSnapShot.docs.forEach(
      (element) {
        featureData = Product(
            image: element.data()["image"],
            name: element.data()["name"],
            precio: element.data()["price"]);
        newList.add(featureData);
      },
    );
    feature = newList;
  }

  List<Product> get getFeatureList {
    return feature;
  }

  List<Product> newAchives = [];
  Product newAchivesData;
  Future<void> getNewAchiveData() async {
    List<Product> newList = [];
    QuerySnapshot achivesSnapShot = await FirebaseFirestore.instance
        .collection("products")
        .doc("vRSyQNgh8OnuT0s7zS5y")
        .collection("newachives")
        .get();
    achivesSnapShot.docs.forEach(
      (element) {
        newAchivesData = Product(
            image: element.data()["image"],
            name: element.data()["name"],
            precio: element.data()["precio"]);
        newList.add(newAchivesData);
      },
    );
    newAchives = newList;
    notifyListeners();
  }

  List<Product> get getNewAchiesList {
    return newAchives;
  }
}
