import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frequencypay/pages/authenticate/authenticate.dart';
import 'package:frequencypay/widgets/plaid_token_widget.dart';
import 'package:provider/provider.dart';
import '../home_page.dart';
import 'package:frequencypay/models/user_model.dart';

//wrapper listens for auth changes
class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  String hasAccessToken;

  Future retrieveToken() async {
    FlutterSecureStorage _storage = FlutterSecureStorage();
    String token = await _storage.read(key: 'access_token');
    setState(() {
      hasAccessToken = token;
    });
    return _storage.read(key: 'access_token');
  }

  @override
  void initState() {
    super.initState();
    retrieveToken();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //return either Home or Authenticate Widget
    if (user == null) {
      // no current user signed in -> protect home screen
      return Authenticate();
    } else {
      if (hasAccessToken == null)
        // we have a user logged in
        return PlaidToken();
      else
        return HomePage();
    }
  }
}
