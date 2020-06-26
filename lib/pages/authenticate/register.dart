import 'package:flutter/material.dart';
import 'package:frequencypay/services/firebase_auth_service.dart';
import 'package:frequencypay/pages/authenticate/loading.dart';


class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth=AuthService();
  final _formKey=GlobalKey<FormState>();
  bool loading=false;
  String error='';

  TextEditingController nameInputController;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  TextEditingController confirmPwdInputController;
  TextEditingController usernameInputController;
  TextEditingController phoneInputController;

  @override
  initState() {
    nameInputController=new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    confirmPwdInputController = new TextEditingController();
    usernameInputController = new TextEditingController();
    phoneInputController=new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Register"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person,color: Colors.white,),
            label: Text("Sign In",style: TextStyle(color: Colors.white),),
            onPressed: (){
              widget.toggleView(); // change to opposite screen
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key:_formKey ,
            child: Column(
              children: <Widget>[
                logo(),
                SizedBox(height: 20,),
                Text("Please enter the following information:",style: TextStyle(color: Colors.grey,fontSize: 15),),
                SizedBox(height: 20,),
                nameInput(),
                SizedBox(height: 10,),
                emailInput(),
                SizedBox(height: 10,),
                passwordInput(),
                SizedBox(height: 10,),
                confirmPasswordInput(),
                SizedBox(height: 10,),
                userNameInput(),
                SizedBox(height: 10,),
                phoneNumberInput(),
                SizedBox(height: 10,),
                registerButton(),
                Text(error,style: TextStyle(color: Colors.red,fontSize: 18),),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget logo(){
    return Image.asset('assets/temp_logo.png',height: 200,);
  }

  Widget nameInput(){
    return TextFormField(
      controller: nameInputController,
      decoration: InputDecoration(
        hintText:"Name",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
        ),
      ),
      validator:(val)=> val.isEmpty ? 'Enter a valid name' : null,
    );
  }

  Widget emailInput(){
    return TextFormField(
      controller: emailInputController,
      decoration: InputDecoration(
        hintText:"Email",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
        ),
      ),
      validator:(val)=> val.isEmpty ? 'Enter an Email' : null,
    );
  }

  Widget passwordInput(){
    return TextFormField( // replace by function later
      controller: pwdInputController,
      decoration: InputDecoration(
        hintText:"Password",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
        ),
      ),
      validator:(val)=> val.length<6 ? 'Enter a password longer than 6 characters' : null,
      obscureText: true,
    );
  }

  Widget confirmPasswordInput(){
    return TextFormField( // replace by function later
      controller: confirmPwdInputController,
      decoration: InputDecoration(
        hintText:"Confirm Password",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
        ),
      ),
      validator:(val)=> val.length<6 ? 'Enter a password longer than 6 characters' : null,
      obscureText: true,
    );
  }

  Widget userNameInput(){
    return TextFormField(
      controller: usernameInputController,
      decoration: InputDecoration(
        hintText:"Username",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
        ),
      ),
      validator:(val)=> val.isEmpty ? 'Enter a valid usernname' : null,
    );
  }

  Widget phoneNumberInput(){
    return TextFormField(
      controller: phoneInputController,
      decoration: InputDecoration(
        hintText:"Phone Number",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
        ),
      ),
      validator:(val)=> val.isEmpty ? 'Enter a valid phone number' : null,
    );
  }

  Widget registerButton(){
    return RaisedButton(
      color: Colors.blue,
      child: Text("Register",style: TextStyle(color: Colors.white,fontSize: 15),),
      onPressed: () async {
        if(_formKey.currentState.validate()){
          loading=true;
          dynamic result=await _auth.registerWithEmailAndPassword(emailInputController.text,pwdInputController.text,nameInputController.text,usernameInputController.text,phoneInputController.text);
          if(result==null){
            setState(() {
              error='Please enter a valid email';
              loading=false;
            });
          }
          //If the user successfully register, the stream will automatically take them to home screen
          //Stream listens to auth changes
        }
      },
    );

  }
}
