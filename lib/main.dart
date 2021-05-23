import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'Calendario.dart';
import 'Registro1.dart';
import 'Menu principal.dart';
import 'menuAdmin.dart';
import 'classUsuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'listaUsuarios.dart';
import 'estadoGym.dart';
import 'dart:core';
//import 'package:cloud_functions/cloud_functions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

List<classUsuarios> usersPrint = new List<classUsuarios>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pantalla Ingreso',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PantIngreso(
        title: 'PARADISE',
      ),
    );
  }
}

class PantIngreso extends StatefulWidget {
  PantIngreso({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _PantIngresoState createState() => _PantIngresoState();
}

//final Future<FirebaseApp> _initialization = Firebase

final databaseReference = Firestore.instance;

bool permitirAux(String usua, String clave) {
  bool permitirIngr = false;

  if (usua != "" && clave != "") {
    permitirIngr = true;
  }

  return permitirIngr;
}

bool permitirIngreso(String usua, String clave, List<classUsuarios> aux) {
  bool permitirIngr = true;
  for (int i = 0; i < aux.length; i++) {
    if (usua == aux[i].getcorreo() && clave == aux[i].getcontrasena()) {
      permitirIngr = true;
    }
  }
  return permitirIngr;
}

String claveContrasena(String correo) {
  String clave = " ";
  return clave;
}

//******************************************************************************************************
Future msjErroneo(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: const Text('La clave o el usuario está equivocado'),
        actions: [
          MaterialButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

PantRegistro1 objRegistro = new PantRegistro1();

class _PantIngresoState extends State<PantIngreso> {
  //FirebaseFunctions functions = FirebaseFunctions.instance;Firebase
  //FirebaseAuth auth = FirebaseAuth.instance;
  String msj = " ///////  "; //paraLista().toString();
  String correoAdmin = "paradise_gym@hotmail.com";
  String claveAdmin = "paradise_1234";
  String nombre = " ";
  String usuario = " ";
  String contrasena = "";
  bool entrar = false;
  final myController = TextEditingController();

  void getDAta() {
    String aux;
    databaseReference
        .collection('usuarios')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print(aux =
          '//////////////////////\n${f.data} \n///////////////////////////////////'));
      // aux = f.data;
    }).toString();
    // return aux;
  }

  void createRecord() async {} //////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PARADISE'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 10),
          Container(
            child: Image.asset(
              'assets/logo.png',
              height: 300,
              width: 300,
            ),
          ),
          SizedBox(height: 5),
          Container(
            ////// este container es la "caja" que pide el ingreso de datos
            padding: EdgeInsets.all(5),
            child: TextField(
              onChanged: (texto) {
                usuario = texto;
              },
              decoration: InputDecoration(
                  hintText: 'Escribe tu correo'), //InputDecoration
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: TextField(
              onChanged: (texto) {
                contrasena = texto;
              },
              obscureText: true,
              decoration: InputDecoration(hintText: 'Escribe tu contraseña'),
            ),
          ),
          SizedBox(height: 40),
          /*
          Container(
            margin: EdgeInsets.only(left: 100.0, right: 100.0),
            decoration:
                BoxDecoration(color: Colors.orange[50], border: Border.all()),
            child: MaterialButton(
              minWidth: 20.0,
              height: 50.0,
              disabledColor: Colors.orange,
              child: Text('Ingresar Aux',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              splashColor: Colors.deepOrange,
              color: Colors.yellowAccent,
              elevation: 30.0,
              onPressed: () {
                entrar = permitirAux(usuario, contrasena);
                if (usuario == correoAdmin && contrasena == claveAdmin) {
                  print("correo: $usuario  contrasena: $contrasena");
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        PantMenPrincipalAdmin(correoUse: usuario),
                  ));
                } else {
                  if (entrar == true) {
                    print("correo: $usuario  contrasena: $contrasena");
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          PantMenPrincipal(nombre: nombre, correoUse: usuario),
                    ));
                  } else {
                    msjErroneo(context);
                  }
                }
              },
            ),
          ),
          SizedBox(height: 30),*/
          Container(
            margin: EdgeInsets.only(left: 100.0, right: 100.0),
            decoration:
                BoxDecoration(color: Colors.orange[50], border: Border.all()),
            child: MaterialButton(
              minWidth: 20.0,
              height: 50.0,
              disabledColor: Colors.orange,
              child: Text('Ingresar',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              splashColor: Colors.deepOrange,
              color: Colors.yellowAccent,
              elevation: 30.0,
              onPressed: () {
                getDAta();
                /*
                try {
                  final user = auth.signInWithEmailAndPassword(
                      email: usuario, password: contrasena);
                  if (user != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          PantMenPrincipal(nombre: nombre, correoUse: usuario),
                    ));
                  }
                } catch (e) {
                  msjErroneo(context);
                }*/

                entrar = permitirIngreso(usuario, contrasena, usersPrint);
                if (usuario == correoAdmin && contrasena == claveAdmin) {
                  print("correo: $usuario  contrasena: $contrasena");
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        PantMenPrincipalAdmin(codigo: usuario),
                  ));
                } else {
                  if (entrar == true) {
                    print("correo: $usuario  contrasena: $contrasena");
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          PantMenPrincipal(nombre: nombre, correoUse: usuario),
                    ));
                  } else {
                    msjErroneo(context);
                  }
                }
                ;
              },
            ),
          ),
          SizedBox(height: 30),
          Container(
              margin: EdgeInsets.only(left: 100.0, right: 100.0),
              decoration:
                  BoxDecoration(color: Colors.orange[50], border: Border.all()),
              child: MaterialButton(
                ///opcion para hacer el boton
                minWidth: 20.0,
                height: 50.0,
                disabledColor: Colors.orange,
                child: Text('Registrar',
                    style: TextStyle(fontSize: 20, color: Colors.black)),
                splashColor: Colors.deepOrange,
                color: Colors.yellowAccent,
                elevation: 30.0,

                onPressed: () {
                  print("\n************************\n $msj .   ");

                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return new PantMenPrincipalAdmin(); //PantCalendar(); //// PantRegistro1(); ////  ; // // // //
                  }));
                },
              )),
          SizedBox(height: 30),
        ], //children
      ),
    );
  }

  ///****************************************************************************************************
  String devNombre(String correo) {
    String nombre;
    return nombre;
  }
} //_Pantalla3State
