import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'dart:core';

///////////a /////////////////////////////////////////////////////////////////////////////////////
class PantListClases extends StatefulWidget {
  PantListClases({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _PantListClasesState createState() => _PantListClasesState();
}

class _PantListClasesState extends State<PantListClases> {
  String nombreUsuario = "carlos";
  String id;
  int totalParticipantes;
  int capacidad;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PARADISE'),
      ),
      ///// mando todo a un Stream builder porque no se como mas ponerlo
      body: new StreamBuilder(
          stream: Firestore.instance.collection('eventos').snapshots(),

          ///este Stream y el builder funcionar para declarar los sanpahost y darle como
          builder: (context, snapshot) {
            /// permiso de usar la base de datos
            if (!snapshot.hasData) const Text('Loading...');

            ///esta parte es para cuando algo no funciona bien

            return ListView.builder(

                /// ListView: mando todo en una lista de objetos para mostrarlos
                /// itemCount espara contar todos los elementos de una coleccion
                itemCount: snapshot.data.documents.length,
                padding: const EdgeInsets.all(25.0),
                itemBuilder: (context, index) {
                  /// ds es el encargado de direccionar los datos
                  DocumentSnapshot ds = snapshot.data.documents[index];

                  ///variables para guardar datos
                  int elec;
                  String nombre;
                  String descripcion;
                  var fechaIni;
                  var fechaFin;
                  var listado;

                  /// ListTile: una lista de acceso
                  return ListTile(
                    title: Text(
                      ///para buscar un dato de la coleccion se declara asi
                      ///ds['nombre de la variable']
                      ///los parentesis son para que lea todo como una sola variable
                      '${ds['Titulo']} ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      '${ds['Descripcion']}\n ',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),

                    ///on top y el on... son cuando el usuario oprime o mantiene oprimido alguna opcion de la lsita
                    onTap: () {
                      ///aqui en adelanto guardo cada dato segun el usuario digite
                      listado = ds['Participantes'];
                      capacidad = ds['Capacidad'];

                      ///id guarda el id de cada documento en la coleccion,ayuda para direccionar
                      id = ds.documentID;
                      totalParticipantes = ds['Total participantes'];
                      if (capacidad == 10) {}
                      elec = index;
                      nombre = ds['Titulo'];

                      descripcion = ds['Descripcion'];

                      ///los date time y asi son para guardar fechas y actualizarlas
                      DateTime auxI =
                          (snapshot.data.documents[index].data['Fecha Inicio'])
                              .toDate();
                      DateTime auxF =
                          (snapshot.data.documents[index].data['Fecha Fin'])
                              .toDate();
                      fechaIni = DateFormat('yyyy-MM-dd – kk:mm').format(auxI);

                      String fechaFin =
                          DateFormat('yyyy-MM-dd – kk:mm').format(auxF);

                      ///info clases manda una ventana emergente que permite ver la informacion del usuario
                      infoClase(
                          context,
                          nombre,
                          descripcion,
                          fechaIni,
                          fechaFin,
                          totalParticipantes,
                          nombreUsuario,
                          id,
                          listado,
                          capacidad,
                          auxI,
                          auxF,
                          capacidad);
                      print("-> $elec");
                    },

                    ///si el usuario oprime alguna opcion de la lista mostrara una ventana emergente
                    onLongPress: () {
                      capacidad = ds['Capacidad'];
                      id = ds.documentID;
                      listado = ds['Participantes'];
                      totalParticipantes = ds['Total participantes'];
                      elec = index;
                      nombre = ds['Titulo'];
                      descripcion = ds['Descripcion'];
                      DateTime auxI =
                          (snapshot.data.documents[index].data['Fecha Inicio'])
                              .toDate();
                      DateTime auxF =
                          (snapshot.data.documents[index].data['Fecha Fin'])
                              .toDate();
                      fechaIni = DateFormat('yyyy-MM-dd – kk:mm').format(auxI);
                      fechaFin = DateFormat('yyyy-MM-dd – kk:mm').format(auxF);

                      infoClase(
                          context,
                          nombre,
                          descripcion,
                          fechaIni,
                          fechaFin,
                          totalParticipantes,
                          nombre,
                          id,
                          listado,
                          capacidad,
                          auxI,
                          auxF,
                          capacidad);

                      ///fijate que uso el elec como si fuera indicador o pues la posicion que eligio el usuario
                      print("------> $elec");
                    },
                  );
                });
          }),
    );
  }

  Future mostrarListado(var lista, int limite) {
    String listadoImpr = "";
    var aux = lista;
    int contador = 0;
    String claseLlena = "";
    for (int i = 0; i < limite; i++) {
      if (aux[i] != null) {
        listadoImpr += ">> ${i + 1}: " + aux[i] + "\n";
        contador++;
        //print("$i : ${aux[i]}");
      }
    }
    if (contador == capacidad - 1) {
      claseLlena = "Clase llena";
    } else {
      claseLlena = "Clase con cupos";
    }
    print("-> $lista");
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'LISTADO\n Estado: $claseLlena',
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Capacidad Maxima: $capacidad \nUsuarios Registrados: $contador \n$listadoImpr \n',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          actions: [
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

  Future infoClase(
      BuildContext context,
      String titulo,
      String des,
      var ini,
      var fin,
      int lugar,
      String nombreUsuario,
      String id,
      var listado,
      int capacidad,
      DateTime fechaIG,
      DateTime fechaFG,
      int cantidadRegistrados) {
    var aux = listado;
    int contador = 0;
    for (int i = 0; i < capacidad; i++) {
      if (aux[i] != null) {
        contador++;
      }
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Descripcion de la clase'),
          content: Text(
            '-> Titulo: $titulo \n->Descripcion:\n $des \n->Inicio: \n$ini \n->Fin: \n$fin\n->Capacidad Maxima: $capacidad\n->Usuarios Registrados: $contador',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          actions: [
            MaterialButton(
                child: Text(
                  'Ver participantes',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  mostrarListado(listado, capacidad);
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
}
