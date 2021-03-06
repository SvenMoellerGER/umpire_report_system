import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main.dart';

enum SingingCharacter { zielgerade, gegengerade, kurvenachdemstart, kurvevordemziel,
  unerlUnterst, behinderung, bahnVerlassen, huerdenlauf, hindernis, sonstigesBahn, eigeneBahn,
  bordkante, bahnVorUebergangslinie, bahnVerlassenGruppenstart,
  hueNebenbahn, hueUeberlaufen, hueNichtRegelgerechtUeberlaufen, hueUmgestossen, hiNichtRegelgerechtUeberlaufen }

class formBahnOrt extends StatefulWidget {
  const formBahnOrt({Key? key}) : super(key: key);

  @override
  State<formBahnOrt> createState() => _formBahnOrt();
}

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
                      hintText: 'ggf. n??here Angaben',
                      border: OutlineInputBorder(),
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
            print("Formular ist g??ltig und kann verarbeitet werden");
            {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => formBahnAthlet()),
              );
            };
          } else {
            print("Formular ist nicht g??ltig");
          }},
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.arrow_forward_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                  title: const Text('L??ufer'),
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
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'auf Bahn:',
                      ),
                      SizedBox(width: 20,),
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
                          "Bahn eingeben",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _chosenValue = value!;
                          });
                        },
                      ),
                    ]
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            print("Formular ist g??ltig und kann verarbeitet werden");
            {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => formBahnVorfall()),
              );
            };
          } else {
            print("Formular ist nicht g??ltig");
          }},
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.arrow_forward_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                  title: const Text('unerlaubte Unterst??tzung'),
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
                  title: const Text('H??rdenlauf/Hindernis'),
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
                    value: SingingCharacter.sonstigesBahn,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            print(
                "Formular ist g??ltig und kann verarbeitet werden");
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
              } else if(_character == SingingCharacter.sonstigesBahn) {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => formBahnVorfall_sonstiges()),);
              } else {
                print("### Hier ist etwas schief gelaufen!");
              }
            }
          } else {
            print("Formular ist nicht g??ltig");
          }},
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.arrow_forward_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

// +++++ Auswahl des Versto??es +++++

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
        title: Text('Vorfall: unerlaubte Unterst??tzung'),
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
                    hintText: 'kurze Erl??uterung',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Bitte den Sachverhalt erl??utern';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            print("Formular ist g??ltig und kann verarbeitet werden");
            {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => formNameKari()),
              );
            };
          } else {
            print("Formular ist nicht g??ltig");
          }},
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.arrow_forward_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                    hintText: 'kurze Erl??uterung',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Bitte den Sachverhalt erl??utern';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            print("Formular ist g??ltig und kann verarbeitet werden");
            {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => formNameKari()),
              );
            };
          } else {
            print("Formular ist nicht g??ltig");
          }},
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.arrow_forward_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                  title: const Text('hat eigene Bahn vor der ??bergangslinie verlassen '
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
                // TODO Row mit 2x checkbox ("innen" und "au??en verlassen")
                //SizedBox(height: 30),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'L??nge in [m]',
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
                // TODO 1x Textfeld (number) f??r L??nge
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            print("Formular ist g??ltig und kann verarbeitet werden");
            {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => formNameKari()),
              );
            };
          } else {
            print("Formular ist nicht g??ltig");
          }},
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.arrow_forward_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
        title: Text('Vorfall: H??rdenlauf/Hindernis'),
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
                  title: const Text('hat H??rde in der Nebenbahn umgesto??en'),
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
                  title: const Text('hat H??rde nicht ??berlaufen'),
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
                  title: const Text('hat H??rde nicht regelgerecht ??berlaufen'),
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
                  title: const Text('hat H??rde absichtlich umgesto??en'),
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
                  title: const Text('hat Hindernis nicht regelgerecht ??berlaufen'),
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
                    labelText: 'H??rde/Hindernis Nr.',
                    hintText: 'immer vom Start aus gez??hlt',
                    border: OutlineInputBorder(),
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Bitte die Nr. der H??rde eingeben';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                // TODO Row mit 2x checkbox "Hand" und "mit dem Fu??"
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            print("Formular ist g??ltig und kann verarbeitet werden");
            {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => formNameKari()),
              );
            };
          } else {
            print("Formular ist nicht g??ltig");
          }},
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.arrow_forward_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                  title: const Text('hat nicht zul??ssige Markierungen angebracht'),
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
                    hintText: 'kurze Erl??uterung',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Bitte den Sachverhalt erl??utern';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            print("Formular ist g??ltig und kann verarbeitet werden");
            {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => formNameKari()),
              );
            };
          } else {
            print("Formular ist nicht g??ltig");
          }},
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.arrow_forward_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}