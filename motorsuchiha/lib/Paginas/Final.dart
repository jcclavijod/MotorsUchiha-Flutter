import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Final extends StatefulWidget {
  @override
  _FinalState createState() => _FinalState();
}

class _FinalState extends State<Final> {
  final TextStyle myStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  final _scrollController = ScrollController();
  var _firstScroll = true;
  bool _enabled = false;
  User _user;
  CollectionReference _agregar;

  Widget _borrarTodo() {
        _user = FirebaseAuth.instance.currentUser;
    _agregar = FirebaseFirestore.instance
        .collection('Usuarios')
        .doc(_user.uid)
        .collection('MiCarrito');
    return StreamBuilder(
                stream: _agregar.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<DocumentSnapshot> docs = snapshot.data.docs;
                  
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> data = docs[index].data();
                      _agregar.doc(docs[index].id).delete();
                    }
                  );
                }
    );
  }


  Widget _buildProduct() {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (_enabled && _firstScroll) {
            _scrollController
                .jumpTo(_scrollController.position.pixels - details.delta.dy);
          }
        },
        onVerticalDragEnd: (_) {
          if (_enabled) _firstScroll = false;
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                child: new Image(
                  width: 475.0,
                  height: 375.0,
                  image: AssetImage('assets/images/Gcompra.jpg'),
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
              Container(
                width: 200,
                height: 80,
                child: CupertinoButton(
                    //Boton del login
                    minSize: 10.0,
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(7000.0),
                    child: Text('INICIO'),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/InicioPag');
                    }),
              ),
              Divider(
                color: Colors.transparent,
              ),
              Divider(
                color: Colors.transparent,
              ),_borrarTodo(),
              Container(
                width: 200,
                height: 80,
                child: CupertinoButton(
                    //Boton del login
                    minSize: 0.0,
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.circular(7000.0),
                    child: Text('PEDIDO'),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed('/Seguimiento');
                    }),
              ),
            ],
          ),
        ),
      ),
    );
    //Estas lineas sirven para no sobrepasar el ancho de de la pantala y del widget (AVERIGUAR MAS)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Métodos de pago',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _buildProduct(),
    );
  }
}
