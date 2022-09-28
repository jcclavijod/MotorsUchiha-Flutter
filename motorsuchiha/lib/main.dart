import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:motorsuchiha/Paginas/inicioPag.dart';
import 'package:motorsuchiha/Rutas.dart';
import 'package:motorsuchiha/provider/category_provider.dart';
import 'package:motorsuchiha/provider/product_provider.dart';
import 'package:provider/provider.dart';

import 'Login.dart';

//SHA1: B7:E2:B8:28:40:38:16:B0:14:EE:A8:49:79:BE:DE:38:5F:B5:AB:D3
//SHA256: 0E:DC:BA:A3:19:D4:07:36:95:25:05:0E:67:B5:83:CD:92:3D:46:87:85:A7:53:EB:7C:1C:4B:CA:2C:4E:19:A8
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget rootPage = Login(); //Pagina de inicio
  Future<Widget> estadoDelUsuario() async =>
      await FirebaseAuth.instance.currentUser == null ? Login() : inicioPag();
  // se pregunta si se esta loggeado y dependiendo de eso se muestra la pagina de inicio correspondiente

  @override
  void initState() {
    //de los primeros metodos que se inician
    // TODO: implement initState
    super.initState();
    estadoDelUsuario().then((Widget page) {
      setState(() {
        rootPage = page; //se muestra la pagina obtenida de la pregunta
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: rootPage,
        //Pagina inicio
        routes: buildAppRoutes(), //Rutas
      ),
    );
    // ignore: unused_label
  }
}
