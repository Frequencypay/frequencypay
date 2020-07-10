import 'package:flutter/material.dart';
import 'package:frequencypay/pages/authenticate/wrapper.dart';
import 'package:frequencypay/pages/home_page.dart';
import 'package:frequencypay/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frequencypay/blocs/wakeupauth_bloc.dart';
import 'package:frequencypay/services/firestore_db_service.dart';

class WakeUpAuth extends StatefulWidget {
  @override
  _WakeUpAuthState createState() => _WakeUpAuthState();
}

class _WakeUpAuthState extends State<WakeUpAuth> {
  final AuthService _auth=AuthService();
  WakeupBloc createBloc(var context,) {
    final user = Provider.of<User>(context, listen: false);

    WakeupBloc bloc = WakeupBloc(FirestoreService(uid: user.uid));

    bloc.add(LoadProfileEvent());

    return bloc;
  }
  TextEditingController pinInputController;
  @override
  initState() {
    pinInputController = new TextEditingController();
    final user=Provider.of<User>(context,listen: false);
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => createBloc(context),
      child: Scaffold(
        body: Center(
          child:Column(
            children: <Widget>[
              SizedBox(height: 250,),
              wakeup(),
            ],
          ),
        ),
      ),
    );
  }


  Widget wakeup() {
    return Column(
      children: <Widget>[
        BlocBuilder<WakeupBloc, WakeupState>(builder: (context, state) {
          if (state is WakeupIsLoadedState) {
            var actualPIN=state.getProfile.pin;
            return Column(
              children: <Widget>[
                Text("Please verify your PIN",style: TextStyle(color: Colors.grey,fontSize: 30),),
                SizedBox(height: 20,),
                pinInput(),
                SizedBox(height: 20,),
                RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 15,horizontal: 30),
                  child: Text("Access",style: TextStyle(color: Colors.white),),
                  color: Colors.blue,
                  onPressed: (){
                    if(state.getProfile.pin==pinInputController.text){
                      Wrapper();
                    }
                    else{
                      print("there's a problem");
                    }
                  },
                ),
                FlatButton.icon(
                  icon: Icon(Icons.person,color: Colors.grey,),
                  label: Text("Log out",style: TextStyle(color: Colors.grey),),
                  onPressed: () async {
                    await _auth.signOut();
                  },
                ),

              ],
            );
          } else if (state is WakeupIsNotLoadedState) {
            return Text(
              "ERROR - Could not verify PIN",
              style: TextStyle(color: Colors.black54, fontSize: 25),
            );
          } else {
            return Text(
              "PIN",
              style: TextStyle(color: Colors.black54, fontSize: 25),
            );
          }
        }),
      ],
    );
  } // end pr

  Widget pinInput(){
    return TextFormField(
      controller: pinInputController,
      decoration: InputDecoration(
        hintText:"4 Digit Pin",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
        ),
      ),
      validator:(val)=> (val.length>4 || val.length<4) ? 'Enter a 4 digit pin' : null, // More validation will be added later
    );
  }



}
