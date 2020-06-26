import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frequencypay/pages/authenticate/wrapper.dart';
import 'package:frequencypay/routes.dart';
import 'package:frequencypay/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'vaulted_pages/firebase_authentication.dart';
import 'package:frequencypay/models/user_model.dart';

void main() => {
  runApp(MyApp()),
  print("test")};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value( // New -> Provider Package
      value: AuthService().user, // New -> listens to stream for authentication changes
      child: MaterialApp(
          title: 'Bank Of',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),

          routes: routes,
      ),
    );
  }
}