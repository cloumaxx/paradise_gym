import 'package:flutter/material.dart';
import 'main.dart';
import 'Calendario.dart';
import 'perfilAdmin.dart';
import 'CalendarioAdmin.dart';
import 'estadoGym.dart';
////////////////////////////////////////////////////////////////////////////////////////////////

class PantMenPrincipalAdmin extends StatefulWidget {
  PantMenPrincipalAdmin({Key key, this.title, this.correoUse})
      : super(key: key);
  final String correoUse;

  final String title;
  @override
  _PantMenPrincipalAdminState createState() => _PantMenPrincipalAdminState();
}

///********************************************************************
String devNombre(String correo) {
  String nombre1 = "";
  String apellido1 = "";
  String nombreCompleto = "";

  nombreCompleto = nombre1 + apellido1;
  return nombreCompleto;
}

String devEdad(String correo) {
  String edad = "";

  return edad;
}

String devCumple1(String correo) {
  String edad = "";
  return edad;
}

String devContacto(String correo) {
  String numeroCel = "";

  return numeroCel;
}

String devGenero(String correo) {
  String genero = "";

  return genero;
}

String devCumple(String correo) {
  String dia1 = "";
  String mes1 = "";
  String anno1 = "";
  String fecha = "";

  fecha = dia1 + "/" + mes1 + "/" + anno1;
  return fecha;
}

String numeroDocumento(String correo) {
  String tipo = "";
  String numero = "";
  String devolucion = "";

  devolucion = " " + tipo + " : " + numero;
  return devolucion;
}

///****************************************************************************************************************************
class _PantMenPrincipalAdminState extends State<PantMenPrincipalAdmin> {
  TextEditingController _controller3;
  @override
  void initState() {
    _controller3 = TextEditingController(text: this.widget.correoUse);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String correoUtil = _controller3.text;
    String nombrePant = devNombre(correoUtil);
    String edadPant = devEdad(correoUtil);
    String cumplePant = devCumple(correoUtil);
    String IdentPant = numeroDocumento(correoUtil);
    String Correo = correoUtil;
    String NunContactPant = devContacto(correoUtil);
    String generoPant = devGenero(correoUtil);

    String nombre2 = "Administrador";
    String bienvenida = "Bienvenido ";
    String mensajeAgua = "\n¿Qué deseas hacer?  ";
    String msjNombre = bienvenida + nombre2 + mensajeAgua;
    return Scaffold(
      appBar: AppBar(
        title: Text('PARADISE'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 50),
          Text(
            msjNombre,
            style: TextStyle(
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          Container(
            margin: EdgeInsets.only(left: 50.0, right: 50.0),
            decoration:
                BoxDecoration(color: Colors.orange[50], border: Border.all()),
            child: MaterialButton(
              minWidth: 20.0,
              height: 50.0,
              disabledColor: Colors.red,
              child: Text('Estado del gimnasio',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              splashColor: Colors.lightBlue,
              color: Colors.red,
              elevation: 30.0,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute<Null>(builder: (BuildContext context) {
                  return new PantEstadoGym();
                }));
              },
            ),
          ),
          SizedBox(height: 40),
          Container(
            margin: EdgeInsets.only(left: 50.0, right: 50.0),
            decoration:
                BoxDecoration(color: Colors.orange[50], border: Border.all()),
            child: MaterialButton(
              minWidth: 20.0,
              height: 50.0,
              disabledColor: Colors.cyan[100],
              child: Text('Revisar agenda',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              splashColor: Colors.lightBlue,
              color: Colors.redAccent,
              elevation: 30.0,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute<Null>(builder: (BuildContext context) {
                  return new PantCalendario();
                }));
              },
            ),
          ),
          SizedBox(height: 40),
          Container(
            margin: EdgeInsets.only(left: 50.0, right: 50.0),
            decoration:
                BoxDecoration(color: Colors.orange[50], border: Border.all()),
            child: MaterialButton(
              minWidth: 20.0,
              height: 50.0,
              disabledColor: Colors.cyan[100],
              child: Text('Ver tu perfil',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              splashColor: Colors.lightBlue,
              color: Colors.deepOrange,
              elevation: 30.0,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PantPerfilAdmin(
                    nombre: nombrePant,
                    edad: edadPant,
                    cumple: cumplePant,
                    Ident: IdentPant,
                    Correo: Correo,
                    NunContact: NunContactPant,
                    genero: generoPant,
                  ),
                ));
              },
            ),
          ),
          SizedBox(height: 40),
          Container(
            margin: EdgeInsets.only(left: 50.0, right: 50.0),
            decoration:
                BoxDecoration(color: Colors.orange[50], border: Border.all()),
            child: MaterialButton(
              minWidth: 20.0,
              height: 50.0,
              disabledColor: Colors.cyan[100],
              child: Text('Configuración',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              splashColor: Colors.lightBlue,
              color: Colors.orange,
              elevation: 30.0,
              onPressed: () {},
            ),
          ),
          SizedBox(height: 40),
          Container(
            margin: EdgeInsets.only(left: 50.0, right: 50.0),
            decoration:
                BoxDecoration(color: Colors.orange[50], border: Border.all()),
            child: MaterialButton(
              minWidth: 20.0,
              height: 50.0,
              disabledColor: Colors.deepPurple[400],
              child: Text('Cerrar Sesión',
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
          ),
          SizedBox(height: 40),
        ], //children
      ),
    );
  }
} //_Pantalla3State
