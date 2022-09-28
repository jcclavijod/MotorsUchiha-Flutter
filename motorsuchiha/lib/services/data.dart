import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class dataController extends GetxController {
  Future getData(String collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await firebaseFirestore.collection(collection).get();
    return snapshot.docs;
  }

  ////Destacados
  Future queryData(String queryString) async {
    return FirebaseFirestore.instance
        .collection('products')
        .doc('vRSyQNgh8OnuT0s7zS5y')
        .collection('newachives')
        .where('name', isGreaterThanOrEqualTo: queryString)
        .get();
  }

  ////Nuevos
  Future queryNuevoData(String queryString) async {
    return FirebaseFirestore.instance
        .collection('products')
        .doc('vRSyQNgh8OnuT0s7zS5y')
        .collection('featureproduct')
        .where('name', isGreaterThanOrEqualTo: queryString)
        .get();
  }

  ////Alarmas
  Future queryAlarmaData(String queryString) async {
    return FirebaseFirestore.instance
        .collection('category')
        .doc('4ton5n1tQBHMnJ5jmJ4l')
        .collection('alarmas')
        .where('name', isGreaterThanOrEqualTo: queryString)
        .get();
  }

  ////farolas
  Future queryfarolasData(String queryString) async {
    return FirebaseFirestore.instance
        .collection('category')
        .doc('4ton5n1tQBHMnJ5jmJ4l')
        .collection('farolas')
        .where('name', isGreaterThanOrEqualTo: queryString)
        .get();
  }

  ////llantas
  Future queryllantasData(String queryString) async {
    return FirebaseFirestore.instance
        .collection('category')
        .doc('4ton5n1tQBHMnJ5jmJ4l')
        .collection('llantas')
        .where('name', isGreaterThanOrEqualTo: queryString)
        .get();
  }

  ////localizadores
  Future querylocalizadoresData(String queryString) async {
    return FirebaseFirestore.instance
        .collection('category')
        .doc('4ton5n1tQBHMnJ5jmJ4l')
        .collection('localizadores')
        .where('name', isGreaterThanOrEqualTo: queryString)
        .get();
  }

  ////volantes
  Future queryvolantesData(String queryString) async {
    return FirebaseFirestore.instance
        .collection('category')
        .doc('4ton5n1tQBHMnJ5jmJ4l')
        .collection('volantes')
        .where('name', isGreaterThanOrEqualTo: queryString)
        .get();
  }

  ////Destacados
  Future queryDestacadosData(String queryString) async {
    return FirebaseFirestore.instance
        .collection('products')
        .doc('vRSyQNgh8OnuT0s7zS5y')
        .collection('newachives')
        .where('name', isGreaterThanOrEqualTo: queryString)
        .get();
  }
}
