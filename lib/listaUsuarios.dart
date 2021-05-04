import 'dart:core';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';

////////////////////////////////////////////////////////////////////////////////////////////////

class PantLista extends StatefulWidget {
  PantLista({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _PantListaState createState() => _PantListaState();
}

class _PantListaState extends State<PantLista> {
  final databaseReference = Firestore.instance;

  String getDAta() {
    String aux;
    databaseReference
        .collection('usuarios')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print(aux =
          '//////////////////////\n${f.data} \n///////////////////////////////////'));
      // aux = f.data;
    });
    return aux;
  }

  @override
  Widget build(BuildContext context) {
    String auxiliar = getDAta();
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
