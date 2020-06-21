import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frequencypay/pages/authenticate/wrapper.dart';
import 'package:frequencypay/routes.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'services/firebase_authentication.dart';

void main() => {
  runApp(MyApp()),
  print("test")};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value( // New -> Provider Package
      value: Auth().user, // New -> listens to stream for authentication changes
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          routes: routes,
      ),
    );
  }
}