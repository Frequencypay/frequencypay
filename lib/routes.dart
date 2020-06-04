import 'package:flutter/material.dart';
import 'package:frequencypay/pages/login/forgot_password_page.dart';
import 'package:frequencypay/pages/home_page.dart';
import 'package:frequencypay/pages/login/login_page.dart';
import 'package:frequencypay/pages/login/registration_page.dart';
import 'package:frequencypay/pages/login/welcome_page.dart';

final routes = {
  '/home': (BuildContext context) => new HomePage(),
  '/login': (BuildContext context) => new LoginPage(),
  '/register': (BuildContext context) => new RegisterPage(),
  '/forgotPassword': (BuildContext context) => new ForgotPasswordPage(),
  '/welcomeScreen': (BuildContext context) => new WelcomeScreen(),
};