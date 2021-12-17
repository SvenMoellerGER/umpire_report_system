import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Umpire Report System',
    home: HomePage(),
  ));
}

enum SingingCharacter { zielgerade, gegengerade, kurvenachdemstart, kurvevordemziel,
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
                    child: Text('SELECT TIME'),
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
                          // Wenn alle Validatoren der Felder des Formulars gültig sind.
                          if (_formKey.currentState!.validate()) {
                            print(
                                "Formular ist gültig und kann verarbeitet werden");
                            {
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => formOrt()),
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
class formOrt extends StatefulWidget {
  const formOrt({Key? key}) : super(key: key);

  @override
  State<formOrt> createState() => _formOrt();
}

/// This is the private State class that goes with formOrt.
class _formOrt extends State<formOrt> {
  SingingCharacter? _character = SingingCharacter.zielgerade;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              MaterialPageRoute(builder: (context) => formAllg(title: 'formAllg',)),
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
                            // Wenn alle Validatoren der Felder des Formulars gültig sind.
                            if (_formKey.currentState!.validate()) {
                              print(
                                  "Formular ist gültig und kann verarbeitet werden");
                              {
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => formAthlet()),);
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
class formAthlet extends StatefulWidget {
  const formAthlet({Key? key}) : super(key: key);

  @override
  State<formAthlet> createState() => _formAthlet();
}

/// This is the private State class that goes with formAthlet.
class _formAthlet extends State<formAthlet> {
  // SingingCharacter? _character = SingingCharacter.zielgerade;
  // bool _value = false;
  int val = -1;
  //late String _chosenValue;
  String? _chosenValue;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            MaterialPageRoute(builder: (context) => formOrt()),
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
                          // Wenn alle Validatoren der Felder des Formulars gültig sind.
                          if (_formKey.currentState!.validate()) {
                            print(
                                "Formular ist gültig und kann verarbeitet werden");
                            {
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => formVorfall()),);  //TODO Seite einfügen
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

class formVorfall extends StatefulWidget {
  const formVorfall({Key? key}) : super(key: key);

  @override
  State<formVorfall> createState() => _formVorfall();
}

/// This is the private State class that goes with formVorfall.
class _formVorfall extends State<formVorfall> {
  SingingCharacter? _character = SingingCharacter.unerlUnterst;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            MaterialPageRoute(builder: (context) => formAthlet()),
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
                          // Wenn alle Validatoren der Felder des Formulars gültig sind.
                          if (_formKey.currentState!.validate()) {
                            print(
                                "Formular ist gültig und kann verarbeitet werden");
                            //TODO if else
                            // {
                            //   if (.checked) {
                            //     print('The weather is amazing!');
                            //   } else if(inPortland && isSpring) {
                            //     print('Torrential downpour.');
                            //   } else if(inPortland && isAutumn) {
                            //     print('Torrential downpour.');
                            //   } else if(inPortland && isWinter) {
                            //     print('Torrential downpour.');
                            //   } else {
                            //     Navigator.push(context,
                            //       MaterialPageRoute(builder: (context) => formBahnrichter()),);
                            //   }
                            // };
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => formBahnrichter()));
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
class formVorfall_unerlUnterst extends StatefulWidget {
  const formVorfall_unerlUnterst({Key? key}) : super(key: key);

  @override
  State<formVorfall_unerlUnterst> createState() => _formVorfall_unerlUnterst();
}

/// This is the private State class that goes with formOrt.
class _formVorfall_unerlUnterst extends State<formVorfall_unerlUnterst> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                  MaterialPageRoute(builder: (context) => formVorfall()),
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
                                // Wenn alle Validatoren der Felder des Formulars gültig sind.
                                if (_formKey.currentState!.validate()) {
                                  print(
                                      "Formular ist gültig und kann verarbeitet werden");
                                  {
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => formBahnrichter()),);
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
class formVorfall_behinderung extends StatefulWidget {
  const formVorfall_behinderung({Key? key}) : super(key: key);

  @override
  State<formVorfall_behinderung> createState() => _formVorfall_behinderung();
}

/// This is the private State class that goes with formOrt.
class _formVorfall_behinderung extends State<formVorfall_behinderung> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            labelText: 'Start Nr.',
                            hintText: 'behinderte StNR',
                            border: OutlineInputBorder(),
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                        TextFormField(
                          maxLines: 5,
                          maxLength: 120,
                          decoration: InputDecoration(
                            hintText: 'kurze Erläuterung',
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
                                  MaterialPageRoute(builder: (context) => formVorfall()),
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
                                // Wenn alle Validatoren der Felder des Formulars gültig sind.
                                if (_formKey.currentState!.validate()) {
                                  print(
                                      "Formular ist gültig und kann verarbeitet werden");
                                  {
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => formBahnrichter()),);
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
class formVorfall_bahnVerlassen extends StatefulWidget {
  const formVorfall_bahnVerlassen({Key? key}) : super(key: key);

  @override
  State<formVorfall_bahnVerlassen> createState() => _formVorfall_bahnVerlassen();
}

/// This is the private State class that goes with formVorfall_bahnVerlassen.
class _formVorfall_bahnVerlassen extends State<formVorfall_bahnVerlassen> {
  SingingCharacter? _character = SingingCharacter.eigeneBahn;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        SizedBox(height: 30),
                        // TODO 2x Textfeld (number) für Länge bzw. Schritte
                        SizedBox(height: 30),
                        // TODO 1x Textfeld (number) für Länge
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
                                  MaterialPageRoute(builder: (context) => formVorfall()),
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
                                // Wenn alle Validatoren der Felder des Formulars gültig sind.
                                if (_formKey.currentState!.validate()) {
                                  print(
                                      "Formular ist gültig und kann verarbeitet werden");
                                  {
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => formBahnrichter()),);
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
class formVorfall_huerdenlaufHindernis extends StatefulWidget {
  const formVorfall_huerdenlaufHindernis({Key? key}) : super(key: key);

  @override
  State<formVorfall_huerdenlaufHindernis> createState() => _formVorfall_huerdenlaufHindernis();
}

/// This is the private State class that goes with formVorfall_huerdenlaufHindernis.
class _formVorfall_huerdenlaufHindernis extends State<formVorfall_huerdenlaufHindernis> {
  SingingCharacter? _character = SingingCharacter.hueNebenbahn;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        // TODO 1x Textfeld (number) für Nr.der Hürde/ Hindernis
                        SizedBox(height: 30),
                        // TODO Row mit 2x checkbox "Hand" und "mit dem Fuß"
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
                                  MaterialPageRoute(builder: (context) => formVorfall()),
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
                                // Wenn alle Validatoren der Felder des Formulars gültig sind.
                                if (_formKey.currentState!.validate()) {
                                  print(
                                      "Formular ist gültig und kann verarbeitet werden");
                                  {
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => formBahnrichter()),);
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
class formVorfall_sonstiges extends StatefulWidget {
  const formVorfall_sonstiges({Key? key}) : super(key: key);

  @override
  State<formVorfall_sonstiges> createState() => _formVorfall_sonstiges();
}

/// This is the private State class that goes with formVorfall_sonstiges.
class _formVorfall_sonstiges extends State<formVorfall_sonstiges> {
  SingingCharacter? _character = SingingCharacter.eigeneBahn;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                  MaterialPageRoute(builder: (context) => formVorfall()),
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
                                // Wenn alle Validatoren der Felder des Formulars gültig sind.
                                if (_formKey.currentState!.validate()) {
                                  print(
                                      "Formular ist gültig und kann verarbeitet werden");
                                  {
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => formBahnrichter()),);
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










class formBahnrichter extends StatefulWidget {
  const formBahnrichter({Key? key}) : super(key: key);

  @override
  State<formBahnrichter> createState() => _formBahnrichter();
}

/// This is the private State class that goes with formBahnrichter.
class _formBahnrichter extends State<formBahnrichter> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            MaterialPageRoute(builder: (context) => formVorfall()),
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
                          // Wenn alle Validatoren der Felder des Formulars gültig sind.
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
