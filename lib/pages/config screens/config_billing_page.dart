import 'package:flutter/material.dart';

class ConfigBilling extends StatefulWidget {
  @override
  _ConfigBillingState createState() => _ConfigBillingState();
}

/* TODO
actual functionality
*/

class _ConfigBillingState extends State<ConfigBilling> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Update billing information"),
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    children: <Widget>[
                      streetAddressInput(),
                      cityInput(),
                      stateInput(),
                      zipInput(),
                      phoneNumberInput(),
                      updateButton(),
                    ],
                  ),
                ))));
  }

  Widget streetAddressInput() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Street Address',
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

  Widget cityInput() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'City',
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

  Widget stateInput() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'State',
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

  Widget zipInput() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Zip',
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

  Widget phoneNumberInput() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Phone Number',
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
