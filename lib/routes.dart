import 'package:flutter/material.dart';
import 'package:frequencypay/pages/home_page.dart';
import 'package:frequencypay/pages/login_page.dart';
import 'package:frequencypay/pages/login_signup_page.dart';
import 'package:frequencypay/pages/task.dart';

final routes = {
  '/task': (BuildContext context) => new TaskPage(title: 'Task'),
  '/home': (BuildContext context) => new HomePage(title: 'Home',),
  '/login': (BuildContext context) => new LoginPage(),
  '/register': (BuildContext context) => new RegisterPage(),
};