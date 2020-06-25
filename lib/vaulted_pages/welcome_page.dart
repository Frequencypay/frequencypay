import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 30.0),
        child: Column(
          children: <Widget>[
            loginButton(context),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),),
            logo(),
            registerButton(context),
          ],
        ),
      ),
    );
  }

  Widget logo(){
    return
        Image.asset('assets/bank.png', fit: BoxFit.scaleDown,);
  }

  Widget loginButton(context) {
    return
      Align(
        alignment: Alignment.topRight,
        child:
        RaisedButton(
          color: Colors.white,
          elevation: 0,
          child: Text(
            "Log in",
            style: new TextStyle(fontSize: 16.0),
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/login");
          },
        ),


      );
  }

  Widget registerButton(context) {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: ButtonTheme(
            minWidth: double.infinity,
            height: 45,
            child: RaisedButton(
              child: Text(
                "Sign up for Bank Of!",
                style: new TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25.0),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
            )),
      ),
    );
  }
}
