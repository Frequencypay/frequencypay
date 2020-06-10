import 'package:flutter/material.dart';
import 'package:frequencypay/pages/authenticate/authenticate.dart';
import 'package:frequencypay/pages/authenticate/wrapper.dart';
import 'package:frequencypay/pages/loan_request_page.dart';
import 'package:frequencypay/pages/login/forgot_password_page.dart';
import 'package:frequencypay/pages/home_page.dart';
import 'package:frequencypay/pages/login/login_page.dart';
import 'package:frequencypay/pages/login/registration_page.dart';
import 'package:frequencypay/pages/login/welcome_page.dart';
import 'package:frequencypay/pages/search_results.dart';
import 'package:frequencypay/pages/search_users.dart';

final routes = {
  '/': (BuildContext context) => LoginPage(),
  '/home': (BuildContext context) => new HomePage(),
  '/login': (BuildContext context) => new LoginPage(),
  '/register': (BuildContext context) => new RegisterPage(),
  '/forgotPassword': (BuildContext context) => new ForgotPasswordPage(),
  '/welcomeScreen': (BuildContext context) => new WelcomeScreen(),
  '/search_users':(context)=>SearchData(),
  '/search_results':(context)=>SearchResults(),
  '/loan_request_page':(context)=>LoanRequest(),
};