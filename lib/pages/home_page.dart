import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/firebase_authentication.dart';

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


      body:
    );
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }
}
