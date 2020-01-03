import 'package:flutter/material.dart';
import 'package:frequencypay/pages/home_page.dart';
import 'package:frequencypay/pages/login_page.dart';
import 'package:frequencypay/pages/splash_page.dart';
import 'package:frequencypay/pages/login_signup_page.dart';
import 'package:frequencypay/pages/task.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: SplashPage(),
        routes: <String, WidgetBuilder>{
          '/task': (BuildContext context) => TaskPage(title: 'Task'),
          '/home': (BuildContext context) => HomePage(title: 'Home'),
          '/login': (BuildContext context) => LoginPage(),
          '/register': (BuildContext context) => RegisterPage(),
        });
  }
}