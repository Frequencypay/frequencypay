import 'package:flutter/material.dart';
import 'package:frequencypay/pages/login/login_page.dart';
import 'package:frequencypay/pages/login/registration_page.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn=true;
  void toggleView(){
    setState(() => showSignIn=!showSignIn); // reverse
  }
  @override
  Widget build(BuildContext context) {
   if(showSignIn==true){
     return LoginPage(toggleView:toggleView);
   }
   else{
     return RegisterPage(toggleView:toggleView);
   }
  }
}
