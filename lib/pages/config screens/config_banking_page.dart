import 'package:flutter/material.dart';

class ConfigBanking extends StatefulWidget {
  @override
  _ConfigBankingState createState() => _ConfigBankingState();
}

/* TODO
actual functionality
*/

class _ConfigBankingState extends State<ConfigBanking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Update banking information"),
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    children: <Widget>[
                      bankNameInput(),
                      routingNumberInput(),
                      accountNumberInput(),
                      updateButton(),
                    ],
                  ),
                ))));
  }

  Widget bankNameInput() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Bank Name',
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

  Widget routingNumberInput() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Routing Number',
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

  Widget accountNumberInput() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Account Number',
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

  Widget updateButton() {
    return RaisedButton(
      child: Text("Update"),
      color: Colors.green,
      textColor: Colors.white,
      onPressed: () {},
    );
  }
}
