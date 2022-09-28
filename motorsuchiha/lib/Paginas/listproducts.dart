import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motorsuchiha/Paginas/details.dart';
import 'package:motorsuchiha/Paginas/inicioPag.dart';
import 'package:motorsuchiha/widgets/myButtonSearch.dart';
import 'package:motorsuchiha/widgets/notification_button.dart';
import 'package:motorsuchiha/widgets/singeproduct.dart';

class ListProducts extends StatelessWidget {
  final String name;
  final snapShot;
  ListProducts({this.name, this.snapShot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => inicioPag()));
          },
        ),
        actions: <Widget>[
          SearchButton(),
          notificationButton(),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 40,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FutureBuilder(
                    // ignore: deprecated_member_use
                    future: Firestore.instance
                        .collection("products")
                        // ignore: deprecated_member_use
                        .document("vRSyQNgh8OnuT0s7zS5y")
                        .collection("featureproduct")
                        // ignore: deprecated_member_use
                        .getDocuments(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapShot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      List<DocumentSnapshot> docs = snapShot.data.docs;
                      return Container(
                        height: 700,
                        child: GridView.builder(
                          itemCount: docs.length,
                          // ignore: non_constant_identifier_names
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => Details(
                                    image: docs[index].data()['image'],
                                    price: docs[index].data()['precio'],
                                    name: docs[index].data()['name'],
                                  ),
                                ),
                              );
                            },
                            child: SingleProduct(
                              image: docs[index].data()['image'],
                              price: docs[index].data()['precio'],
                              name: docs[index].data()['name'],
                            ),
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.7,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                        ),
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
