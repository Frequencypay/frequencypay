import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frequencypay/services/plaid_token_repo.dart';
import 'package:frequencypay/plaid/plaid_link_network.dart';
import 'package:frequencypay/pages/settings_page.dart';



class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.uid}) : super(key: key);
  final String title;
  final String uid; //include this

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseUser currentUser;

  @override
  initState() {
    this.getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

  showPlaidView(){

    PlaidLink plaidLink = PlaidLink();
    plaidLink.launch(context, (Result result) {
      getAccessToken(result.token);
    }, stripeToken: false);
  }

  getAccessToken(publicToken){
    PlaidTokenRepo plaid = PlaidTokenRepo();
    plaid.publicTokenExchangeRequest(publicToken);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsPage()));
            },
          ),
        ],
      ),
      body: Column(children: <Widget>[
        MaterialButton(child: Text("Button"), onPressed: showPlaidView,)
      ],),
    );
  }
}