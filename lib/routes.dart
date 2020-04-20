import 'package:flutter/material.dart';
import 'package:frequencypay/pages/forgot_password_page.dart';
import 'package:frequencypay/pages/home_page.dart';
import 'package:frequencypay/pages/login_page.dart';
import 'package:frequencypay/pages/registration_page.dart';
import 'package:frequencypay/pages/welcome_page.dart';

final routes = {
  '/home': (BuildContext context) => new HomePage(),
  '/login': (BuildContext context) => new LoginPage(),
  '/register': (BuildContext context) => new RegisterPage(),
  '/forgotPassword': (BuildContext context) => new ForgotPasswordPage(),
  '/welcomeScreen': (BuildContext context) => new WelcomeScreen(),
};