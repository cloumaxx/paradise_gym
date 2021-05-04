import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym/classUsuario.dart';
import 'Menu principal.dart';
import 'classUsuario.dart';

import 'main.dart';

class PantRegistro1 extends StatefulWidget {
  PantRegistro1({Key key, this.title, this.users2}) : super(key: key);
  final classUsuarios users2;
  final String title;
  @override
  _PantRegistro1State createState() => _PantRegistro1State();
}

class _PantRegistro1State extends State<PantRegistro1> {
  final databaseReference = Firestore.instance;
  void createRecord() async {
    DocumentReference ref = await databaseReference.collection("usuarios").add({
      'title': 'Flutter in action',
      'description': 'Mi valor',
      'Nombre': nombre,
      'Apellido': apellido,
      'Dia': dia,
      'Mes': mes,
      'Anno': anno,
      'Celular': cel,
      'identificacion': identificacion,
      'numIdent': numCC,
      'Genero': genero,
      'Correo': correo,
      'Contrasena': contrasena,
    });
    print("/////////////////////////////////\n" +
        ref.documentID +
        "\n/////////////////////////////////////////////////");
  }

  @override
  List<classUsuarios> users = new List<classUsuarios>();
  String msjCrear = "***************************************\n";
  String nombre = "";
  String apellido = "";
  String dia = "1";
  String mes = "Enero";
  String anno = "1950";
  String cel = "";
  String identificacion = "C.C";
  String numCC = "";
  String genero = "Hombre";
  String correo = "";
  String contrasena = "";
  String confirmarContrasena = "";
  var _lista = ['C.C', 'T.I'];
  var _listaDias = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  var _listaMese = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];
  var _listaAnnos = [
    '1950',
    '1951',
    '1952',
    '1953',
    '1954',
    '1955',
    '1956',
    '1957',
    '1958',
    '1959',
    '1960',
    '1961',
    '1962',
    '1963',
    '1964',
    '1965',
    '1966',
    '1967',
    '1968',
    '1969',
    '1970',
    '1971',
    '1972',
    '1973',
    '1974',
    '1975',
    '1976',
    '1977',
    '1978',
    '1979',
    '1980',
    '1981',
    '1982',
    '1983',
    '1984',
    '1985',
    '1986',
    '1987',
    '1988',
    '1989',
    '1990',
    '1991',
    '1992',
    '1993',
    '1994',
    '1995',
    '1996',
    '1997',
    '1998',
    '1999',
    '2000',
    '2001',
    '2002',
    '2003',
    '2004',
    '2005',
    '2006',
    '2007',
    '2008',
    '2009',
    '2010',
    '2011',
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
    '2021'
  ];
  var _listGeneros = ['Hombre', 'Mujer', 'Otro'];
  String _vista = 'Selecciona una opción';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PARADISE'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          Text(
            '!!! BIENVENIDO AL REGISTRO !!!',
            style: TextStyle(
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15),
          Text(
            '  Por favor llena los siguientes recuadros\n con tu información personal',
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            child: TextField(
              onChanged: (texto) {
                nombre = texto;
              },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: '¿Cuál es tu nombre? ',
                hintText: ' Escribe tu nombre ',
                filled: true,
                fillColor: Color(0xFFFFF3E0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(150)),
                  borderSide: BorderSide(color: Colors.black),
                ), //InputDecoration
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            child: TextField(
              onChanged: (texto) {
                apellido = texto;
              },
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: '¿Cuáles son tus apellidos? ',
                hintText: ' Escribe tus apellidos ',
                filled: true,
                fillColor: Color(0xFFFFF3E0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(150)),
                  borderSide: BorderSide(color: Colors.black),
                ), //InputDecoration
              ),
            ),
          ),
          SizedBox(height: 25),
          Text(
            'Selecciona tu fecha de nacimiento',
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15),
          Container(
            margin: EdgeInsets.only(left: 100.0, right: 100.0),
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(150)),
                color: Colors.orange[50],
                border: Border.all()),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                items: _listaDias.map((String a) {
                  return DropdownMenuItem(value: a, child: Text(a));
                }).toList(),
                onChanged: (_value) => {
                  setState(() {
                    // _vista = _value;
                    this.dia = _value;
                  })
                },
                value: dia,
                dropdownColor: Colors.orange[50],
                isExpanded: false,
                hint: Text("Dia "),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 100.0, right: 100.0),
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(150)),
                color: Colors.orange[50],
                border: Border.all()),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                items: _listaMese.map((String a) {
                  return DropdownMenuItem(value: a, child: Text(a));
                }).toList(),
                onChanged: (_value) => {
                  setState(() {
                    this.mes = _value;
                  })
                },
                value: mes,
                dropdownColor: Colors.orange[50],
                isExpanded: false,
                hint: Text("Mes"),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 100.0, right: 100.0),
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(150)),
                color: Colors.orange[50],
                border: Border.all()),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                items: _listaAnnos.map((String a) {
                  return DropdownMenuItem(value: a, child: Text(a));
                }).toList(),
                onChanged: (_value) => {
                  setState(() {
                    this.anno = _value;
                  })
                },
                value: anno,
                dropdownColor: Colors.orange[50],
                isExpanded: false,
                hint: Text("Año"),
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            child: TextField(
              onChanged: (texto) {
                cel = texto;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '¿Cuál es tú número de celular?',
                hintText: ' Escribe tu número de celular ',
                filled: true,
                fillColor: Color(0xFFFFF3E0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(150)),
                  borderSide: BorderSide(color: Colors.black),
                ), //InputDecoration
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            '¿Cuál es tú número de identificación? ',
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            child: TextField(
              onChanged: (texto) {
                numCC = texto;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Escribe tu número de identidad',
                hintText: ' Escribe tu número de identidad ',
                filled: true,
                fillColor: Color(0xFFFFF3E0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(150)),
                  borderSide: BorderSide(color: Colors.black),
                ), //InputDecoration
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Selecciona que tipo de documento',
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 100.0, right: 100.0),
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(150)),
                color: Colors.orange[50],
                border: Border.all()),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                items: _lista.map((String a) {
                  return DropdownMenuItem(value: a, child: Text(a));
                }).toList(),
                onChanged: (_value) => {
                  setState(() {
                    this.identificacion = _value;
                  })
                },
                value: identificacion,
                dropdownColor: Colors.orange[50],
                isExpanded: false,
                //value: _lista.first,
                hint: Text(_vista),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            '¿Cúal es tu genero?',
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 100.0, right: 100.0),
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(150)),
                color: Colors.orange[50],
                border: Border.all()),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                items: _listGeneros.map((String a) {
                  return DropdownMenuItem(value: a, child: Text(a));
                }).toList(),
                onChanged: (_value) => {
                  setState(() {
                    this.genero = _value;
                  })
                },
                value: genero,
                dropdownColor: Colors.orange[50],
                isExpanded: false,
                hint: Text(_vista),
              ),
            ),
          ),
          SizedBox(height: 25),
          Text(
            '¿Cuál es tú correo electrónico? ',
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            child: TextField(
              onChanged: (texto) {
                correo = texto;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Escribe tu correo',
                hintText: ' Escribe tu correo ',
                filled: true,
                fillColor: Color(0xFFFFF3E0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(150)),
                  borderSide: BorderSide(color: Colors.black),
                ), //InputDecoration
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Ingresa una clave para tu cuenta ',
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            child: TextField(
              onChanged: (texto1) {
                contrasena = texto1;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Escribe la clave',
                hintText: ' Escribe la clave ',
                filled: true,
                fillColor: Color(0xFFFFF3E0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(150)),
                  borderSide: BorderSide(color: Colors.black),
                ), //InputDecoration
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
            child: TextField(
              onChanged: (texto2) {
                confirmarContrasena = texto2;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Vuelve a escribir la clave',
                hintText: ' Vuelve a escribir la clave ',
                filled: true,
                fillColor: Color(0xFFFFF3E0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(150)),
                  borderSide: BorderSide(color: Colors.black),
                ), //InputDecoration
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.only(left: 100.0, right: 100.0),
            decoration:
                BoxDecoration(color: Colors.orange[50], border: Border.all()),
            child: MaterialButton(
              minWidth: 20.0,
              height: 50.0,
              disabledColor: Colors.orange,
              child: Text('Siguiente',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              splashColor: Colors.deepOrange,
              color: Colors.yellowAccent,
              elevation: 30.0,
              onPressed: () {
                print('día= $dia');
                if (contrasena == confirmarContrasena) {
                  ///creacion clave
                  bool completo = llenarFormulario(
                      nombre, apellido, cel, numCC, correo, contrasena);
                  if (completo == true) {
                    msjCrear += "Usuario: " +
                        nombre +
                        " " +
                        apellido +
                        "  Fecha Nacimiento: " +
                        dia +
                        "/" +
                        mes +
                        "/" +
                        anno +
                        "  Celular: " +
                        cel +
                        "  Documento: " +
                        identificacion +
                        "  " +
                        numCC +
                        "  Genero: " +
                        genero +
                        "  Correo: " +
                        correo +
                        "  Contraseña: " +
                        contrasena;

                    classUsuarios objUsuario = new classUsuarios(
                        correo,
                        nombre,
                        apellido,
                        dia,
                        mes,
                        anno,
                        cel,
                        identificacion,
                        numCC,
                        genero,
                        contrasena);
                    users.add(objUsuario);
                    String j = objUsuario.getapellido();
                    createRecord();
                    print("********************************\n\n $j ");
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return new MyApp(); //PantEstadoGym(); // //PantMenPrincipalAdmin();  // //
                    }));
                  } else {
                    msjErroneo(context);
                  }
                  print('\n$msjCrear');
                } else {
                  //context: context;
                  _ackAlert(context);
                }
              },
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  bool llenarFormulario(String name, String lastName, String celphone,
      String docCC, String mail, String contrasena) {
    bool completo = false;
    if (name != "" &&
        lastName != "" &&
        celphone != "" &&
        docCC != "" &&
        mail != "" &&
        contrasena != "") {
      completo = true;
    }
    return completo;
  }

  void agregarUser(
      String nombre,
      String apellido,
      String dia,
      String mes,
      String anno,
      String cel,
      String identificacion,
      String numCC,
      String genero,
      String correo,
      String contrasena) {}

  Future _ackAlert(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: const Text('Las claves que registraste no son iguales'),
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

  List<classUsuarios> devLista() {
    return users;
  }

  Future msjErroneo(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: const Text(
              'Alguna casilla esta vacía por favor vuelve a revisar'),
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
} //_Pantalla3State
