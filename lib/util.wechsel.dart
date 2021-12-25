import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main.dart';

enum SingingCharacter { staffelstab, behinderung, markierung, sonstigesWechsel }

class formWechselVorfall extends StatefulWidget {
  const formWechselVorfall({Key? key}) : super(key: key);

  @override
  State<formWechselVorfall> createState() => _formWechselVorfall();
}

/// This is the private State class that goes with formWechselVorfall.
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
                  MaterialPageRoute(builder: (context) => formWechselVorfall_unerlUnterst()),);
              } else if(_character == SingingCharacter.behinderung) {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => formWechselVorfall_behinderung()),);
              } else if(_character == SingingCharacter.bahnVerlassen) {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => formWechselVorfall_bahnVerlassen()),);
              } else if(_character == SingingCharacter.huerdenlauf) {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => formWechselVorfall_huerdenlaufHindernis()),);
              } else if(_character == SingingCharacter.sonstiges) {
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

