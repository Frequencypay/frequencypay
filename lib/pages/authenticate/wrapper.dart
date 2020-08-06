//wrapper listens for auth changes
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frequencypay/pages/authenticate/authenticate.dart';
import 'package:frequencypay/pages/plaid_link_splash_screen.dart';
import 'package:provider/provider.dart';
import '../home_page.dart';
import 'package:frequencypay/models/user_model.dart';

class Wrapper extends StatelessWidget {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    String key;
    final user = Provider.of<User>(context);

    _storage.read(key: 'access_token').then((value) => key = value);

    //return either Home or Authenticate Widget
    if (user == null) {
      // no current user signed in -> protect home screen
      return Authenticate();
    }
    if (user != null && key == null && key != "0") {
      // we have a user logged in
      return PlaidLinkSplashScreen();
    } else {
      return HomePage();
    }
  }
}
