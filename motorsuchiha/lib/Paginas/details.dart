import 'package:flutter/material.dart';
import 'package:motorsuchiha/Paginas/Carrito.dart';
import 'package:motorsuchiha/Paginas/favorito.dart';
import 'package:motorsuchiha/Paginas/inicioPag.dart';
import 'package:motorsuchiha/widgets/myButton.dart';
import 'package:motorsuchiha/widgets/notification_button.dart';
import 'package:motorsuchiha/Paginas/Fav.dart';
import '../provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Details extends StatefulWidget {
  final String name;
  final String image;
  final double price;
  Details({this.name, this.image, this.price});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int count = 1;

  ProductProvider productProvider;

  final TextStyle myStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  final TextStyle MyStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
  User _user;

  Widget _buildImage() {
    return Center(
      child: Container(
        width: 380,
        child: Card(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: NetworkImage(widget.image))),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNombreParaDescripcion() {
    return Container(
      height: 100,
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.name,
                style: myStyle,
              ),
              Text("\$ ${widget.price.toString()}", style: myStyle),
              Text("Descripcion:", style: myStyle)
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescripcion() {
    return Container(
      height: 140,
      child: Wrap(
        children: <Widget>[
          Text(
            "ESTE RADIO TRAE CONVERTIDOR TIPO ANDROID PRESTA ATENCIÓN CONECTAS TU CELULAR Y TODO LO QUE VEAS EN TU CELULAR LO PUEDES VER EN EL RADIO Y POR MEDIO DEL CABLE USB ESCUCHAR APLICACION UBER NETFLIX FACEBOOK WHATSSAP . YOUTUBE ENTRE OTRAS PODRAS DISFRUTAR SIN NINGUN PROBLEMA SIEMPRE Y CUANDO ESTEN INSTALADAS EN TU TELEFONO",
            style: TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }

  Widget _buildCantidad() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 15,
        ),
        Text("Seleccione cantidad", style: myStyle),
        SizedBox(
          height: 15,
        ),
        Container(
          height: 40,
          width: 130,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  child: Icon(Icons.remove),
                  onTap: () {
                    setState(() {
                      if (count > 1) {
                        count--;
                      }
                    });
                  },
                ),
                Text(count.toString(), style: myStyle),
                GestureDetector(
                  child: Icon(Icons.add),
                  onTap: () {
                    setState(() {
                      count++;
                    });
                  },
                ),
              ]),
        ),
      ],
    );
  }

  Widget _buildComprar() {
    return Container(
      height: 45,
      child: MyButton(
          name: "Añadir a carrito",
          onPressed: () {
          _user = FirebaseAuth.instance.currentUser;
          FirebaseFirestore.instance
          .collection('Usuarios')
          .doc(_user.uid)
          .collection('MiCarrito')
          .doc()
          .set({
            'Nombreproducto': widget.name,
            'Cantidad': count,
            'Precio': widget.price,
            'Imagen': widget.image,
          })
          .then((value) => print("Carro añadido"))
          .catchError((error) => print("Fallo al añadir el carro: $error"));
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => Carrito(),
              ),
            );
          }),
    );
  }

  Widget _buildFav() {
    return Container(
      padding: EdgeInsets.all(6.0),
      height: 45,
      width: double.infinity,
      child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.blue,
          child: Text(
            "Añadir a favoritos",
            style: MyStyle,
          ),
          onPressed: () {
            productProvider.getFavData(
                image: widget.image,
                name: widget.name,
                precio: widget.price,
                cantidad: count);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => Favorito(),
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => inicioPag()),
            );
          },
        ),
        actions: <Widget>[
          notificationButton(),
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildImage(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      _buildNombreParaDescripcion(),
                      _buildDescripcion(),
                      SizedBox(
                        height: 15,
                      ),
                      _buildCantidad(),
                      _buildComprar(),
                      _buildFav(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
