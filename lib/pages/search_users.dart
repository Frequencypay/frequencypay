import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/pages/loan_request_page.dart';
import 'package:frequencypay/services/firebase_auth_service.dart';
import 'package:frequencypay/services/firestore_db_service.dart';

class SearchData extends StatefulWidget {
  @override
  _SearchDataState createState() => _SearchDataState();
}

class _SearchDataState extends State<SearchData> {
  FirebaseUser currentUser;
  final AuthService _auth=AuthService();


  TextEditingController searchInputController;
  String searchString;

  @override
  initState() {
    searchInputController = new TextEditingController();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    FirestoreService dbInstance=FirestoreService(uid: currentUser.uid);
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),

      body: SafeArea(
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchString = value.toLowerCase();
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
  void getCurrentUser() async {
    currentUser = await _auth.getCurrentUser();
  }


}





