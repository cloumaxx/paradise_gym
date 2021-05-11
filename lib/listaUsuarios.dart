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
  final databaseReference2 =
      FirebaseDatabase.instance.reference().child('usuarios');
  String use;
/*String aux;
    databaseReference
        .collection('usuarios')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print(aux =
          '//////////////////////\n${f.data} \n///////////////////////////////////'));
      // aux = f.data;
    }).toString();
    // return aux;*/

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
/* DocumentReference ref =
        await databaseReference.collection("usuarios").document("nombre");
    print("/////////////////////////////////\n" +
        ref.toString() +
        "\n/////////////////////////////////////////////////");
    //
    */

  final dbRef = FirebaseDatabase.instance.reference().child("usuarios");
  @override
  Widget build(BuildContext context) {
    var auxiliar = getDAta();
    return Scaffold(
        appBar: AppBar(
          title: Text('PARADISE'),
        ),
        body: ListView(
          children: [
            Container(
                //margin: const EdgeInsets.all(0.0),
                //padding: const EdgeInsets.all(0.0),
                margin: EdgeInsets.only(left: 40.0, right: 35.0),
                decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    border: Border.all(
                      color: Colors.black,
                      width: 3,
                    )),
                child: Text(
                  '\n$auxiliar\n',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                )),
          ],
        ));
  }
}
