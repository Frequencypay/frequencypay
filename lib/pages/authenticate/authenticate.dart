import 'package:flutter/material.dart';
import 'package:frequencypay/pages/authenticate/register.dart';
import 'package:frequencypay/pages/authenticate/sign_in.dart';

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
     return SignIn(toggleView:toggleView);
   }
   else{
     return Register(toggleView:toggleView);
   }
  }
}
