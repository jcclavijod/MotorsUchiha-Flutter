import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motorsuchiha/Paginas/details.dart';
import 'package:motorsuchiha/busqueda/Filtro.dart';
import 'package:motorsuchiha/services/data.dart';
import 'package:motorsuchiha/Paginas/searchpag.dart';

class SearchLocalizador extends StatefulWidget {
  @override
  _SearchLocalizadorState createState() => _SearchLocalizadorState();
}

class _SearchLocalizadorState extends State<SearchLocalizador> {
  final TextEditingController searchController = TextEditingController();
  QuerySnapshot snapshotData;
  bool isExcecuted = false;
  @override
  Widget build(BuildContext context) {
    Widget searchedData() {
      return ListView.builder(
        itemCount: snapshotData.docs.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Details(
                    image: snapshotData.docs[index].data()['image'],
                    price: snapshotData.docs[index].data()['precio'],
                    name: snapshotData.docs[index].data()['name'],
                  ),
                ),
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(snapshotData.docs[index].data()['image']),
              ),
              title: Text(
                snapshotData.docs[index].data()['name'],
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.clear),
          onPressed: () {
            setState(() {
              isExcecuted = false;
            });
          }),
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          GetBuilder<dataController>(
            init: dataController(),
            builder: (val) {
              return IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    val
                        .querylocalizadoresData(searchController.text)
                        .then((value) {
                      snapshotData = value;
                      setState(() {
                        isExcecuted = true;
                      });
                    });
                  });
            },
          ),
          IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Filtro()));
              }),
        ],
        title: TextField(
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
              hintText: 'Busqueda por nombre',
              hintStyle: TextStyle(color: Colors.black)),
          controller: searchController,
        ),
        backgroundColor: Colors.white,
      ),
      body: isExcecuted
          ? searchedData()
          : Container(
              child: Center(
                child: Text('Selección Localizadores',
                    style: TextStyle(color: Colors.black, fontSize: 30.0)),
              ),
            ),
    );
  }
}
