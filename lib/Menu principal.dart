import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gym/PerfilUsuario.dart';
import 'listaUsuarios.dart';
import 'main.dart';
import 'Calendario.dart';

////////////////////////////////////////////////////////////////////////////////////////////////

class PantMenPrincipal extends StatefulWidget {
  PantMenPrincipal({Key key, this.title, this.codigo, this.nameUsua})
      : super(key: key);
  final String codigo;
  final String nameUsua;
  final String title;
  @override
  _PantMenPrincipalState createState() =>
      _PantMenPrincipalState(code: codigo, nombre: nameUsua);
} /////////////////////////////////

/////////////////////////
class _PantMenPrincipalState extends State<PantMenPrincipal> {
  final String code;
  final String nombre;
  _PantMenPrincipalState({this.code, this.nombre});
  @override
  Widget build(BuildContext context) {
    String correoUtil = "";
    String id = "";

    /////////////////////////////////////////////

    String bienvenida = "Bienvenido ";
    String mensajeAgua = "\n¿Qué deseas hacer?  ";
    String msjNombre = bienvenida + nombre + mensajeAgua;
    return Scaffold(
      appBar: AppBar(
        title: Text('PARADISE'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 70),
          Text(
            msjNombre,
            style: TextStyle(
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          Container(
            margin: EdgeInsets.only(left: 50.0, right: 50.0),
            //decoration:
            //BoxDecoration(color: Colors.orange[50], border: Border.all()),
            child: RaisedButton.icon(
              padding: new EdgeInsets.all(15),
              icon: Icon(Icons.calendar_today_sharp),
              label: Text('Agendar Entrenamiento',
                  style: TextStyle(fontSize: 21, color: Colors.black)),
              splashColor: Colors.lightBlue,
              color: Colors.redAccent,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return new PantCalendar(
                    nombre: nombre,
                    codigo: code,
                  );
                }));
              },
            ),
          ),
          SizedBox(height: 50),
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
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PantPerfilUsuario(
                    codigo: code,
                  ),
                ));
              },
            ),
          ),
          SizedBox(height: 50),
          Container(
            margin: EdgeInsets.only(left: 50.0, right: 50.0),
            decoration:
                BoxDecoration(color: Colors.orange[50], border: Border.all()),
            child: RaisedButton.icon(
              padding: new EdgeInsets.all(15),
              icon: Icon(Icons.check),
              label: Text('Validar asistencia',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              splashColor: Colors.lightBlue,
              color: Colors.orange,
              elevation: 30.0,
              onPressed: () {
                Navigator.of(context).push(// cabio de pantalla
                    MaterialPageRoute(builder: (BuildContext context) {
                  return new PantLista(
                      nombreUsar:
                          nombre); //PantLista(); //PantMenPrincipalAdmin(); //PantCalendar(); //// PantRegistro1(); ////  ; // // // //
                }));
              },
            ),
          ),
          SizedBox(height: 35),
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
          )
        ], //children
      ),
    );
  }
} //_Pantalla3State
