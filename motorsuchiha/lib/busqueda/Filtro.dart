import 'package:flutter/material.dart';
import 'package:motorsuchiha/Paginas/inicioPag.dart';
import 'package:motorsuchiha/busqueda/searchAlarmas.dart';
import 'package:motorsuchiha/busqueda/searchDestacados.dart';
import 'package:motorsuchiha/busqueda/searchFarolas.dart';
import 'package:motorsuchiha/busqueda/searchLlantas.dart';
import 'package:motorsuchiha/busqueda/searchLocalizadores.dart';
import 'package:motorsuchiha/busqueda/searchNuevos.dart';
import 'package:motorsuchiha/busqueda/searchVolantes.dart';

class Filtro extends StatefulWidget {
  @override
  _FiltroState createState() => _FiltroState();
}

Widget _buildFiltroProduct({String image, int color}) {
  return CircleAvatar(
    maxRadius: 37,
    backgroundColor: Color(color),
    child: Container(
        height: 40,
        child: Image(
            color: Colors.white, image: AssetImage("assets/images/$image"))),
  );
}

class _FiltroState extends State<Filtro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text("Filtros"),
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
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            ///// Alarmas
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new SearchAlarmas()));
              },
              child: ListTile(
                title: Text('Alarmas para auto'),
                leading:
                    _buildFiltroProduct(image: "sensor.png", color: 0xff4ff2af),
              ),
            ),
            Divider(),
            ///// Farolas
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new SearchFarolas()));
              },
              child: ListTile(
                title: Text('Farolas para auto'),
                leading:
                    _buildFiltroProduct(image: "puerta.png", color: 0xff38dcdd),
              ),
            ),
            Divider(),
            ////Llantas
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new SearchFarolas()));
              },
              child: ListTile(
                title: Text('Llantas para auto'),
                leading:
                    _buildFiltroProduct(image: "llanta.png", color: 0xff74acf7),
              ),
            ),
            Divider(),
            ///// Localizadores
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new SearchLocalizador()));
              },
              child: ListTile(
                title: Text('Localizadores para auto'),
                leading:
                    _buildFiltroProduct(image: "ubi.png", color: 0xfffc6c8d),
              ),
            ),
            Divider(),
            ///// Volantes
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new SearchVolantes()));
              },
              child: ListTile(
                title: Text('Volantes para auto'),
                leading: _buildFiltroProduct(
                    image: "volante.png", color: 0xff33dcfd),
              ),
            ),
            Divider(),
            ///// Nuevos
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new SearchNuevos()));
              },
              child: ListTile(
                title: Text('Nuevos Productos'),
                leading:
                    _buildFiltroProduct(image: "caja.png", color: 0xFFFDC733),
              ),
            ),
            Divider(),
            ///// Destacados
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new SearchDestacados()));
              },
              child: ListTile(
                title: Text('Productos Destacados'),
                leading: _buildFiltroProduct(
                    image: "destacados.png", color: 0xFFFD3333),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
