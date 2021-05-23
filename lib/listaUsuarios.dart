import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

////////////////////////////////////////////////////////////////////////////////////////////////
class PantLista extends StatefulWidget {
  PantLista({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _PantListaState createState() => _PantListaState();
}

class _PantListaState extends State<PantLista> {
  final databaseReference = Firestore.instance;
  Future<String> getDAta() async {
    var aux;

    aux = databaseReference
        .collection('usuarios')
        .where('CZIoqUKnhK9XERlZ8taA')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print(aux =
          '//////////////////////\n1) ${f.data} \n///////////////////////////////////'));
    });

    return aux;
  }

  final dbRef = FirebaseDatabase.instance.reference().child("usuarios");
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: Text('Miembros Registrados')),
      body: new StreamBuilder(
          stream: Firestore.instance.collection('usuarios').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) const Text('Loading...');

            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                padding: const EdgeInsets.all(25.0),
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  // ignore: unrelated_type_equality_checks
                  //if (ds['Nombre'] == "juan") {
                  // print("~~~~~~~ Entro");
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
          }),
    );
  }
}
