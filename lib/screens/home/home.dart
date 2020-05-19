import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "../../services/auth.dart";
import "package:provider/provider.dart";
import "../../services/database.dart";

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
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
              label: Text("Sign out"),
            )
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
