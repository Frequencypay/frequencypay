import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _forgotPasswordKey = GlobalKey<FormState>();
  TextEditingController emailInputController;

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\['
        r'[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+'
        r'[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Form(
            key: _forgotPasswordKey,
            child: Column(
              children: <Widget>[
                logo(),
                emailInput(),
              ],
            )),
      ),
    );
  }

  Widget logo() {
    return
      Image.asset('assets/frequency.png',fit: BoxFit.scaleDown, );
  }

  Widget emailInput() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Email*', hintText: "john.doe@gmail.com"),
      controller: emailInputController,
      keyboardType: TextInputType.emailAddress,
      validator: emailValidator,
    );
  }

  Widget resetPasswordButton(){
    return
        RaisedButton(
          child: Text("Reset Password"),
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          onPressed: _resetPassword,
        );
  }

  void _resetPassword(){
    if (_forgotPasswordKey.currentState.validate()) {
      FirebaseAuth.instance.sendPasswordResetEmail(email: emailInputController.text);
    }
  }
}
