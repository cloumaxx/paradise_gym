import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:gym/perfilAdmin.dart';
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
final databaseReference2 = FirebaseDatabase.instance.reference();

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

int i = 0;
PantRegistro1 objRegistro = new PantRegistro1();

bool verificar(String usuario) {
  bool entro = false;

  return entro;
}

class _PantIngresoState extends State<PantIngreso> {
  //FirebaseFunctions functions = FirebaseFunctions.instance;Firebase
  //FirebaseAuth auth = FirebaseAuth.instance;
  String msj = " ///////  "; //paraLista().toString();
  String correoAdmin = "paradise_gym@hotmail.com";
  String claveAdmin = "paradise_1234";
  String nombre = " ";
  String name = "";
  String usuario = " ";
  String contrasena = "";
  bool entrar = false;
  final myController = TextEditingController();
  int limite;
  int cont = 0;

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
                databaseReference
                    .collection('usuarios')
                    .getDocuments()
                    .then((QuerySnapshot snapshot) {
                  limite = snapshot.documents.length;
                  for (int i = 0; i < limite; i++) {
                    DocumentSnapshot ds = snapshot.documents[i];
                    if (ds["Correo"] == usuario &&
                        ds["Contrasena"] == contrasena) {
                      name = ds["Nombre"] + ds["Apellido"];
                      print("$i >> ${ds.documentID}");
                      if (ds["Correo"] == correoAdmin &&
                          ds["Contrasena"] == claveAdmin) {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return new PantMenPrincipalAdmin(
                              codigo: ds
                                  .documentID); //PantLista(); //PantMenPrincipalAdmin(); //PantCalendar(); //// PantRegistro1(); ////  ; // // // //
                        }));
                      } else {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return new PantMenPrincipal(
                            codigo: ds.documentID,
                            nameUsua: name,
                          ); //PantLista(); //PantMenPrincipalAdmin(); //PantCalendar(); //// PantRegistro1(); ////  ; // // // //
                        }));
                      }
                    } else {
                      //msjErroneo(context);
                    }
                  }
                });
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
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return new PantLista(); //PantRegistro1(); //PantPerfilAdmin(
                    // codigo:
                    //   ""); // //PantLista(); //PantMenPrincipalAdmin(); //PantCalendar(); //// PantRegistro1(); ////  ; // // // //
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
