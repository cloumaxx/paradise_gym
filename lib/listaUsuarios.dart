import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

////////////////////////////////////////////////////////////////////////////////////////////////
class PantLista extends StatefulWidget {
  PantLista({Key key, this.title, this.nombreUsar}) : super(key: key);
  final String nombreUsar;
  final String title;
  @override
  _PantListaState createState() => _PantListaState(name: nombreUsar);
}

class _PantListaState extends State<PantLista> {
  String name;
  _PantListaState({this.name});
  final databaseReference = Firestore.instance;
  Future<String> getDAta() async {
    var aux;

    aux = databaseReference
        .collection('usuarios')
        .where('dtN6lwu4zguSMVWUjw66')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print(aux =
          '//////////////////////\n1) ${f.data} \n///////////////////////////////////'));
    });

    return aux;
  }

  @override
  Widget build(BuildContext context) {
    bool auxiliar;
    final f = new DateFormat('yyyy-MM-dd hh:mm');
    String nombre = "carlos eduardo";
    return new Scaffold(
      appBar: new AppBar(title: Text('$name')), //Miembros Registrados')),
      body: new StreamBuilder(
          stream: Firestore.instance.collection('eventos').snapshots(),
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
                  DateTime auxI =
                      (snapshot.data.documents[index].data['Fecha Inicio'])
                          .toDate();
                  DateTime auxF =
                      (snapshot.data.documents[index].data['Fecha Fin'])
                          .toDate();
                  var fechaIni = DateFormat('yyyy-MM-dd').format(auxI);
                  var horaIni = auxI.hour;
                  var minIni = auxI.minute;
                  var horaFin = auxF.hour;
                  var minF = auxF.minute;
                  print(">>> $auxI");
                  var listaUsuarios = ds['Participantes'];
                  int limite = listaUsuarios.length;
                  for (int i = 0; i < limite; i++) {
                    print("$i ) ${listaUsuarios[i]}");
                  }
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[50], border: Border.all()),
                    child: Text(
                      '\n> Titulo: ${ds['Titulo']} \n> Descripción: '
                      '${ds['Descripcion']} \n> Inicia: \n $fechaIni\n  $horaIni:$minIni - $horaFin:$minF\n ',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                });
          }),
    );
  }
}
