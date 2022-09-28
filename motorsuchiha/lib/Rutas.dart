import 'package:flutter/material.dart';
import 'package:motorsuchiha/ClaveOlvidada.dart';
import 'package:motorsuchiha/Paginas/AgregarDireccion.dart';
import 'package:motorsuchiha/Paginas/Ajustes.dart';
import 'package:motorsuchiha/Paginas/Carrito.dart';
import 'package:motorsuchiha/Paginas/Final.dart';
import 'package:motorsuchiha/Paginas/FormasPago/InfoTarjeta.dart';
import 'package:motorsuchiha/Paginas/FormasPago/eleccionMetodo.dart';
import 'package:motorsuchiha/Paginas/MiCuenta.dart';
import 'package:motorsuchiha/Paginas/MisDirecciones.dart/Direcciones.dart';
import 'package:motorsuchiha/Paginas/Seguimiento.dart';
import 'package:motorsuchiha/Paginas/eleccionDireccion.dart';
import 'package:motorsuchiha/Paginas/inicioPag.dart';
import 'package:motorsuchiha/Paginas/miGaraje/agregarAuto.dart';
import 'package:motorsuchiha/Paginas/miGaraje/listGaraje.dart';
import 'package:motorsuchiha/Registro.dart';
import 'package:motorsuchiha/paginasAntes/AgregarAuto1.dart';
import 'package:motorsuchiha/paginasAntes/AgregarDireccion1.dart';
import 'Login.dart';
import 'Paginas/FormasPago/PagoEfectivo.dart';

Map<String, WidgetBuilder> buildAppRoutes() {
  return {
    '/Login': (BuildContext context) => Login(),
    '/Registro': (BuildContext context) => Registro(),
    '/InicioPag': (BuildContext context) => inicioPag(),
    '/ClaveOlvidada': (BuildContext context) => ClaveOlvidada(),
    '/AgregarCarro': (BuildContext context) => AgregarAuto(),
    '/ListaGaraje': (BuildContext context) => ListaGaraje(),
    '/Ajustes': (BuildContext context) => Ajustes(),
    '/MiCuenta': (BuildContext context) => MiCuenta(),
    '/AgregarDireccion': (BuildContext context) => AgregarDireccion(),
    '/AgregarDireccion1': (BuildContext context) => AgregarDireccion1(),
    '/AgregarCarro1': (BuildContext context) => AgregarAuto1(),
    '/Direcciones': (BuildContext context) => Direcciones(),
    '/Carrito': (BuildContext context) => Carrito(),
    '/EleccionMetodo': (BuildContext context) => EleccionMetodo(),
    '/InfoTarjeta': (BuildContext context) => InfoTarjeta(),
    '/PagoEfectivo': (BuildContext context) => PagoEfectivo(),
    '/eleccionDireccion': (BuildContext context) => EleccionDireccion(),
    '/Final': (BuildContext context) => Final(),
    '/Seguimiento': (BuildContext context) => Seguimiento(),
  };
}
