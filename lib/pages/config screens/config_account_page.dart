import 'package:flutter/material.dart';

class ConfigAccount extends StatefulWidget {
  @override
  _ConfigAccountState createState() => _ConfigAccountState();
}

/* TODO
actual functionality
*/

class _ConfigAccountState extends State<ConfigAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Update account information"),
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    children: <Widget>[
                      firstNameInput(),
                      lastNameInput(),
                      emailInput(),
                      passwordInput(),
                      passwordConfirmInput(),
                      updateButton(),
                    ],
                  ),
                ))));
  }

  Widget firstNameInput() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'First Name',
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

  Widget lastNameInput() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Last Name',
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

  Widget emailInput() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
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

  Widget passwordInput() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
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

  Widget passwordConfirmInput() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Confirm Password',
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
