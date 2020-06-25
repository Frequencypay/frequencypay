import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frequencypay/pages/home_page.dart';
import 'package:frequencypay/pages/landing_page.dart';

class RegisterPage extends StatefulWidget {
  final Function toggleView;
  //RegisterPage({Key key} ) : super(key: key) ;
  RegisterPage({this.toggleView});


  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  //TextEditingController firstNameInputController;
  //TextEditingController lastNameInputController;
  TextEditingController nameInputController;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  TextEditingController confirmPwdInputController;
  TextEditingController usernameInputController;
  TextEditingController phoneInputController;

  @override
  initState() {
    //firstNameInputController = new TextEditingController();
    //lastNameInputController = new TextEditingController();
    nameInputController=new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    confirmPwdInputController = new TextEditingController();
    usernameInputController = new TextEditingController();
    phoneInputController=new TextEditingController();
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
          backgroundColor: Colors.blue,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon:Icon(Icons.person, color: Colors.white,),
              label: Text("Log In",style: TextStyle(color: Colors.white),),
              onPressed: (){
                Navigator.pushNamed(context, '/login');
              },
            )
          ],
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: Form(
                  key: _registerFormKey,
                  child: Column(
                    children: <Widget>[
                      logo(),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: nameInput(),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(" "),
                          ),

                        ],
                      ),

                      SizedBox(height: 10.0,),
                      emailInput(),
                      SizedBox(height: 10.0,),
                      passwordInput(),
                      SizedBox(height: 10.0,),
                      passwordConfirmInput(),
                      SizedBox(height: 10.0,),
                      usernameInput(),
                      SizedBox(height: 10.0,),
                      phoneNumber(),
                      SizedBox(height: 10.0,),



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

  /*
  Widget firstNameInput(){
    return  TextFormField(
      controller: firstNameInputController,
      decoration: InputDecoration(
        labelText: 'First Name',
        hintText: "John",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
      ),
    );
  }
*/

  /*
  Widget lastNameInput(){
    return TextFormField(
      controller: lastNameInputController,
      decoration: InputDecoration(
        labelText: 'Last Name',
        hintText: "Smith",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
      ),
    );
  }
   */

  Widget nameInput(){
    return TextFormField(
      controller: nameInputController,
      decoration: InputDecoration(
        labelText: 'Name',
        hintText: "JohnSmith",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
      ),
    );

  }

  Widget emailInput(){
    return TextFormField(
      controller: emailInputController,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: "infofrequency@frequency.com",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
      ),
      validator: emailValidator,
    );
  }


  Widget passwordInput(){
    return TextFormField(
      controller: pwdInputController,
      decoration: InputDecoration(
        labelText: 'Password',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
      ),
      validator: pwdValidator,
      obscureText: true,
    );
  }


  Widget passwordConfirmInput(){
    return TextFormField(
      controller: confirmPwdInputController,
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
      ),
      validator: pwdValidator,
      obscureText: true,
    );
  }

  Widget usernameInput(){ // will have some validation in the future
    return TextFormField(
      controller: usernameInputController,
      decoration: InputDecoration(
        labelText: 'Username',
        hintText: 'john123',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
      ),
    );
  }

  Widget phoneNumber(){ // will have some validation in the future
    return TextFormField(
      controller: phoneInputController,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        hintText: '(000)-000-0000',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 2.0),
        ),
      ),
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
    String name=nameInputController.text;
    List<String> splitList=name.split(" ");
    List<String> indexList=[];

    if (_registerFormKey.currentState.validate()) {
      if (pwdInputController.text ==
          confirmPwdInputController.text) {

        //for searching functionality:
        for(int i=0; i<splitList.length;i++){
          for(int y=1; y<splitList[i].length+1;y++){
            if(i==1){ // we are on last name
              indexList.add(splitList[i-1].toLowerCase()+" "+splitList[i].substring(0,y).toLowerCase());
            }
            indexList.add(splitList[i].substring(0,y).toLowerCase());
            print((splitList[i].substring(0,y).toLowerCase()));
          }
        }

        //creates account and then sets data (2 in 1)
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: emailInputController.text,
            password: pwdInputController.text)
            .then((currentUser) => Firestore.instance
            .collection("users")
            .document(currentUser.user.uid)
            .setData({
          "uid": currentUser.user.uid,
          "name":nameInputController.text,
          "email": emailInputController.text,
          "phone":phoneInputController.text,
          "username":usernameInputController.text,
          "activeContracts":0,
          "latePayments":0,
          "searchIndex":indexList,
          "completeContracts":0,
        })
            .then((result) => [
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                    uid: currentUser.user.uid,
                  )),
                  (_) => false),
          //firstNameInputController.clear(),
          //lastNameInputController.clear(),
          nameInputController.clear(),
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