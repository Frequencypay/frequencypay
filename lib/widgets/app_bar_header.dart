
import 'package:flutter/material.dart';

Widget CustomAppBar(String pageTitle, BuildContext context){
  const Color blueHighlight = const Color(0xFF3665FF);

  return AppBar(
    title: RichText(
      text: new TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: new TextStyle(
          fontSize: 25.0,
          color: Colors.black45,
        ),
        children: <TextSpan>[
          new TextSpan(text: 'Your '),
          new TextSpan(
              text: pageTitle,
              style: new TextStyle(
                  fontWeight: FontWeight.bold, color: blueHighlight)),
        ],
      ),
    ),
    centerTitle: false,
    backgroundColor: Colors.white10,
    elevation: 0,
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.person),
        onPressed: () async {
          //await _auth.signOut();
//                  getOut();
//          Navigator.pushReplacementNamed(context, '/sign_in');
        },
        color: Colors.black45,
      )
    ],
  );
}