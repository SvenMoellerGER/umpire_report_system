import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Umpire Report System',
    home: HomePage(),
  ));
}

enum SingingCharacter { protokollBahn, protokollWechsel, zielgerade, gegengerade, kurvenachdemstart, kurvevordemziel,
  unerlUnterst, behinderung, bahnVerlassen, huerdenlauf, hindernis, sonstiges, eigeneBahn,
  bordkante, bahnVorUebergangslinie, bahnVerlassenGruppenstart, 
  hueNebenbahn, hueUeberlaufen, hueNichtRegelgerechtUeberlaufen, hueUmgestossen, hiNichtRegelgerechtUeberlaufen }

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
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            textStyle: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        child: Text('Zurueck'),
                      ),
                      SizedBox(width: 25),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            textStyle: TextStyle(color: Colors.white)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print(
                                "Formular ist gültig und kann verarbeitet werden");
                            {
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => formProtokoll()),
                              );
                            };
                          } else {
                            print("Formular ist nicht gültig");
                          }
                        },
                        child: Text('Weiter'),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
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
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.grey,
                                  textStyle: TextStyle(color: Colors.white)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => formAllg(title: 'formAllg',)), // TODO 'title' entfernen
                                );
                              },
                              child: Text('Zurueck'),
                            ),
                            SizedBox(width: 25),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  textStyle: TextStyle(color: Colors.white)),
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
                                }
                              },
                              child: Text('Weiter'),
                            )
                          ],
                        )
                      ]
                  ),
                )
            )
        )
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class formBahnOrt extends StatefulWidget {
  const formBahnOrt({Key? key}) : super(key: key);

  @override
  State<formBahnOrt> createState() => _formBahnOrt();
}

/// This is the private State class that goes with formBahnOrt.
class _formBahnOrt extends State<formBahnOrt> {
  SingingCharacter? _character = SingingCharacter.zielgerade;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ort des Geschehens'),
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
                      title: const Text('Zielgerade'),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.zielgerade,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Gegengerade'),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.gegengerade,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Kurve nach dem Start'),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.kurvenachdemstart,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Kurve vor dem Ziel'),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.kurvevordemziel,
                        groupValue: _character,
                        onChanged: (SingingCharacter? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      maxLines: 5,
                      maxLength: 120,
                      decoration: InputDecoration(
                        hintText: 'ggf. nähere Angaben',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                              textStyle: TextStyle(color: Colors.white)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => formProtokoll()),
                            );
                          },
                          child: Text('Zurueck'),
                        ),
                        SizedBox(width: 25),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              textStyle: TextStyle(color: Colors.white)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print(
                                  "Formular ist gültig und kann verarbeitet werden");
                              {
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => formBahnAthlet()),);
                              };
                            } else {
                            print("Formular ist nicht gültig");
                            }
                          },
                          child: Text('Weiter'),
                        )
                      ],
                    )
                  ]
                ),
            )
        )
      )
    );
  }
}

// enum SingingCharacter { laeufer, geher }

/// This is the stateful widget that the main application instantiates.
class formBahnAthlet extends StatefulWidget {
  const formBahnAthlet({Key? key}) : super(key: key);

  @override
  State<formBahnAthlet> createState() => _formBahnAthlet();
}

/// This is the private State class that goes with formBahnAthlet.
class _formBahnAthlet extends State<formBahnAthlet> {
  // SingingCharacter? _character = SingingCharacter.zielgerade;
  // bool _value = false;
  int val = -1;
  //late String _chosenValue;
  String? _chosenValue;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Athlet'),
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
                    title: const Text('Läufer'),
                    leading: Radio(
                      value: 1,
                      groupValue: val,
                      onChanged: (int? value) {
                        setState(() {
                          val = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Geher'),
                    leading: Radio(
                      value: 2,
                      groupValue: val,
                      onChanged: (int? value) {
                        setState(() {
                          val = value!;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Start Nr.',
                      border: OutlineInputBorder(),
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Bitte eine Startnummer eingeben';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  DropdownButton<String>(
                    focusColor:Colors.white,
                    value: _chosenValue,
                    //elevation: 5,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor:Colors.black,
                    items: <String>[
                      '1',
                      '2',
                      '3',
                      '4',
                      '5',
                      '6',
                      '7',
                      '8',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style:TextStyle(color:Colors.black),),
                      );
                    }).toList(),
                    hint:Text(
                      "auf Bahn",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _chosenValue = value!;
                      });
                    },
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            textStyle: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => formBahnOrt()),
                          );
                        },
                        child: Text('Zurueck'),
                      ),
                      SizedBox(width: 25),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            textStyle: TextStyle(color: Colors.white)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print(
                                "Formular ist gültig und kann verarbeitet werden");
                            {
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => formBahnVorfall()),);
                            };
                          } else {
                          print("Formular ist nicht gültig");
                          }
                        },
                        child: Text('Weiter'),
                      )
                    ],
                  )
                ],
              )
            )
          )
        )
    );
  }
}

class formBahnVorfall extends StatefulWidget {
  const formBahnVorfall({Key? key}) : super(key: key);

  @override
  State<formBahnVorfall> createState() => _formBahnVorfall();
}

/// This is the private State class that goes with formBahnVorfall.
class _formBahnVorfall extends State<formBahnVorfall> {
  SingingCharacter? _character = SingingCharacter.unerlUnterst;
  final _formKey = GlobalKey<FormState>();

  get value => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Vorfall'),
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
                    title: const Text('unerlaubte Unterstützung'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.unerlUnterst,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Behinderung'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.behinderung,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Bahn verlassen'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.bahnVerlassen,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Hürdenlauf/Hindernis'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.huerdenlauf,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Sonstiges'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.sonstiges,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            textStyle: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => formBahnAthlet()),
                          );
                        },
                        child: Text('Zurueck'),
                      ),
                      SizedBox(width: 25),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            textStyle: TextStyle(color: Colors.white)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print(
                                "Formular ist gültig und kann verarbeitet werden");
                            {
                              print('value ' + _character.toString());
                              if (_character == SingingCharacter.unerlUnterst) {
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => formBahnVorfall_unerlUnterst()),);
                              } else if(_character == SingingCharacter.behinderung) {
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => formBahnVorfall_behinderung()),);
                              } else if(_character == SingingCharacter.bahnVerlassen) {
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => formBahnVorfall_bahnVerlassen()),);
                              } else if(_character == SingingCharacter.huerdenlauf) {
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => formBahnVorfall_huerdenlaufHindernis()),);
                              } else if(_character == SingingCharacter.sonstiges) {
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => formBahnVorfall_sonstiges()),);
                              } else {
                                print("### Hier ist etwas schief gelaufen!");
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => formNameKari()),);
                              }
                            }
                          } else {
                          print("Formular ist nicht gültig");
                          }
                        },
                        child: Text('Weiter'),
                      )
                    ],
                  )
                ],
              )
            )
          )
        )
    );
  }
}

// +++++ Auswahl des Verstoßes +++++

/// This is the stateful widget that the main application instantiates.
class formBahnVorfall_unerlUnterst extends StatefulWidget {
  const formBahnVorfall_unerlUnterst({Key? key}) : super(key: key);

  @override
  State<formBahnVorfall_unerlUnterst> createState() => _formBahnVorfall_unerlUnterst();
}

/// This is the private State class that goes with formBahnOrt.
class _formBahnVorfall_unerlUnterst extends State<formBahnVorfall_unerlUnterst> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Vorfall: unerlaubte Unterstützung'),
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
                          maxLines: 5,
                          maxLength: 120,
                          decoration: InputDecoration(
                            hintText: 'kurze Erläuterung',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Bitte den Sachverhalt erläutern';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.grey,
                                  textStyle: TextStyle(color: Colors.white)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => formBahnVorfall()),
                                );
                              },
                              child: Text('Zurueck'),
                            ),
                            SizedBox(width: 25),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  textStyle: TextStyle(color: Colors.white)),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  print(
                                      "Formular ist gültig und kann verarbeitet werden");
                                  {
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => formNameKari()),);
                                  };
                                } else {
                                  print("Formular ist nicht gültig");
                                }
                              },
                              child: Text('Weiter'),
                            )
                          ],
                        )
                      ]
                  ),
                )
            )
        )
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class formBahnVorfall_behinderung extends StatefulWidget {
  const formBahnVorfall_behinderung({Key? key}) : super(key: key);

  @override
  State<formBahnVorfall_behinderung> createState() => _formBahnVorfall_behinderung();
}

/// This is the private State class that goes with formBahnOrt.
class _formBahnVorfall_behinderung extends State<formBahnVorfall_behinderung> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Vorfall: Behinderung'),
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
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'behinderte Start Nr.',
                            hintText: 'behinderte Start Nr.',
                            border: OutlineInputBorder(),
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Bitte eine Startnummer eingeben';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          maxLines: 5,
                          maxLength: 120,
                          decoration: InputDecoration(
                            hintText: 'kurze Erläuterung',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Bitte den Sachverhalt erläutern';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.grey,
                                  textStyle: TextStyle(color: Colors.white)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => formBahnVorfall()),
                                );
                              },
                              child: Text('Zurueck'),
                            ),
                            SizedBox(width: 25),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  textStyle: TextStyle(color: Colors.white)),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  print(
                                      "Formular ist gültig und kann verarbeitet werden");
                                  {
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => formNameKari()),);
                                  };
                                } else {
                                  print("Formular ist nicht gültig");
                                }
                              },
                              child: Text('Weiter'),
                            )
                          ],
                        )
                      ]
                  ),
                )
            )
        )
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class formBahnVorfall_bahnVerlassen extends StatefulWidget {
  const formBahnVorfall_bahnVerlassen({Key? key}) : super(key: key);

  @override
  State<formBahnVorfall_bahnVerlassen> createState() => _formBahnVorfall_bahnVerlassen();
}

/// This is the private State class that goes with formBahnVorfall_bahnVerlassen.
class _formBahnVorfall_bahnVerlassen extends State<formBahnVorfall_bahnVerlassen> {
  SingingCharacter? _character = SingingCharacter.eigeneBahn;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Vorfall: Bahn verlassen'),
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
                          title: const Text('hat eigene Bahn verlassen'),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.eigeneBahn,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('auf Bordkante/entsprechende Begrenzungslinie '
                              'getreten oder innerhalb davon getreten/gelaufen'),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.bordkante,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('hat eigene Bahn vor der Übergangslinie verlassen '
                              'und ist auf eine innere Bahn gewechselt'),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.bahnVorUebergangslinie,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('hat beim Gruppenstart eigene Bahn vor der '
                              'Bahnfreigabe verlassen und ist auf eine innere Bahn gewechselt'),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.bahnVerlassenGruppenstart,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 30),
                        // TODO Row mit 2x checkbox ("innen" und "außen verlassen")
                        //SizedBox(height: 30),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Länge in [m]',
                            border: OutlineInputBorder(),
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          // TODO validator implementieren
                        ),
                        SizedBox(height: 10),
                        Text('bzw.'),
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Anzahl Schritte',
                            border: OutlineInputBorder(),
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          // TODO validator implementieren
                        ),
                        SizedBox(height: 30),
                        // TODO 1x Textfeld (number) für Länge
                        //SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.grey,
                                  textStyle: TextStyle(color: Colors.white)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => formBahnVorfall()),
                                );
                              },
                              child: Text('Zurueck'),
                            ),
                            SizedBox(width: 25),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  textStyle: TextStyle(color: Colors.white)),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  print(
                                      "Formular ist gültig und kann verarbeitet werden");
                                  {
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => formNameKari()),);
                                  };
                                } else {
                                  print("Formular ist nicht gültig");
                                }
                              },
                              child: Text('Weiter'),
                            )
                          ],
                        )
                      ]
                  ),
                )
            )
        )
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class formBahnVorfall_huerdenlaufHindernis extends StatefulWidget {
  const formBahnVorfall_huerdenlaufHindernis({Key? key}) : super(key: key);

  @override
  State<formBahnVorfall_huerdenlaufHindernis> createState() => _formBahnVorfall_huerdenlaufHindernis();
}

/// This is the private State class that goes with formBahnVorfall_huerdenlaufHindernis.
class _formBahnVorfall_huerdenlaufHindernis extends State<formBahnVorfall_huerdenlaufHindernis> {
  SingingCharacter? _character = SingingCharacter.hueNebenbahn;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Vorfall: Hürdenlauf/Hindernis'),
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
                          title: const Text('hat Hürde in der Nebenbahn umgestoßen'),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.hueNebenbahn,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('hat Hürde nicht überlaufen'),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.hueUeberlaufen,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('hat Hürde nicht regelgerecht überlaufen'),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.hueNichtRegelgerechtUeberlaufen,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('hat Hürde absichtlich umgestoßen'),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.hueUmgestossen,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('hat Hindernis nicht regelgerecht überlaufen'),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.hiNichtRegelgerechtUeberlaufen,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Hürde/Hindernis Nr.',
                            hintText: 'immer vom Start aus gezählt',
                            border: OutlineInputBorder(),
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Bitte die Nr. der Hürde eingeben';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        // TODO Row mit 2x checkbox "Hand" und "mit dem Fuß"
                        //SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.grey,
                                  textStyle: TextStyle(color: Colors.white)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => formBahnVorfall()),
                                );
                              },
                              child: Text('Zurueck'),
                            ),
                            SizedBox(width: 25),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  textStyle: TextStyle(color: Colors.white)),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  print(
                                      "Formular ist gültig und kann verarbeitet werden");
                                  {
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => formNameKari()),);
                                  };
                                } else {
                                  print("Formular ist nicht gültig");
                                }
                              },
                              child: Text('Weiter'),
                            )
                          ],
                        )
                      ]
                  ),
                )
            )
        )
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class formBahnVorfall_sonstiges extends StatefulWidget {
  const formBahnVorfall_sonstiges({Key? key}) : super(key: key);

  @override
  State<formBahnVorfall_sonstiges> createState() => _formBahnVorfall_sonstiges();
}

/// This is the private State class that goes with formBahnVorfall_sonstiges.
class _formBahnVorfall_sonstiges extends State<formBahnVorfall_sonstiges> {
  SingingCharacter? _character = SingingCharacter.eigeneBahn;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Vorfall: Sonstiges'),
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
                          title: const Text('hat nach freiwilligem Verlassen der Bahn '
                              'den Lauf/das Gehen fortgesetzt'),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.hueNebenbahn,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('hat nicht zulässige Markierungen angebracht'),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.hueUeberlaufen,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('weitere Beanstandungen'),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.hueNichtRegelgerechtUeberlaufen,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          maxLines: 5,
                          maxLength: 120,
                          decoration: InputDecoration(
                            hintText: 'kurze Erläuterung',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Bitte den Sachverhalt erläutern';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.grey,
                                  textStyle: TextStyle(color: Colors.white)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => formBahnVorfall()),
                                );
                              },
                              child: Text('Zurueck'),
                            ),
                            SizedBox(width: 25),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                  textStyle: TextStyle(color: Colors.white)),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  print(
                                      "Formular ist gültig und kann verarbeitet werden");
                                  {
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => formNameKari()),);
                                  };
                                } else {
                                  print("Formular ist nicht gültig");
                                }
                              },
                              child: Text('Weiter'),
                            )
                          ],
                        )
                      ]
                  ),
                )
            )
        )
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
                    maxLines: 5,
                    maxLength: 120,
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
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            textStyle: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => formBahnVorfall()),
                          );
                        },
                        child: Text('Zurueck'),
                      ),
                      SizedBox(width: 25),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            textStyle: TextStyle(color: Colors.white)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print(
                                "Formular ist gültig und kann verarbeitet werden");
                            // {
                            //   Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) => #####()),); // TODO Seite einfügen
                            // };
                          } else {
                          print("Formular ist nicht gültig");
                          }
                        },
                        child: Text('Abschließen'),
                      )
                    ],
                  )
                ],
              )
            )
          )
        )
    );
  }
}
