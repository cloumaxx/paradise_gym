import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

////////////////////////////////////////////////////////////////////////////////////////////////
class PantLista extends StatefulWidget {
  PantLista({Key key, this.title, this.nombreUsar, this.codigo})
      : super(key: key);
  final String nombreUsar;
  final String codigo;
  final String title;
  @override
  _PantListaState createState() =>
      _PantListaState(name: nombreUsar, codeUsuario: codigo);
}

class _PantListaState extends State<PantLista> {
  String name;
  String codeUsuario = "";
  _PantListaState({this.name, this.codeUsuario});
  final databaseReference = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    bool auxiliar;
    String listaImp;
    String descImp;

    final f = new DateFormat('yyyy-MM-dd hh:mm');
    String nombre = name;
    return new Scaffold(
      appBar: new AppBar(title: Text('PARADISE')), //Miembros Registrados')),
      body: new StreamBuilder(
          stream: Firestore.instance.collection('eventos').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) const Text('Loading...');
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                padding: const EdgeInsets.all(25.0),
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];

                  DateTime auxI =
                      (snapshot.data.documents[index].data['Fecha Inicio'])
                          .toDate();
                  DateTime auxF =
                      (snapshot.data.documents[index].data['Fecha Fin'])
                          .toDate();
                  var horaIni = auxI.hour;
                  var minIni = auxI.minute;
                  var horaFin = auxF.hour;
                  var minF = auxF.minute;

                  print(">> $nombre");
                  var listaUsuarios = ds['Participantes'];
                  int limite = listaUsuarios.length;
                  int i = 0;
                  bool termino = false;
                  listaImp = null;
                  var fechaIni = DateFormat('yyyy-MM-dd').format(auxI);
                  while (i < limite && termino == false) {
                    //print("${ds['Titulo']} = $i ) ${listaUsuarios[i]} == $nombre  validacion= ${listaUsuarios[i] == nombre}  ");
                    if (listaUsuarios[i] == nombre) {
                      listaImp = ds['Titulo'];
                      descImp =
                          "${ds['Descripcion']}\n> Inicia:   $fechaIni\n De: $horaIni:$minIni a $horaFin:$minF\n";
                      print(
                          ">>>$limite>>>>> ${ds['Titulo']} = $i ) ${listaUsuarios[i]}          # Entro");
                      termino = true;
                    } else {
                      listaImp = null;
                      descImp = null;
                    }
                    // print("$i ) ${listaUsuarios[i]}");
                    i++;
                  }

                  ///aqui en adelanto guardo cada dato segun el usuario digite
                  var listadoPart = ds['Participantes'];
                  var listadoAsist = ds['Asistieron'];
                  String titulo = ds['Titulo'];
                  int capacidad = ds['Capacidad'];
                  var totalIng = ds['Total Ingresaron'];
                  var totalPart = ds['Total participantes'];
                  String descripcion = ds['Descripcion'];
                  var id = ds.documentID;
                  if (listaImp != null && descImp != null) {
                    DateTime auxI =
                        (snapshot.data.documents[index].data['Fecha Inicio'])
                            .toDate();
                    DateTime fechaEvent = auxI;
                    DateTime auxF =
                        (snapshot.data.documents[index].data['Fecha Fin'])
                            .toDate();

                    return ListTile(
                      title: Text(
                        '$listaImp ',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        '$descImp ',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      onTap: () {
                        print("$fechaEvent");
                        infoClase(
                            context,
                            titulo,
                            descImp,
                            auxI,
                            id,
                            descripcion,
                            auxI,
                            auxF,
                            name,
                            totalIng,
                            listadoAsist,
                            listadoPart,
                            totalPart,
                            capacidad);
                      },
                      onLongPress: () {
                        print("$fechaEvent");
                        infoClase(
                            context,
                            titulo,
                            descImp,
                            auxI,
                            id,
                            descripcion,
                            auxI,
                            auxF,
                            name,
                            totalIng,
                            listadoAsist,
                            listadoPart,
                            totalPart,
                            capacidad);
                      },
                    );
                  }
                  return ListTile(
                    title: Text(''),
                  );
                });
          }),
    );
  }

  Future infoClase(
      BuildContext context,
      String titulo,
      String des,
      DateTime fechaAux,
      String id, //
      String descripcion, //
      DateTime fechaini, //
      DateTime fechafin, //
      String nombreUsuario, //
      int totalIngresa,
      var listaAsistieron, //
      var listaParticipantes, //
      int totalParticipantes,
      int capacidad) {
    bool permitir;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Descripcion de la clase'),
          content: Text(
            'Titulo: $titulo \nDescripción:\n$des',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          actions: [
            MaterialButton(
                child: Text(
                  'Si asisti',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  permitir = validarIngreso(fechaAux);
                  if (permitir == true) {
                    agendarse(
                        id,
                        titulo, //
                        des, //
                        fechaini, //
                        fechafin, //
                        nombreUsuario, //
                        totalIngresa,
                        listaAsistieron, //
                        listaParticipantes, //
                        totalParticipantes,
                        capacidad);
                  }
                }),
            MaterialButton(
              child: Text(
                'Regresar',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Future agendarse(
      String id,
      String titulo, //
      String des, //
      DateTime fechaini, //
      DateTime fechafin, //
      String nombreUsuario, //
      int totalIngresa,
      var listaAsistieron, //
      var listaParticipantes, //
      int totalParticipantes,
      int capacidad) async {
    int lugarNuevo = totalIngresa + 1;
    for (int i = 0; i < capacidad; i++) {
      print("->${listaAsistieron[i]}");
    }
    print(
        "lugarNuevo= $lugarNuevo , capacidad: $capacidad, total Ing = $totalParticipantes, nombre= $nombreUsuario");

    if (lugarNuevo <= capacidad) {
      listaAsistieron[totalIngresa] = nombreUsuario;
      print(">>>> ${listaAsistieron[totalIngresa]} : $nombreUsuario  ");

      String lugarUsar = lugarNuevo.toString();
      await databaseReference.collection('eventos').document(id).setData({
        'Capacidad': capacidad,
        'Titulo': titulo,
        'Descripcion': des,
        'Fecha Inicio': fechaini,
        'Fecha Fin': fechafin,
        'Total participantes': totalParticipantes,
        'Participantes': listaParticipantes,
        'Asistieron': listaAsistieron,
        'Total Ingresaron': lugarNuevo,
      });
      msjAgregada(context);
    } else {
      msjClaseLlena(context);
    }
  }

  bool validarIngreso(DateTime fechaActivi) {
    bool correcto = false;
    var limite = fechaActivi.add(Duration(minutes: 30));
    var ahora = fechaActivi.add(Duration(minutes: 10)); //DateTime.now();
    if (ahora.isBefore(limite)) {
      if (ahora.isAfter(fechaActivi)) {
        correcto = true;
      }
    }
    print(
        "actividad   : $fechaActivi \nlimite: $limite\n correcto= $correcto\n ");
    return correcto;
  }

  Future msjClaseLlena(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: const Text('La clase esta llena'),
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

  Future msjAgregada(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exito'),
          content: const Text('Fuiste agregad@ exitosamente en la clase'),
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
}
