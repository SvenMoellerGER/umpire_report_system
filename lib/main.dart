import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'util.bahn.dart';
import 'util.wechsel.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Umpire Report System',
    home: HomePage(),
  ));
}

enum SingingCharacter { protokollBahn, protokollWechsel, }

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:  () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => formAllg(title: 'Allgemein')),
          );
        },
        tooltip: 'Neuen Vorfall melden',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class formAllg extends StatefulWidget {
  formAllg({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _formAllg createState() => _formAllg();
}

class _formAllg extends State<formAllg> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd.MM.yyyy');
  final String formattedDate = formatter.format(now);

  @override
  TimeOfDay _currentTime = TimeOfDay.now();
  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: _currentTime,
        builder: (context, childWidget) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  alwaysUse24HourFormat: true),
              child: childWidget!);
        });
    if (newTime != null) {
      setState(() {
        _currentTime = newTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Veranstaltung',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Bitte einen Veranstaltungsnamen eingeben';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Wettbewerb',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Bitte einen Wettbewerb eingeben';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _selectTime,
                    child: Text('Uhrzeit'),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Zeit des Vorfalls: ${_currentTime.format(context)}',
                  ),
                ],
              ),
            ),
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            print("Formular ist gültig und kann verarbeitet werden");
            {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => formProtokoll()),
              );
            };
          } else {
            print("Formular ist nicht gültig");
          }},
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.arrow_forward_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class formProtokoll extends StatefulWidget {
  const formProtokoll({Key? key}) : super(key: key);

  @override
  State<formProtokoll> createState() => _formProtokoll();
}

/// This is the private State class that goes with formProtokoll.
class _formProtokoll extends State<formProtokoll> {
  SingingCharacter? _character = SingingCharacter.protokollBahn;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Protokollart'),
        ),
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          title: const Text('Bahnrichterprotokoll'),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.protokollBahn,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Wechselrichterprotokoll'),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.protokollWechsel,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                      ]
                  ),
                ),
            ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              print("Formular ist gültig und kann verarbeitet werden");
              if(_character == SingingCharacter.protokollBahn) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => formBahnOrt()));
              } else {
                // TODO Seiten für Wechselprotokoll erstellen
                //  Navigator.push(context, MaterialPageRoute(builder: (context) => formWechselVorfall()));
              }
            } else {
              print("Formular ist nicht gültig");
            }},
          backgroundColor: Colors.deepOrange,
          child: const Icon(Icons.arrow_forward_rounded),
        ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class formNameKari extends StatefulWidget {
  const formNameKari({Key? key}) : super(key: key);

  @override
  State<formNameKari> createState() => _formNameKari();
}

/// This is the private State class that goes with formNameKari.
class _formNameKari extends State<formNameKari> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dein Name'),
        ),
        body: SingleChildScrollView(
          child: Form(
          key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    maxLines: 1,
                    maxLength: 30,
                    decoration: InputDecoration(
                      hintText: 'Dein Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Bitte gib deinen Namen ein';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            print("Formular ist gültig und kann verarbeitet werden");
            {
              // TODO Route einfügen
              // Navigator.push(context,
              //   MaterialPageRoute(builder: (context) => formNameKari()),
              // );
            };
          } else {
            print("Formular ist nicht gültig");
          }},
        backgroundColor: Colors.deepOrange,
        label: const Text('Abschließen'),
        icon: const Icon(Icons.save_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
