import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frequencypay/pages/home_page.dart';

import 'home screens/home_pages_group.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController firstNameInputController;
  TextEditingController lastNameInputController;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  TextEditingController confirmPwdInputController;

  @override
  initState() {
    firstNameInputController = new TextEditingController();
    lastNameInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    confirmPwdInputController = new TextEditingController();
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
          title: Text("Register"),
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: Form(
                  key: _registerFormKey,
                  child: Column(
                    children: <Widget>[
                      logo(),
                      firstNameInput(),
                      lastNameInput(),
                      emailInput(),
                      passwordInput(),
                      passwordConfirmInput(),
                      registerButton(),
                      Text("Already have an account?"),
                      FlatButton(
                        child: Text("Login here!"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ))));
  }

  Widget logo() {
    return
      Image.asset('assets/frequency.png',fit: BoxFit.scaleDown, );
  }

  Widget firstNameInput(){
    return
      TextFormField(
        decoration: InputDecoration(
            labelText: 'First Name*', hintText: "John"),
        controller: firstNameInputController,
        validator: (value) {
          // ignore: missing_return
          if (value.length < 3) {
            return "Please enter a valid first name.";
          }
        },
      );
  }

  Widget lastNameInput(){
    return
      TextFormField(
          decoration: InputDecoration(
              labelText: 'Last Name*', hintText: "Doe"),
          controller: lastNameInputController,
          validator: (value) {
            // ignore: missing_return
            if (value.length < 3) {
              return "Please enter a valid last name.";
            }
          });
  }

  Widget emailInput() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Email*', hintText: "john.doe@gmail.com"),
      controller: emailInputController,
      keyboardType: TextInputType.emailAddress,
      validator: emailValidator,
    );
  }

  Widget passwordInput(){
    return
      TextFormField(
        decoration: InputDecoration(
            labelText: 'Password*', hintText: "********"),
        controller: pwdInputController,
        obscureText: true,
        validator: pwdValidator,
      );
  }

  Widget passwordConfirmInput(){
    return
      TextFormField(
        decoration: InputDecoration(
            labelText: 'Confirm Password*', hintText: "********"),
        controller: confirmPwdInputController,
        obscureText: true,
        validator: pwdValidator,
      );
  }

  Widget registerButton(){
    return
      RaisedButton(
        child: Text("Register"),
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        onPressed: _registerUser,
      );
  }

  void _registerUser(){
    if (_registerFormKey.currentState.validate()) {
      if (pwdInputController.text ==
          confirmPwdInputController.text) {
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: emailInputController.text,
            password: pwdInputController.text)
            .then((currentUser) => Firestore.instance
            .collection("users")
            .document(currentUser.user.uid)
            .setData({
          "uid": currentUser.user.uid,
          "fname": firstNameInputController.text,
          "surname": lastNameInputController.text,
          "email": emailInputController.text,
        })
            .then((result) => [
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => /*HomePage(
                    title:
                    firstNameInputController
                        .text +
                        "'s Tasks",
                    uid: currentUser.user.uid,
                  )*/
                  //HomePagesGroup(userInfo: currentUser, uid: currentUser.user.uid)),
                  LoginPage()),
                  (_) => false),
          firstNameInputController.clear(),
          lastNameInputController.clear(),
          emailInputController.clear(),
          pwdInputController.clear(),
          confirmPwdInputController.clear()
        ])
            .catchError((err) => print(err)))
            .catchError((err) => print(err));
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("The passwords do not match"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    }
  }
}