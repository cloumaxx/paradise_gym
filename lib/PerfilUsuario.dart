import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym/Registro1.dart';
import 'Calendario.dart';

////////////////////////////////////////////////////////////////////////////////////////////////

class PantPerfilUsuario extends StatefulWidget {
  PantPerfilUsuario({Key key, this.title, this.codigo}) : super(key: key);
  final String codigo;
  final String title;
  @override
  _PantPerfilUsuarioState createState() =>
      _PantPerfilUsuarioState(codes: codigo);
}

class _PantPerfilUsuarioState extends State<PantPerfilUsuario> {
  _PantPerfilUsuarioState({this.codes});
  final String codes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PARADISE'),
      ),
      body: ListView(
        children: [
          Container(
            child: Image.asset('assets/sinFotoPerfil.jpg', width: 200),
          ),
          new StreamBuilder(
              stream: Firestore.instance
                  .collection('usuarios')
                  .document(codes)
                  .snapshots(),
              builder: (context, snapshot) {
                var user = snapshot.data;
                if (!snapshot.hasData) {
                  return new Text("Loading");
                }

                return new Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.blue[50], border: Border.all()),
                  child: Text(
                    'Nombre: ${user["Nombre"]} ${user["Apellido"]}\nCorreo: ${user["Correo"]}\n'
                    'Genero: ${user["Genero"]}\nIdentificacion: ${user['identificacion']}  ${user['numIdent']} ',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }),
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
