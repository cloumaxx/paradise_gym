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
    int elec;
    String descripcion;
    var fechaIni;
    var fechaFin;
    var listado;
    var listadoParticipantes;
    var entraron;
    int totalParticipantes;
    int capacidad;
    final f = new DateFormat('yyyy-MM-dd hh:mm');
    String nombre = name;
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
                  while (i < limite && termino == false) {
                    //print("${ds['Titulo']} = $i ) ${listaUsuarios[i]} == $nombre  validacion= ${listaUsuarios[i] == nombre}  ");
                    if (listaUsuarios[i] == nombre) {
                      listaImp = ds['Titulo'];
                      descImp =
                          "${ds['Descripcion']}\n> Inicia:   $fechaIni\n De: $horaIni:$minIni a $horaFin:$minF\n";
                      print(
                          ">>>>>>>> ${ds['Titulo']} =$i ) ${listaUsuarios[i]}  # Entro");
                      termino = true;
                    } else {
                      listaImp = null;
                      descImp = null;
                    }
                    // print("$i ) ${listaUsuarios[i]}");
                    i++;
                  }

                  ///aqui en adelanto guardo cada dato segun el usuario digite
                  listado = ds['Participantes'];
                  listadoParticipantes = ds['Asistieron'];

                  capacidad = ds['Capacidad'];
                  entraron = ds['Total Ingresaron'];

                  totalParticipantes = ds['Total Ingresaron'];
                  if (capacidad == 10) {}
                  elec = index;
                  nombre = ds['Titulo'];
                  for (int i = 0; i < 10; i++) {
                    print(ds['Titulo']);
                  }
                  descripcion = ds['Descripcion'];
                  var id = ds.documentID;

                  ///los date time y asi son para guardar fechas y actualizarlas

                  if (listaImp != null && descImp != null) {
                    DateTime auxI =
                        (snapshot.data.documents[index].data['Fecha Inicio'])
                            .toDate();
                    DateTime fechaEvent = auxI;
                    DateTime auxF =
                        (snapshot.data.documents[index].data['Fecha Fin'])
                            .toDate();
                    fechaIni = DateFormat('yyyy-MM-dd – kk:mm').format(auxI);
                    fechaFin = DateFormat('yyyy-MM-dd – kk:mm').format(auxF);
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
                          listaImp,
                          descImp,
                          fechaEvent,
                          descripcion,
                          fechaIni,
                          fechaFin,
                          name,
                          id,
                          totalParticipantes,
                          listado,
                          listadoParticipantes,
                          capacidad,
                          entraron,
                        );
                      },
                      onLongPress: () {
                        print("$fechaEvent");
                        infoClase(
                          context,
                          listaImp,
                          descImp,
                          fechaEvent,
                          descripcion,
                          fechaIni,
                          fechaFin,
                          name,
                          id,
                          totalParticipantes,
                          listado,
                          listadoParticipantes,
                          capacidad,
                          entraron,
                        );
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
      String descrip,
      DateTime fechaini,
      DateTime fechafin,
      String nombreUsuario,
      String id,
      int lugar,
      var listado,
      var listado2,
      int capacidad,
      int capacidad2) {
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
                        titulo,
                        descrip,
                        fechaini,
                        fechafin,
                        nombreUsuario,
                        id,
                        lugar,
                        listado,
                        listado2,
                        capacidad,
                        capacidad2);
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
      String titulo,
      String des,
      DateTime fechaini,
      DateTime fechafin,
      String nombreUsuario,
      String id,
      int lugar,
      var listado,
      var listado2,
      int capacidad,
      int capacidad2) async {
    int lugarNuevo = lugar + 1;
    //print("lugarNuevo= $lugarNuevo , capacidad: $capacidad");
    if (lugarNuevo <= capacidad) {
      listado2[lugar] = nombreUsuario;
      await databaseReference.collection('eventos').document(id).setData({
        'Capacidad': capacidad,
        'Titulo': titulo,
        'Descripcion': des,
        'Fecha Inicio': fechaini,
        'Fecha Fin': fechafin,
        'Total participantes': lugarNuevo,
        'Participantes': listado,
        'Asistieron': listado2,
        'Total Ingresaron': capacidad2,
      });
      msjAgregada(context);
    } else {
      msjClaseLlena(context);
    }
  }

  bool validarIngreso(DateTime fechaActivi) {
    bool correcto = false;
    var limite = fechaActivi.add(Duration(minutes: 30));
    var ahora = DateTime.now();
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
