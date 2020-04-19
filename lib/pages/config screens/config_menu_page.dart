import 'package:flutter/material.dart';
import 'package:frequencypay/pages/config%20screens/config_banking_page.dart';

import 'config_account_page.dart';
import 'config_billing_page.dart';

class ConfigMenu extends StatefulWidget {
  @override
  _ConfigMenuState createState() => _ConfigMenuState();
}

class _ConfigMenuState extends State<ConfigMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Configuration"),
          backgroundColor: Colors.green,
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    children: <Widget>[
                      accountInfoText(),
                      accountInfoUpdateButton(),
                      billingInfoText(),
                      billingInfoUpdateButton(),
                      bankingInfoText(),
                      bankingInfoUpdateButton(),
                    ],
                  ),
                ))));
  }

  Widget accountInfoText() {
    return TextField(
      decoration: InputDecoration(
        labelText: '''
       First Name:
       Last Name:
       Email Address:''',
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(0.0),
          ),
          borderSide: new BorderSide(
            color: Colors.green,
            width: 1.0,
          ),
        ),
      ),
    );
  }

  Widget accountInfoUpdateButton() {
    return RaisedButton(
      child: Text("Update"),
      color: Colors.green,
      textColor: Colors.white,
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ConfigAccount()));
      },
    );
  }

  Widget billingInfoText() {
    return TextField(
      decoration: InputDecoration(
        labelText: '''
       Address: <full address>
       Phone Number:''',
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(0.0),
          ),
          borderSide: new BorderSide(
            color: Colors.green,
            width: 1.0,
          ),
        ),
      ),
    );
  }

  Widget billingInfoUpdateButton() {
    return RaisedButton(
      child: Text("Update"),
      color: Colors.green,
      textColor: Colors.white,
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ConfigBilling()));
      },
    );
  }

  Widget bankingInfoText() {
    return TextField(
      decoration: InputDecoration(
        labelText: '''
       Bank: <bank name>''',
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(0.0),
          ),
          borderSide: new BorderSide(
            color: Colors.green,
            width: 1.0,
          ),
        ),
      ),
    );
  }

  Widget bankingInfoUpdateButton() {
    return RaisedButton(
      child: Text("Update"),
      color: Colors.green,
      textColor: Colors.white,
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ConfigBanking()));
      },
    );
  }
}
