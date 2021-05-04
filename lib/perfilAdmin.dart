import 'package:flutter/material.dart';
import 'package:gym/Registro1.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'Calendario.dart';

////////////////////////////////////////////////////////////////////////////////////////////////

class PantPerfilAdmin extends StatefulWidget {
  PantPerfilAdmin(
      {Key key,
      this.title,
      this.nombre,
      this.edad,
      this.cumple,
      this.Ident,
      this.Correo,
      this.NunContact,
      this.genero})
      : super(key: key);
  final String nombre;
  final String edad;
  final String cumple;
  final String Ident;
  final String Correo;
  final String NunContact;
  final String genero;
  final String title;
  @override
  _PantPerfilAdminState createState() => _PantPerfilAdminState();
}

class _PantPerfilAdminState extends State<PantPerfilAdmin> {
  TextEditingController _controllerNomb;
  TextEditingController _controllerEdad;
  TextEditingController _controllerCumple;
  TextEditingController _controllerIdent;
  TextEditingController _controllerCorreo;
  TextEditingController _controllerNum;
  TextEditingController _controllerGenero;
  @override
  void initState() {
    _controllerNomb = TextEditingController(text: this.widget.nombre);
    _controllerEdad = TextEditingController(text: this.widget.edad);
    _controllerCumple = TextEditingController(text: this.widget.cumple);
    _controllerIdent = TextEditingController(text: this.widget.Ident);
    _controllerCorreo = TextEditingController(text: this.widget.Correo);
    _controllerNum = TextEditingController(text: this.widget.NunContact);
    _controllerGenero = TextEditingController(text: this.widget.genero);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String nombre = _controllerNomb.text;
    String correo = _controllerCorreo.text;
    String edad = _controllerEdad.text;
    String cumple1 = _controllerEdad.text;
    String contacto = _controllerNum.text;
    String genero = _controllerGenero.text;
    String cumple = "Fecha de Nacimiento: " + cumple1;
    String numeroDocumento = _controllerIdent.text;
    String info =
        "Información personal:\nNombre: $nombre\nEdad:$edad \n$cumple\nIdentificación: $numeroDocumento\nCorreo: $correo\nNúmero de contacto: $contacto";

    return Scaffold(
      appBar: AppBar(
        title: Text('PARADISE'),
      ),
      body: ListView(
        children: [
          Container(
            child: Image.asset('assets/sinFotoPerfil.jpg', width: 200),
          ),
          Text(
            info,
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.all(5),
            child: TextField(
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Agrega una descripcion tuya\n\n.',
              ),
            ),
          ),
          SizedBox(height: 20),
        ], //children
      ),
    );
  }
} //_Pantalla3State
