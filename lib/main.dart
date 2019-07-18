import 'dart:async';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

enum SingingCharacter { lafayette, jefferson }

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Formulário',
      home: MyHomePage(title: 'Flutter Demo Formulário'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt'), // portugues
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectedDate = DateTime.now();
  TextEditingController dataCampo = TextEditingController();
  bool recebeMail = false;
  bool rock = false;
  bool funk = false;
  bool sertanejo = false;
  String _genero = "M";
  bool _luzes=false;
  bool _alarme=false;
  double _valorSlider=1;
  List<String> _colors = <String>['red', 'green', 'blue', 'orange'];
  String _color = 'red';






  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale("pt"),
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dataCampo.text = selectedDate.day.toString() +
            "/" +
            selectedDate.month.toString() +
            "/" +
            selectedDate.year.toString();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    hintText: 'Nome do Produto',
                    labelText: 'Nome',
                    border: OutlineInputBorder()),
              ),
          Card(

            elevation: 4.00,
            semanticContainer: true,
            child: Padding(
                padding: EdgeInsets.all(10),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: true,

                  elevation: 20,
                  hint: Text("Escolha  Acor"),
                  value: _color,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      _color = newValue;
                    });
                  },
                  items: _colors.map((String value) {
                    return new DropdownMenuItem(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                ),
              ),
            )
          ),


              Row(
                children: <Widget>[
                  Slider(
                      value: _valorSlider,
                      label: "Valor",
                      activeColor: Colors.redAccent,
                      max: 100,
                      min: 1,
                      inactiveColor: Colors.blue,
                      divisions: 100,

                      onChanged: (double novoValor){
                        setState(() {
                          _valorSlider = novoValor;
                        });
                      }
                  ),
                  Text("Valor Slider : "+_valorSlider.toStringAsFixed(0))
                ],
              ),

              SwitchListTile(
                title: const Text('Adicionar Alarme'),
                value: _alarme,
                onChanged: (bool value) { setState(() { _alarme = value; }); },
                secondary: const Icon(Icons.add_alarm),
              ),
              SwitchListTile(
                title: const Text('Ligar Luzes'),
                value: _luzes,
                onChanged: (bool value) { setState(() { _luzes = value; }); },
                secondary: const Icon(Icons.lightbulb_outline),
              ),

              Row(
                children: <Widget>[
                  Checkbox(
                      value: recebeMail,
                      onChanged: (bool novoValor) {
                        setState(() {
                          recebeMail=novoValor;
                        });

                      }
                  ),
                  Text("Recebe E-Mail ?"),

                ],
              ),
              Text("Gosto Musical"),

              CheckboxListTile(

                title: Text("Rock"),
                value: rock,
                onChanged: (bool value) {
                  setState(() {
                    rock = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("Funk"),
                value: funk,
                onChanged: (bool value) {
                  setState(() {
                    funk = value;
                  });
                },
              ),
              TextField(
                controller: dataCampo,
                keyboardType: TextInputType.datetime,
                onTap: () {
                  _selectDate(context);
                },
                decoration: const InputDecoration(
                  icon: const Icon(Icons.calendar_today),
                  hintText: 'Data de Nascimento',
                  labelText: 'Data',
                ),
              ),
              Column(
                children: <Widget>[

                  Text("Gênero Sexual"),

                  ListTile(
                    title: const Text('Masculino'),
                    leading: Radio(
                      value: "M",
                      groupValue: _genero,
                      onChanged: (String value) {
                        setState(() { _genero = value; });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Feminino'),
                    leading: Radio(
                      value: "F",
                      groupValue: _genero,
                      onChanged: (String value) {
                        setState(() { _genero = value; });
                      },
                    ),
                  ),
                ],
              ),

              Text("${selectedDate.toLocal()}"),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                onPressed: () => _selectDate(context),
                child: Text('Select date'),
              ),
              Text("Rock : "+rock.toString() + "\nFunk : " + funk.toString() + "\nGênero :"+_genero)
            ],
          ),
        ));
  }
}
