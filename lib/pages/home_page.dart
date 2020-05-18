import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frequencypay/pages/settings_page.dart';

import '../services/firebase_authentication.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  final String uid; //include this

  HomePage({Key key, this.uid}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseUser currentUser;
  final Auth _auth=Auth(); // instance to correctly sign out

  @override
  initState() {
    this.getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome!"),
        backgroundColor: Colors.blue,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.settings, color: Colors.white,),
            label: Text("Settings", style: TextStyle(color:Colors.white)),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
            },
          ),

          FlatButton.icon(
            icon: Icon(Icons.person,color: Colors.white,),
            label: Text("Log out",style: TextStyle(color: Colors.white),),
            onPressed: () async {
              await _auth.signOut();

            },
          ),

        ],
      ),

      body: Column(
        children: <Widget>[
          Text(""),
        ],
      ),
    );
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }
}
