import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gym/PerfilUsuario.dart';
import 'main.dart';
import 'Calendario.dart';

////////////////////////////////////////////////////////////////////////////////////////////////

class PantMenPrincipal extends StatefulWidget {
  PantMenPrincipal({Key key, this.title, this.nombre, this.correoUse})
      : super(key: key);
  final String nombre;
  final String correoUse;
  final String title;
  @override
  _PantMenPrincipalState createState() => _PantMenPrincipalState();
} /////////////////////////////////

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

/////////////////////////
class _PantMenPrincipalState extends State<PantMenPrincipal> {
  TextEditingController _controller2;
  TextEditingController _controller3;
  @override
  void initState() {
    _controller2 = TextEditingController(text: this.widget.nombre);
    _controller3 = TextEditingController(text: this.widget.correoUse);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String nombre = _controller2.text;
    String correoUtil = _controller3.text;

    String nombrePant = devNombre(correoUtil);
    String edadPant = devEdad(correoUtil);
    String cumplePant = devCumple(correoUtil);
    String IdentPant = numeroDocumento(correoUtil);
    String Correo = correoUtil;
    String NunContactPant = devContacto(correoUtil);
    String generoPant = devGenero(correoUtil);

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
            decoration:
                BoxDecoration(color: Colors.orange[50], border: Border.all()),
            child: MaterialButton(
              minWidth: 20.0,
              height: 50.0,
              disabledColor: Colors.cyan[100],
              child: Text('Agendar Entrenamiento',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              splashColor: Colors.lightBlue,
              color: Colors.redAccent,
              elevation: 30.0,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return new PantCalendar();
                }));
              },
            ),
          ),
          SizedBox(height: 50),
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
                  builder: (context) => PantPerfilUsuario(
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
          SizedBox(height: 50),
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
          SizedBox(height: 35),
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
          )
        ], //children
      ),
    );
  }
} //_Pantalla3State
