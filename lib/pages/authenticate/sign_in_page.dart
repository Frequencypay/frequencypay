import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frequencypay/pages/authenticate/loading.dart';
import 'package:frequencypay/services/firebase_auth_service.dart';

class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth =
      AuthService(); // instance of AuthService class (auth service class having all the authentication functionality) (disregard that its named the same thing)
  final _formKey = GlobalKey<FormState>();
  bool loading = false; //for the loading spinner
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  String error = '';

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text("Sign In"),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(
                    Icons.person_add,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Register",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/register'); // switch to opposite screen
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      logo(),
                      SizedBox(
                        height: 30,
                      ),
                      emailInput(),
                      SizedBox(
                        height: 20,
                      ),
                      passwordInput(),
                      SizedBox(
                        height: 20,
                      ),
                      signInButton(),
                      SizedBox(
                        height: 5,
                      ),
                      forgotPassword(),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget logo() {
    return Image.asset(
      'assets/temp_logo.png',
      fit: BoxFit.scaleDown,
    );
  }

  Widget emailInput() {
    return TextFormField(
      controller: emailInputController,
      decoration: InputDecoration(
        hintText: "Email",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
        ),
      ),
      validator: (val) => val.isEmpty ? 'Enter an Email' : null,
    );
  }

  Widget passwordInput() {
    return TextFormField(
      // replace by function later
      controller: pwdInputController,
      decoration: InputDecoration(
        hintText: "Password",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
        ),
      ),
      validator: (val) =>
          val.length < 6 ? 'Enter a password longer than 6 characters' : null,
      obscureText: true,
    );
  }

  Widget signInButton() {
    return RaisedButton(
      color: Colors.blue,
      child: Text(
        "Sign In",
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          setState(() => loading = true);
          dynamic result = await _auth.signInWithEmailAndPassword(
              emailInputController.text, pwdInputController.text);
          if (result == null) {
            setState(() {
              error = 'could not sign in with those credentials';
              loading = false;
            });
          }
          if (result != null) {
             Navigator.pushReplacementNamed(context, '/plaid_splash');
          }
          //If the user successfully register, the stream will automatically take them to home screen
          //Stream listens to auth changes
        }
      },
    );
  }

  Widget forgotPassword() {
    return RaisedButton(
      color: Colors.green,
      child: Text(
        "Forgot Password",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.pushNamed(context, "/forgotPassword");
      },
    );
  }
}
