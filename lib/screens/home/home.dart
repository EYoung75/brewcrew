import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/setttings_forms.dart';
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../../services/auth.dart";
import "package:provider/provider.dart";
import "../../services/database.dart";

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: 60,
                vertical: 20,
              ),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.brown[400],
          title: Text("Brew Crew"),
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text("Log out"),
            ),
            FlatButton.icon(
              onPressed: () => _showSettingsPanel(),
              icon: Icon(Icons.settings),
              label: Text("Settings"),
            )
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
