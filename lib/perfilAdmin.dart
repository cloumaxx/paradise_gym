import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym/Registro1.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:gym/main.dart';
import 'Calendario.dart';

////////////////////////////////////////////////////////////////////////////////////////////////

class PantPerfilAdmin extends StatefulWidget {
  PantPerfilAdmin({Key key, this.title, this.codigo}) : super(key: key);
  final String title;
  final String codigo;
  @override
  _PantPerfilAdminState createState() => _PantPerfilAdminState(codes: codigo);
}

String auxiliar = "";

class _PantPerfilAdminState extends State<PantPerfilAdmin> {
  _PantPerfilAdminState({this.codes});
  final String codes;

  // ignore: missing_return

  @override
  Widget build(BuildContext context) {
    //String auxiliar =
    int limite;

    return Scaffold(
      appBar: AppBar(
        title: Text('PARADISE'),
      ),
      body: ListView(
        children: [
          Container(
            child: Image.asset('assets/sinFotoPerfil.jpg', width: 200),
          ),
          new StreamBuilder(
              stream: Firestore.instance
                  .collection('usuarios')
                  .document(codes)
                  .snapshots(),
              builder: (context, snapshot) {
                var user = snapshot.data;
                if (!snapshot.hasData) {
                  return new Text("Loading");
                }

                return new Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.blue[50], border: Border.all()),
                  child: Text(
                    'Nombre: ${user["Nombre"]} ${user["Apellido"]}\nCorreo: ${user["Correo"]}\n'
                    'Genero: ${user["Genero"]}\nIdentificacion: ${user['identificacion']}  ${user['numIdent']} ',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }),
          //var userDocument = snapshot.data;
          SizedBox(height: 30),
          SizedBox(height: 20),
        ], //children
      ),
    );
  }
}
/*
* StreamBuilder(
          stream: Firestore.instance.collection('usuarios').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) const Text('Loading...');

            //auxiliar = confirmarIngr("alvearmutis@hotmail.com");
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                padding: const EdgeInsets.all(25.0),
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  // ignore: unrelated_type_equality_checks
                  //if (ds['Nombre'] == "juan") {
                  // print("~~~~~~~ Entro");
                  print("---->Entro?     $auxiliar");
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[50], border: Border.all()),
                    child: Text(
                      '\n Nombre: ${ds['Nombre']} ${ds['Apellido']},\n Correo: '
                      '${ds['Correo']} ,\n Genero: ${ds['Genero']},\n Indentificación: ${ds['identificacion']} : ${ds['numIdent']} \n ',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                });
          }),*/ //_Pantalla3State
