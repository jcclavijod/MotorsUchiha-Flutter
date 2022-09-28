import 'package:flutter/material.dart';
import 'package:motorsuchiha/Paginas/Fav.dart';
import 'package:motorsuchiha/Paginas/inicioPag.dart';
import 'package:motorsuchiha/widgets/carritoSingle.dart';
import 'package:motorsuchiha/widgets/notification_button.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';

class Favorito extends StatefulWidget {
  @override
  _FavoritoState createState() => _FavoritoState();
}

ProductProvider productProvider;

class _FavoritoState extends State<Favorito> {
  final TextStyle myStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
        bottomNavigationBar: Container(
          height: 45,
          width: 100,
          child: RaisedButton(
              color: Colors.white,
              child: Text(
                "Continuar comprando",
                style: myStyle,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => inicioPag()),
                );
              }),
        ),
        appBar: AppBar(
          title: Center(
            child: Text(
              "Favoritos",
              style: TextStyle(color: Colors.black),
            ),
          ),
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
        body: ListView.builder(
          itemCount: productProvider.getfavoritoModelListLength,
          itemBuilder: (ctx, index) => Fav(
            image: productProvider.getfavoritoModelList[index].image,
            name: productProvider.getfavoritoModelList[index].name,
            price: productProvider.getfavoritoModelList[index].precio,
            cantidad: productProvider.getfavoritoModelList[index].cantidad,
          ),
        ));
  }
}
