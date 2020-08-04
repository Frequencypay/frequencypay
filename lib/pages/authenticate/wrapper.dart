//wrapper listens for auth changes
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frequencypay/services/message_handler.dart';
import 'package:frequencypay/vaulted_pages/authenticate.dart';
import 'package:frequencypay/pages/authenticate/sign_in_page.dart';
import 'package:frequencypay/pages/landing_page.dart';
import 'package:frequencypay/pages/plaid_link_splash_screen.dart';
import 'package:frequencypay/pages/wake_up_auth.dart';
import 'package:provider/provider.dart';
import '../home_page.dart';
import 'package:frequencypay/models/user_model.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user= Provider.of<User>(context);

    //return either Home or Authenticate Widget
    if(user==null){ // no current user signed in -> protect home screen
      return SignIn();
    }
    else{ // we have a user logged in
      return MessageHandler();
    }
  }
}
