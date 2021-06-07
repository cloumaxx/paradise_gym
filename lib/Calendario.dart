import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'dart:core';

////////////////////////////////////////////////////////////////////////////////////////////////

class PantCalendar extends StatefulWidget {
  PantCalendar({Key key, this.title, this.nombre, this.codigo})
      : super(key: key);
  final String nombre;
  final String codigo;
  final String title;
  @override
  _PantCalendarState createState() =>
      _PantCalendarState(nombreUsuario: nombre, codeUsuario: codigo);
}

class _PantCalendarState extends State<PantCalendar> {
  String nombreUsuario = "";
  String codeUsuario = "";
  _PantCalendarState({this.nombreUsuario, this.codeUsuario});
  String id;
  int totalParticipantes;
  int capacidad;
  @override
  Widget build(BuildContext context) {
    int aforoMax = 100;
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
                      for (int i = 0; i < 10; i++) {
                        print(ds['Titulo']);
                      }
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
                          codeUsuario,
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
                          auxF);
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
                          codeUsuario,
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
                          auxF);

                      ///fijate que uso el elec como si fuera indicador o pues la posicion que eligio el usuario
                      print("------> $elec");
                    },
                  );
                });
          }),
    );
  }

  ///esta ventana emergente muestra la informacion mas detallada de cada evento y pregunta si se agrega o no(siempre y cuando aun haya espacio)
  Future infoClase(
      BuildContext context,
      String idUsua,
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
      DateTime fechaFG) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Descripcion de la clase'),
          content: Text(
            '-> Titulo: $titulo \n->Descripcion:\n $des \n->Inicio: \n$ini \n->Fin: \n$fin',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          actions: [
            MaterialButton(
              child: Text(
                'Agendarse',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                var diaClase = fechaIG.day;
                bool confirmarDia = mismoDia(diaClase);
                if (confirmarDia == true) {
                  agendarse(idUsua, titulo, des, fechaIG, fechaFG,
                      nombreUsuario, id, lugar, listado, capacidad);
                } else {
                  msjMismoDia(context);
                }
              },
            ),
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

  ///este metodo se encarga de actualizar la base de datos, toca poner todos los datos de nuevo ya que si no se borran y solo deja el que pongas en el
  ///como tal no actualiza si no que remplaza
  Future agendarse(
      String idUsua,
      String titulo,
      String des,
      DateTime fechaini,
      DateTime fechafin,
      String nombreUsuario,
      String id,
      int lugar,
      var listado,
      int capacidad) async {
    int lugarNuevo = lugar + 1;
    //print("lugarNuevo= $lugarNuevo , capacidad: $capacidad");
    if (lugarNuevo <= capacidad) {
      listado[lugar] = nombreUsuario;
      print('id: $listado ');
      String lugarUsar = lugar.toString();
      await databaseReference.collection('eventos').document(id).setData({
        'Capacidad': capacidad,
        'Titulo': titulo,
        'Descripcion': des,
        'Fecha Inicio': fechaini,
        'Fecha Fin': fechafin,
        'Total participantes': lugarNuevo,
        'Participantes': listado,
      });
    } else {
      msjClaseLlena(context);
    }
  }

  bool mismoDia(var fechaClase) {
    DateTime fecha = DateTime.now();
    var hoy = fecha.day;
    print("****** hoy: $hoy, fecha clase: $fechaClase");
    if (fechaClase == hoy) {
      return false;
    } else {
      return true;
    }
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

  Future msjMismoDia(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: const Text(
              'Recuerda que solo puedes programar citas un día antes de estas'),
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

//_Pantalla3State
