//wrapper listens for auth changes
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frequencypay/pages/authenticate/authenticate.dart';
import 'package:frequencypay/pages/authenticate/wakeup_auth.dart';
import 'package:frequencypay/pages/landing_page.dart';
import 'package:provider/provider.dart';
import '../home_page.dart';
import 'package:frequencypay/models/user_model.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user= Provider.of<User>(context);

    //return either Home or Authenticate Widget
    if(user==null){ // no current user signed in -> protect home screen
      return Authenticate();
    }
    else{ // we have a user logged in (i.e remembered)
      return HomePage();
    }
  }
}

