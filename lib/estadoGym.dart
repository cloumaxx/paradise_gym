import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';

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
  String hora = "1";
  String min = "30";
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  TextEditingController _eventosController;
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
    '12'
  ];

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
              '\n¿Cuál es el aforo máximo del gimnasio?\n',
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
                cantGente = texto;
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
                  event + "\n",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
              )),

          SizedBox(height: 20),
          Container(
            //margin: const EdgeInsets.all(0.0),
            //padding: const EdgeInsets.all(0.0),
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
            //margin: const EdgeInsets.all(0.0),
            //padding: const EdgeInsets.all(0.0),
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
              controller: _eventosController,
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
                            this.hora = _value;
                          })
                        },
                        value: hora,
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
                            this.min = _value;
                          })
                        },
                        value: min,
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
                            this.hora = _value;
                          })
                        },
                        value: hora,
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
                            this.min = _value;
                          })
                        },
                        value: min,
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

          /*Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height / 20,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey)),
                  child: Center(
                      child: Text(
                    event,
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )),
                ),
              )),*/
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
                if (_eventosController.text.isEmpty) return;

                if (_events[_controller.selectedDay] != null) {
                  _events[_controller.selectedDay].add(_eventosController.text);
                } else {
                  _events[_controller.selectedDay] = [_eventosController.text];
                }
                prefs.setString("eventos", json.encode(encodeMap(_events)));
                _eventController.clear();
                msjConfirmar(context);
              },
            ),
          ),

          SizedBox(height: 100),
        ],

        //children
      ),
    );
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
} //_Pantalla3State