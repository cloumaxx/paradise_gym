import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:convert';

class PantEstadoGym extends StatefulWidget {
  PantEstadoGym({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _PantEstadoGymState createState() => _PantEstadoGymState();
}

class _PantEstadoGymState extends State<PantEstadoGym> {
  var cantGente;
  String titulo = "";
  String usuario = "";
  String horaI = "1";
  String horaF = "1";
  String minI = "30";
  String minF = "30";
  String nombreEvento = "";
  String descEvento = "";
  CalendarController _controller;
  List<dynamic> _selectedEvents;
  Map<DateTime, List<dynamic>> _events;
  TextEditingController _eventController;
  TextEditingController _eventosController;
  TextEditingController _descriController;
  Stream events;
  SharedPreferences prefs;
  var _listaMinutos = [
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
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '43',
    '44',
    '45',
    '46',
    '47',
    '48',
    '49',
    '50',
    '51',
    '52',
    '53',
    '54',
    '55',
    '56',
    '57',
    '58',
    '59',
    '60'
  ];
  var _listaHoras = [
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
    '20',
    '21',
    '22',
    '23'
  ];
  String numero = "";

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _eventosController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    prefsDAta();
  }

  prefsDAta() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PARADISE'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),

          Container(
            margin: EdgeInsets.only(left: 70.0, right: 70.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(150)),
                color: Colors.blue,
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                )),
            child: Text(
              '\nAgendar Entrenamientos\n',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          TableCalendar(
            events: _events,
            initialCalendarFormat: CalendarFormat.month,
            calendarStyle: CalendarStyle(
                canEventMarkersOverflow: true,
                todayColor: Colors.red[150],
                selectedColor: Theme.of(context).primaryColor,
                todayStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.white)),
            headerStyle: HeaderStyle(
              centerHeaderTitle: true,
              formatButtonDecoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(50.0),
              ),
              formatButtonTextStyle: TextStyle(color: Colors.white),
              formatButtonShowsNext: false,
            ),
            startingDayOfWeek: StartingDayOfWeek.sunday,
            onDaySelected: (date, events, holidays) {
              setState(() {
                _selectedEvents = events;
              });
            },
            builders: CalendarBuilders(
              selectedDayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(50.0)),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
              todayDayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(50.0)),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            calendarController: _controller,
          ),
          ..._selectedEvents.map((event) => ListTile(
                title: Text(
                  "\n->  " + event + "   \n",
                  style: TextStyle(
                    backgroundColor: Colors.blue,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
              )),
          Container(
            margin: const EdgeInsets.all(30.0),
            padding: const EdgeInsets.all(10.0),
            //margin: EdgeInsets.only(left: 40.0, right: 35.0),
            decoration: BoxDecoration(
                color: Colors.yellow[100],
                border: Border.all(
                  color: Colors.black,
                  width: 5,
                )),
            child: Text(
              '\n¿De cuantas personas es la clase?\n',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            //padding: const EdgeInsets.all(10.0),
            margin: EdgeInsets.only(left: 70.0, right: 70.0),
            decoration: BoxDecoration(
                color: Colors.yellow[100],
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                )),
            child: TextField(
              onChanged: (texto) {
                numero = texto;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: ' Escribe la cantidad permitida ',
                filled: true,
                fillColor: Color(0xFFFFF3E0),
                enabledBorder: OutlineInputBorder(
                  // borderRadius: BorderRadius.all(Radius.circular(150)),
                  borderSide: BorderSide(color: Colors.black),
                ), //InputDecoration
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.only(left: 40.0, right: 35.0),
            decoration: BoxDecoration(
                color: Colors.yellow[100],
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                )),
            child: Text(
              '\nTitulo del evento:\n',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 40.0, right: 35.0),
            decoration: BoxDecoration(
                color: Colors.yellow[100],
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                )),
            child: TextField(
              onChanged: (texto) {
                nombreEvento = texto;
              },
              controller: _eventosController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: ' Titulo del evento ',
                filled: true,
                fillColor: Color(0xFFFFF3E0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ), //InputDecoration
              ),
            ),
          ),

          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.only(left: 40.0, right: 35.0),
            decoration: BoxDecoration(
                color: Colors.yellow[100],
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                )),
            child: Text(
              '\n Descripción del evento:\n',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 40.0, right: 35.0),
            decoration: BoxDecoration(
                color: Colors.yellow[100],
                border: Border.all(
                  color: Colors.black,
                  width: 3,
                )),
            child: TextField(
              onChanged: (texto) {
                descEvento = texto;
              },
              controller: _descriController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: ' Descripción del evento ',
                filled: true,
                fillColor: Color(0xFFFFF3E0),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ), //InputDecoration
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.all(30.0),
            padding: const EdgeInsets.all(10.0),
            //margin: EdgeInsets.only(left: 40.0, right: 35.0),
            decoration: BoxDecoration(
                color: Colors.yellow[100],
                border: Border.all(
                  color: Colors.black,
                  width: 5,
                )),
            child: Text(
              '\nSelecciona la hora y minutos en los que se puede programar una cita\n',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          Container(
            child: Text(
              ' Desde:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 15),

          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hora:  ',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    // margin: EdgeInsets.only(left: 100.0, right: 100.0),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.orange[50], border: Border.all()),

                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: _listaHoras.map((String a) {
                          return DropdownMenuItem(value: a, child: Text(a));
                        }).toList(),
                        onChanged: (_value) => {
                          setState(() {
                            this.horaI = _value;
                          })
                        },
                        value: horaI,
                        dropdownColor: Colors.orange[50],
                        isExpanded: false,
                        hint: Text("Hora"),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    ' :  ',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    // margin: EdgeInsets.only(left: 100.0, right: 100.0),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.orange[50], border: Border.all()),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: _listaMinutos.map((String a) {
                          return DropdownMenuItem(value: a, child: Text(a));
                        }).toList(),
                        onChanged: (_value) => {
                          setState(() {
                            this.minI = _value;
                          })
                        },
                        value: minI,
                        dropdownColor: Colors.orange[50],
                        isExpanded: false,
                        hint: Text("Minutos"),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    ' am ',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
          ///////////////////////////////////////////////////
          SizedBox(height: 15),
          Container(
            child: Text(
              ' Hasta:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hora:  ',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    // margin: EdgeInsets.only(left: 100.0, right: 100.0),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.orange[50], border: Border.all()),

                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: _listaHoras.map((String a) {
                          return DropdownMenuItem(value: a, child: Text(a));
                        }).toList(),
                        onChanged: (_value) => {
                          setState(() {
                            this.horaF = _value;
                          })
                        },
                        value: horaF,
                        dropdownColor: Colors.orange[50],
                        isExpanded: false,
                        hint: Text("Hora"),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    ' :  ',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    // margin: EdgeInsets.only(left: 100.0, right: 100.0),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.orange[50], border: Border.all()),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: _listaMinutos.map((String a) {
                          return DropdownMenuItem(value: a, child: Text(a));
                        }).toList(),
                        onChanged: (_value) => {
                          setState(() {
                            this.minF = _value;
                          })
                        },
                        value: minF,
                        dropdownColor: Colors.orange[50],
                        isExpanded: false,
                        hint: Text("Minutos"),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    ' pm ',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),

          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 100.0, right: 100.0),
            decoration:
                BoxDecoration(color: Colors.orange[50], border: Border.all()),
            child: MaterialButton(
              minWidth: 20.0,
              height: 50.0,
              disabledColor: Colors.orange,
              child: Text('Validar',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              splashColor: Colors.deepOrange,
              color: Colors.lightBlueAccent[100],
              elevation: 30.0,
              onPressed: () {
                var Fecha = _controller.selectedDay;
                var diaFecha = Fecha.day;
                var mesFecha = Fecha.month;
                var annoFecha = Fecha.year;
                print('===> $diaFecha / $mesFecha / $annoFecha');
                int num = int.parse(numero);
                bool val = validarEvento(diaFecha, mesFecha, annoFecha, horaI,
                    minI, horaF, minF, nombreEvento, descEvento, num);
                print("===========> $val");
                if (val == true) {
                  if (val == true) {
                    msjConfirmar(context);
                  }
                  if (_eventosController.text.isEmpty) return;

                  if (_events[_controller.selectedDay] != null) {
                    _events[_controller.selectedDay]
                        .add(_eventosController.text);
                  } else {
                    _events[_controller.selectedDay] = [
                      _eventosController.text
                    ];
                  }
                  prefs.setString("eventos", json.encode(encodeMap(_events)));
                  _eventController.clear();
                }

                if (val == false) {
                  msjError(context);
                }
              },
            ),
          ),

          SizedBox(height: 100),
        ],

        //children
      ),
    );
  }

  final databaseReference = Firestore.instance;
  void createRecord(DateTime fechaIni, DateTime fechaFin, String titulo,
      String descripcion, int capacidad) async {
    var listado = new List(capacidad);
    DocumentReference ref = await databaseReference.collection("eventos").add({
      'Fecha Inicio': fechaIni,
      'Fecha Fin': fechaFin,
      'Titulo': titulo,
      'Descripcion': descripcion,
      'Capacidad': capacidad,
      'Participantes': listado,
      'Total participantes': 0,
    });
    /* print("/////////////////////////////////\n" +
        ref.documentID +
        "\n/////////////////////////////////////////////////");
  */
  }

  bool validarEvento(
      var diaUse,
      var mesUse,
      var annoUse,
      String horaUseI,
      String minUseI,
      String horaUSeF,
      String minUseF,
      String titulo,
      String descripcion,
      int cantidad) {
    bool esta;
    int crearHoraI = int.parse(horaUseI);
    int crearMinI = int.parse(minUseI);
    int crearHoraF = int.parse(horaUSeF);
    int crearMinF = int.parse(minUseF);
    DateTime fechaHoy = DateTime.now();
    var diaHoy = fechaHoy.day;
    var mesHoy = fechaHoy.month;
    var fechaAgendada =
        DateTime.utc(annoUse, mesUse, diaUse, crearHoraI, crearMinI);

    if (diaHoy == diaUse && mesHoy == mesUse) {
      esta = false;
    } else {
      esta = true;
    }
    if (esta == true) {
      var fechaFin =
          DateTime.utc(annoUse, mesUse, diaUse, crearHoraF, crearMinF);
      print(
          '$diaUse / $mesUse / $annoUse/ $crearHoraI /$crearMinI / $crearHoraF / $crearMinF\n ');
      createRecord(fechaAgendada, fechaFin, titulo, descripcion, cantidad);
    }
    return esta;
  }

  Future msjConfirmar(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exitoso'),
          content: const Text('La reunón se agrego correctamente'),
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

  Future msjError(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: const Text('La reunón no se pudo guardar'),
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
