import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frequencypay/plaid/models/plaid_public_token_exchange_response_model.dart';
import 'package:frequencypay/plaid/plaid_link_webview.dart';
import 'package:frequencypay/services/plaid_token_repo.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Payday Information'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubPage()),
                );
              },
            ),
            ListTile(
              title: Text('Emergency Contact'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubPage()),
                );
              },
            ),
            ListTile(
              title: Text('Bill Services'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubPage()),
                );
              },
            ),
            ListTile(
              title: Text('Banking Information'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubPage()),
                );
              },
            ),
            ListTile(
              title: Text('Settings'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubPage()),
                );
              },
            ),
            ListTile(
              title: Text('Connect to Plaid'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () => showPlaidView(context),
            ),
            FlatButton(
              child: Text("Log Out"),
              textColor: Colors.black,
              onPressed: () {
                FirebaseAuth.instance
                    .signOut()
                    .then((result) =>
                    Navigator.pushReplacementNamed(context, "/login"))
                    .catchError((err) => print(err));
              },
            ),
          ],
        )
    );
  }

  showPlaidView(var context) {
    PlaidLink plaidLink = PlaidLink();
    plaidLink.launch(context, (Result result) {
      getAccessToken(result.token);
    }, stripeToken: false);
  }

  getAccessToken(publicToken) {
    PlaidPublicTokenExchangeResponseModel tokenExchangeResponseModel;
    String accessToken;
    PlaidTokenRepo plaid = PlaidTokenRepo();
    plaid.publicTokenExchangeRequest(publicToken).then((tokenExchangeResponseModel){
      accessToken = tokenExchangeResponseModel.access_token;

    });

  }

}

class SubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Place Holder"),
      ),
      body: Center(
        child: FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }


}