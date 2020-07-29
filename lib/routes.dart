import 'package:flutter/material.dart';
import 'package:frequencypay/pages/authenticate/register.dart';
import 'package:frequencypay/pages/authenticate/sign_in_page.dart';
import 'package:frequencypay/pages/loan_request_page.dart';
import 'package:frequencypay/pages/authenticate/forgot_password_page.dart';
import 'package:frequencypay/pages/home_page.dart';
import 'package:frequencypay/pages/profile_page.dart';
import 'package:frequencypay/pages/search_users.dart';
import 'package:frequencypay/pages/contract_details.dart';
import 'package:frequencypay/pages/user_contracts_page.dart';


final routes = {
//  '/': (BuildContext context) => Wrapper(),
  '/home': (BuildContext context) => new HomePage(),
  '/sign_in': (BuildContext context) => new SignIn(),
  '/register': (BuildContext context) => new Register(),
  '/forgotPassword': (BuildContext context) => new ForgotPasswordPage(),
  '/search_users':(context)=>SearchData(),
  '/loan_request_page':(context)=>LoanRequest(),
  '/user_contracts':(context)=>new UserContractsPage(),
  '/contract_details':(context)=>new ContractDetails(),
  '/profile_page':(context)=> new ProfileScreen()
};