import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Umpire Report System',
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start'),
      ),
      // body: Center(
      //   child: ElevatedButton(
      //     child: const Text('Open route'),
      //     onPressed: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => const neuerVorfall()),
      //       );
      //     },
      //   ),
      // ),
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

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // theme: ThemeData(
//       //   primarySwatch: Colors.blue,
//       ),
//       //home: formAllg(title: 'Flutter Formular'),
//     );
//   }
// }

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

enum SingingCharacter { zielgerade, gegengerade, kurvenachdemstart, kurvevordemziel }

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
                ],
              )
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
