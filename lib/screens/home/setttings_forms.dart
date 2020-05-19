import "package:flutter/material.dart";
import "../../shared/constants.dart";

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ["0", "1", "2", "3", "4"];

  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            "Update your brew settings.",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: "Name"),
            validator: (value) {
              value.isEmpty ? "Please enter a name" : null;
            },
            onChanged: (value) {
              setState(() {
                _currentName = value;
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          DropdownButtonFormField(
              decoration: textInputDecoration,
              value: _currentSugars ?? 0,
              items: sugars.map((sugar) {
                return DropdownMenuItem(
                  child: Text("$sugar sugars"),
                  value: sugar,
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _currentSugars = value;
                });
              }),
          SizedBox(height: 20),
          Slider(
            min: 100,
            max: 900,
            activeColor: Colors.brown[_currentStrength],
            inactiveColor: Colors.brown[_currentStrength],
            value: (_currentStrength ?? 100).toDouble(),
            divisions: 8,
            onChanged: (value) {
              setState(() {
                _currentStrength = value.round();
              });
            },
          ),
          SizedBox(height: 20),
          RaisedButton(
            onPressed: () async {
              print(_currentName);
              print(_currentSugars);
              print(_currentStrength);
            },
            color: Colors.pink[400],
            child: Text(
              "Update",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
