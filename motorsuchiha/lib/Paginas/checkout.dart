import 'package:flutter/material.dart';
import 'package:motorsuchiha/Paginas/inicioPag.dart';
import 'package:motorsuchiha/provider/product_provider.dart';
import 'package:motorsuchiha/widgets/carritoSingle.dart';
import 'package:motorsuchiha/widgets/notification_button.dart';
import 'package:provider/provider.dart';

class checkout extends StatefulWidget {
  @override
  _checkoutState createState() => _checkoutState();
}

class _checkoutState extends State<checkout> {
  final TextStyle myStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  ProductProvider productProvider;

  Widget _buildPrecio({String startName, String endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          startName,
          style: myStyle,
        ),
        Text(endName, style: myStyle)
      ],
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
            ]),
        bottomNavigationBar: Container(
          height: 70,
          width: 100,
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.only(bottom: 15),
          child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              color: Colors.blue,
              child: Text(
                "Comprar",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {}),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: ListView.builder(
                itemCount: productProvider.getCarritoModelListLength,
                itemBuilder: (ctx, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              CarritoSingle(
                                index: index,
                                image: productProvider
                                    .getCarritoModelList[index].image,
                                name: productProvider
                                    .getCarritoModelList[index].name,
                                price: productProvider
                                    .getCarritoModelList[index].precio,
                                cantidad: productProvider
                                    .getCarritoModelList[index].cantidad,
                              ),
                              _buildPrecio(
                                  startName: "Precio", endName: "\$500000"),
                              _buildPrecio(
                                  startName: "Descuento", endName: "\$5000"),
                              _buildPrecio(
                                  startName: "Total", endName: "\$450000"),
                            ],
                          ))
                    ],
                  );
                })));
  }
}
