import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gym/perfilAdmin.dart';
import 'main.dart';
import 'Calendario.dart';
import 'package:gym/PerfilUsuario.dart';
import 'CalendarioAdmin.dart';
import 'estadoGym.dart';
import 'listadoClases.dart';
////////////////////////////////////////////////////////////////////////////////////////////////

class PantMenPrincipalAdmin extends StatefulWidget {
  PantMenPrincipalAdmin({Key key, this.title, this.codigo});
  final String codigo;

  final String title;
  @override
  _PantMenPrincipalAdminState createState() =>
      _PantMenPrincipalAdminState(code: codigo);
}

///****************************************************************************************************************************
class _PantMenPrincipalAdminState extends State<PantMenPrincipalAdmin> {
  final String code;
  _PantMenPrincipalAdminState({this.code});

  @override
  Widget build(BuildContext context) {
    String nombre2 = "Administrador";
    String bienvenida = "Bienvenido ";
    String mensajeAgua = "\n¿Qué deseas hacer? ";
    String msjNombre = bienvenida + nombre2 + mensajeAgua;
    return Scaffold(
      appBar: AppBar(
        title: Text('PARADISE'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 50),
          Text(
            msjNombre,
            style: TextStyle(
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          Container(
            margin: EdgeInsets.only(left: 50.0, right: 50.0),
            decoration:
                BoxDecoration(color: Colors.orange[50], border: Border.all()),
            child: RaisedButton.icon(
              padding: new EdgeInsets.all(15),
              icon: Icon(Icons.calendar_today_outlined),
              label: Text('Agendar clases',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              splashColor: Colors.lightBlue,
              color: Colors.red,
              elevation: 30.0,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute<Null>(builder: (BuildContext context) {
                  return new PantEstadoGym();
                }));
              },
            ),
          ),
          SizedBox(height: 40),
          Container(
            margin: EdgeInsets.only(left: 50.0, right: 50.0),
            decoration:
                BoxDecoration(color: Colors.orange[50], border: Border.all()),
            child: RaisedButton.icon(
              padding: new EdgeInsets.all(15),
              icon: Icon(Icons.list_alt),
              label: Text('Revisar clases',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              splashColor: Colors.lightBlue,
              color: Colors.redAccent,
              elevation: 30.0,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return new PantListClases();
                }));
              },
            ),
          ),
          SizedBox(height: 40),
          Container(
            margin: EdgeInsets.only(left: 50.0, right: 50.0),
            decoration:
                BoxDecoration(color: Colors.orange[50], border: Border.all()),
            child: RaisedButton.icon(
              padding: new EdgeInsets.all(15),
              icon: Icon(Icons.person),
              label: Text('Ver tu perfil',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              splashColor: Colors.lightBlue,
              color: Colors.deepOrange,
              elevation: 30.0,
              onPressed: () {
                print('************\n\n $code\n\n ************************');

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PantPerfilAdmin(
                    codigo: code,
                  ),
                ));
              },
            ),
          ),
          SizedBox(height: 40),
          Container(
            margin: EdgeInsets.only(left: 50.0, right: 50.0),
            decoration:
                BoxDecoration(color: Colors.orange[50], border: Border.all()),
            child: RaisedButton.icon(
              padding: new EdgeInsets.all(15),
              icon: Icon(Icons.exit_to_app),
              label: Text('Cerrar Sesión',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              splashColor: Colors.lightBlue,
              color: Colors.yellow,
              elevation: 30.0,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute<Null>(builder: (BuildContext context) {
                  return new PantIngreso();
                }));
              },
            ),
          ),
          SizedBox(height: 40),
        ], //children
      ),
    );
  }
} //_Pantalla3State
