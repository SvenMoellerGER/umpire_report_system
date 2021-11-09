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
                            // TODO nächste Seite einfügen
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