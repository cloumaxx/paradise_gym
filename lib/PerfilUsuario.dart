import 'package:flutter/material.dart';
import 'package:gym/Registro1.dart';
import 'Calendario.dart';

////////////////////////////////////////////////////////////////////////////////////////////////

class PantPerfilUsuario extends StatefulWidget {
  PantPerfilUsuario(
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
  _PantPerfilUsuarioState createState() => _PantPerfilUsuarioState();
}

class _PantPerfilUsuarioState extends State<PantPerfilUsuario> {
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
                hintText: 'Agrega una descripción tuya\n\n.',
              ),
            ),
          ),
          SizedBox(height: 20),
          MaterialButton(
            minWidth: 20.0,
            height: 50.0,
            disabledColor: Colors.cyan[100],
            child: Text('Editar',
                style: TextStyle(fontSize: 20, color: Colors.black)),
            splashColor: Colors.lightGreen[400],
            color: Colors.limeAccent,
            elevation: 30.0,
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute<Null>(builder: (BuildContext context) {
                return new PantRegistro1();
              }));
            },
          ),
          SizedBox(height: 30),
        ], //children
      ),
    );
  }
} //_Pantalla3State
