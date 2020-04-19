import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frequencypay/pages/contract_specification.dart';
import 'package:frequencypay/pages/home%20screens/home_pages_group.dart';
import 'package:frequencypay/services/PlaidRepo.dart';
import 'package:webview_flutter/webview_flutter.dart';
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
    bool plaidSandbox = true;
    String clientID = "5cb68305fede9b00136aebb1";
    String secret = "54621c4436011f708c7916587c6fa8";

    Configuration configuration = Configuration(
        plaidPublicKey: '5e8f6927464aa029be1a265eb95b79',
        plaidBaseUrl: 'https://cdn.plaid.com/link/v2/stable/link.html',
        plaidEnvironment: plaidSandbox ? 'sandbox' : 'production',
        environmentPlaidPathAccessToken:
        'https://sandbox.plaid.com/item/public_token/exchange',
        environmentPlaidPathStripeToken:
        'https://sandbox.plaid.com/processor/stripe/bank_account_token/create',
        plaidClientId: clientID,
        secret: plaidSandbox ? secret : '',
        clientName: 'ClientName',
        webhook: 'http://requestb.in',
        product: 'auth',
        selectAccount: 'true'
    );

    PlaidLink plaidLink = PlaidLink(configuration);
    plaidLink.launch(context, (Result result) {
      getAccessToken(clientID, secret, result.token);
    }, stripeToken: false);
  }

  getAccessToken( clientID,  secretKey, publicToken){
  PlaidRepo plaid = PlaidRepo();
  plaid.signInWithCredentials(clientID, secretKey, publicToken);

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
        MaterialButton(
          child: Text("Plaid View"),
          onPressed: showPlaidView,
        ),
        MaterialButton(
            child: Text("Contract Creation"),
            onPressed: () => {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ContractSpecification()))
            }),
        MaterialButton(
          child: Text("New Home Screens"),
          onPressed: () => {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePagesGroup()))},
        )
      ],),
    );
  }
}