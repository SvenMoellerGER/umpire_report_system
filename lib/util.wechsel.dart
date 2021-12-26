import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main.dart';

enum SingingCharacter { staffelstab, behinderung, markierung, sonstigesWechsel, staffelstabNichtInHand,
  staffelstabZugeworfen, staffelstabAndererAufgehoben, staffelstabVorWechselraum, staffelstabNachWechselraum,
  behinderungAufheben, behinderungWarteposition, behinderungAllgemein, markierungAnzahl,
  markierungDimension, sonstigesHandschuhe, sonstigesAufhebenAbgekuerzt, sonstigesAndererStaffelstab,
  sonstigesVorWechselraumAngelaufen, sonstigesWarteposition, sonstigesWeitereBeanstandungen}

class formWechselVorfall extends StatefulWidget {
  const formWechselVorfall({Key? key}) : super(key: key);

  @override
  State<formWechselVorfall> createState() => _formWechselVorfall();
}

class _formWechselVorfall extends State<formWechselVorfall> {
  SingingCharacter? _character = SingingCharacter.staffelstab;
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
                  title: const Text('Staffelstab'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.staffelstab,
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
                  title: const Text('Markierung'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.markierung,
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
                    value: SingingCharacter.sonstigesWechsel,
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
                "Formular ist gültig und kann verarbeitet werden");
            {
              print('value ' + _character.toString());
              if (_character == SingingCharacter.staffelstab) {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => formWechselVorfall_staffelstab()),);
              } else if(_character == SingingCharacter.behinderung) {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => formWechselVorfall_behinderung()),);
              } else if(_character == SingingCharacter.markierung) {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => formWechselVorfall_markierung()),);
              } else if(_character == SingingCharacter.sonstigesWechsel) {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => formWechselVorfall_sonstiges()),);
              } else {
                print("### Hier ist etwas schief gelaufen!");
              }
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

class formWechselVorfall_staffelstab extends StatefulWidget {
  const formWechselVorfall_staffelstab({Key? key}) : super(key: key);

  @override
  State<formWechselVorfall_staffelstab> createState() => _formWechselVorfall_staffelstab();
}

class _formWechselVorfall_staffelstab extends State<formWechselVorfall_staffelstab> {
  SingingCharacter? _character = SingingCharacter.staffelstabNichtInHand;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vorfall: Staffelstab'),
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
                  title: const Text('nicht während des gesamten Laufs in der Hand gehalten'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.staffelstabNichtInHand,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('als ankommender Läufer dem ablaufenden Läufer zugeworfen'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.staffelstabZugeworfen,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('nicht als der Läufer, der ihn fallen ließ, aufgehoben'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.staffelstabAndererAufgehoben,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('vor Beginn des Wechselraums angenommen'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.staffelstabVorWechselraum,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('nach Ende des Wechselraums übernommen'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.staffelstabNachWechselraum,
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
                    labelText: 'Länge in [m]',
                    border: OutlineInputBorder(),
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  // TODO validator implementieren
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
                MaterialPageRoute(builder: (context) => formNameKari()),
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

class formWechselVorfall_behinderung extends StatefulWidget {
  const formWechselVorfall_behinderung({Key? key}) : super(key: key);

  @override
  State<formWechselVorfall_behinderung> createState() => _formWechselVorfall_behinderung();
}

class _formWechselVorfall_behinderung extends State<formWechselVorfall_behinderung> {
  SingingCharacter? _character = SingingCharacter.behinderungAufheben;
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
                ListTile(
                  title: const Text('hat einen Läufer beim Aufheben des Staffelstabs behindert'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.behinderungAufheben,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('hat einen Läufer in der Warteposition durch Rempeln, Sperren oder ähmlichem behindert'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.behinderungWarteposition,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('hat einen Läufer durch Rempeln, Sperren oder ähmlichem behindert'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.behinderungAllgemein,
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
                MaterialPageRoute(builder: (context) => formNameKari()),
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

class formWechselVorfall_markierung extends StatefulWidget {
  const formWechselVorfall_markierung({Key? key}) : super(key: key);

  @override
  State<formWechselVorfall_markierung> createState() => _formWechselVorfall_markierung();
}

class _formWechselVorfall_markierung extends State<formWechselVorfall_markierung> {
  SingingCharacter? _character = SingingCharacter.behinderungAufheben;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vorfall: Markierung'),
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
                  title: const Text('hat mehr als eine Markierung angebracht'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.markierungAnzahl,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('hat eine größere Markierung als die zulässige angebracht'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.markierungDimension,
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
                    labelText: 'Anzahl der Markierungen:',
                    hintText: 'Anzahl der Markierungen',
                    border: OutlineInputBorder(),
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'Bitte eine Startnummer eingeben';
                  //   }
                  //   return null;
                  // },
                ),
                SizedBox(height: 30,),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Länge in [cm]:',
                          hintText: 'Länge in [cm]',
                          border: OutlineInputBorder(),
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return 'Bitte eine Startnummer eingeben';
                        //   }
                        //   return null;
                        // },
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Breite in [cm]:',
                          hintText: 'Breite in [cm]',
                          border: OutlineInputBorder(),
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return 'Bitte eine Startnummer eingeben';
                        //   }
                        //   return null;
                        // },
                      ),
                    ]
                ),
                SizedBox(height: 30),
                Text('zulässig 40 cm x 5 cm')
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
                MaterialPageRoute(builder: (context) => formNameKari()),
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

class formWechselVorfall_sonstiges extends StatefulWidget {
  const formWechselVorfall_sonstiges({Key? key}) : super(key: key);

  @override
  State<formWechselVorfall_sonstiges> createState() => _formWechselVorfall_sonstiges();
}

class _formWechselVorfall_sonstiges extends State<formWechselVorfall_sonstiges> {
  SingingCharacter? _character = SingingCharacter.sonstigesHandschuhe;
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
                  title: const Text('hat Handschuhe getragen oder eine unerlaubte Substanz an den Händen aufgetragen'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.sonstigesHandschuhe,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('hat die Laufstrecke zum Aufheben des Staffelstabs oder danach abgekürzt'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.sonstigesAufhebenAbgekuerzt,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('hat den Staffelstab einer anderen Mannschaft genommen oder aufgehoben'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.sonstigesAndererStaffelstab,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('ist vor dem Wechselraum angelaufen'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.sonstigesVorWechselraumAngelaufen,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('hat die Warteposition nicht so eingehalten, wie sie der Reihenfolge entsprach, '
                      'die das ankommende Mannschaftsmitglied nach 200m (100m Halle) der Teilstrecke erlaufen hatte'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.sonstigesWarteposition,
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
                    value: SingingCharacter.sonstigesWeitereBeanstandungen,
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
                MaterialPageRoute(builder: (context) => formNameKari()),
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

