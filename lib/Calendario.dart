import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'dart:core';

////////////////////////////////////////////////////////////////////////////////////////////////

class PantCalendar extends StatefulWidget {
  PantCalendar({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _PantCalendarState createState() => _PantCalendarState();
}

class _PantCalendarState extends State<PantCalendar> {
  String _vista = 'Selecciona una opción';
  String dia = "1";
  String hora = "5";
  String min = "30";
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  Stream events;

  SharedPreferences prefs;
  var cantGente;

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
  var _listaHoras = [
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
    '22'
  ];
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
  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
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
    int aforoMax = 100;
    return Scaffold(
      appBar: AppBar(
        title: Text('PARADISE'),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 15),
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
              '\n Recuerda que el Centro Deportivo tiene un aforo máximo de $aforoMax personas, así que deberás agendar tu entrenamiento o actividad un día antes y solo podrás estar un tiempo máximo de dos horas. Además, que debes cumplir con los protocolos de bioseguridad establecidos\n',
              style: TextStyle(
                color: Colors.black,
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
                borderRadius: BorderRadius.circular(20.0),
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
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.white),
                  )),
              todayDayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10.0)),
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
            margin: EdgeInsets.only(left: 50.0, right: 50.0),
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.redAccent[100],
                border: Border.all()),
            child: Text(
              '\nEscribe la fecha del día que deseas agendar \n(recuerda que solo puedes agendar un día antes)\n',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 100.0, right: 100.0),
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration:
                BoxDecoration(color: Colors.orange[50], border: Border.all()),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                items: _listaDias.map((String a) {
                  return DropdownMenuItem(value: a, child: Text(a));
                }).toList(),
                onChanged: (_value) => {
                  setState(() {
                    //_vista = _value;
                    this.dia = _value;
                  })
                },
                value: dia,
                dropdownColor: Colors.orange[50],
                isExpanded: false,
                hint: Text("Día"),
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            margin: EdgeInsets.only(left: 50.0, right: 50.0),
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.redAccent[100],
                border: Border.all()),
            child: Text(
              '\nElige la hora a la que deseas programar tu entrenamiento\n',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          ///////////////////////
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                            //_vista = _value;
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
                            //_vista = _value;
                            min = _value;
                          })
                        },
                        value: min,
                        dropdownColor: Colors.orange[50],
                        isExpanded: false,
                        hint: Text("Minutos"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
              child: Text('Validar',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              splashColor: Colors.lightBlue,
              color: Colors.blueAccent,
              elevation: 30.0,
              onPressed: () {},
            ),
          ),
          SizedBox(height: 20)
          /////////////////////////
        ],
      ),
      /*floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () {
            addEventDialog();
          }),*/
    );
  }

  addEventDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(8.0),
                    child: Text("Agregar evento"),
                  ),
                  TextField(
                    controller: _eventController,
                    decoration: InputDecoration(hintText: "Eventos"),
                  )
                ],
              ),
              actions: <Widget>[
                MaterialButton(
                  child: Text("Guardar"),
                  onPressed: () {
                    if (_eventController.text.isEmpty) return;

                    if (_events[_controller.selectedDay] != null) {
                      _events[_controller.selectedDay]
                          .add(_eventController.text);
                    } else {
                      _events[_controller.selectedDay] = [
                        _eventController.text
                      ];
                    }
                    prefs.setString("eventos", json.encode(encodeMap(_events)));
                    _eventController.clear();
                    Navigator.pop(context);
                  },
                )
              ],
            ));
    setState(() {
      _selectedEvents = _events[_controller.selectedDay];
    });
  }

  Future<void> agendarse() async {
    //  final FirebaseDatabase database = FirebaseDatabase.getInstance();
    // DatabaseReference ref = database.getReference("server/saving-data/fireblog");
    //  DatabaseReference usersRef = ref.child("usuarios");

//    DatabaseReference hopperRef = usersRef.child("gracehop");
    //  Map<String, Object> hopperUpdates = new HashMap<>();
    //  hopperUpdates.put("nickname", "Amazing Grace");
//
    //  hopperRef.updateChildrenAsync(hopperUpdates);
  }
} //_Pantalla3State
