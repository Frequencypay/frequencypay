import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frequencypay/pages/home_page.dart';
import 'package:frequencypay/pages/landing_page.dart';

import '../pages/authenticate/loading.dart';

class LoginPage extends StatefulWidget {
  //LoginPage({Key key}) : super(key: key);
  final Function toggleView;
  LoginPage({this.toggleView});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  bool loading= false;

  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Sign In"),
          backgroundColor: Colors.blue,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon:Icon(Icons.person_add, color: Colors.white,),
              label: Text("Register",style: TextStyle(color: Colors.white),),
              onPressed: (){
                Navigator.pushNamed(context, '/register');
              },
            )
          ],
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                    children: <Widget>[
                      logo(),
                      SizedBox(height:20.0),
                      emailInput(),
                      SizedBox(height:20.0),
                      passwordInput(),
                      SizedBox(height:20.0),
                      submitButton(),
                      SizedBox(height:10.0),
                      forgotPassword(),
                    ],
                  ),
                ))));
  }

  Widget logo() {
    return
      Image.asset('assets/frequency.png',fit: BoxFit.scaleDown, );
  }

  Widget emailInput(){
    return
      TextFormField(
        decoration: InputDecoration(
            labelText: 'Email', hintText: "infofrequency@frequency.com"),
        controller: emailInputController,
        keyboardType: TextInputType.emailAddress,
        validator: emailValidator,
      );
  }

  Widget passwordInput(){
    return
      TextFormField(
        decoration: InputDecoration(
            labelText: 'Password', hintText: "********"),
        controller: pwdInputController,
        obscureText: true,
        validator: pwdValidator,
      );
  }

  Widget submitButton(){
    return
      RaisedButton(
        child: Text("Login"),
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        onPressed: () async {
          if (_loginFormKey.currentState.validate()) {
            FirebaseAuth.instance
                .signInWithEmailAndPassword(
                email: emailInputController.text,
                password: pwdInputController.text)
                .then((currentUser) => Firestore.instance
                .collection("users")
                .document(currentUser.user.uid)
                .get()
                .then((DocumentSnapshot result) =>
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                          uid: currentUser.user.uid,
                        ))))
                .catchError((err) => print(err)))
                .catchError((err) => print(err));
          }
        },
      );
  }

  Widget forgotPassword(){
    return
        FlatButton(
          child: Text("Forgot Password"),
          onPressed: (){
            Navigator.pushNamed(context, "/forgotPassword");
          },
        );
  }
}