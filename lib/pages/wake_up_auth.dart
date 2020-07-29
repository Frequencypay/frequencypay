import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frequencypay/blocs/wake_up_auth_bloc.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/services/firestore_db_service.dart';
import 'package:provider/provider.dart';

class WakeUpAuth extends StatefulWidget {
  @override
  _WakeUpAuthState createState() => _WakeUpAuthState();
}

class _WakeUpAuthState extends State<WakeUpAuth> {
  TextEditingController pinInputController;
  @override
  initState() {
    pinInputController = new TextEditingController();
    super.initState();
  }
  WakeUpBloc createBloc(
      var context,
      ) {
    final user = Provider.of<User>(context, listen: false);

    WakeUpBloc bloc = WakeUpBloc(FirestoreService(uid: user.uid));

    bloc.add(LoadProfileEvent());

    return bloc;
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => createBloc(context),
      child: Scaffold(
          body: SafeArea(
            child: wakeupForm(),
          ),

      ),
    );
  }

  Widget wakeupForm(){
    return Column(
      children: <Widget>[
        BlocBuilder<WakeUpBloc, WakeUpState>(builder: (context, state) {

          if (state is WakeUpIsLoadedState) {
            final actualPin=state.getProfile.pin;
            return Column(
              children: <Widget>[
                SizedBox(height: 300,),
                Text("Please enter your PIN to continue"),
              TextFormField(
              controller: pinInputController,
              decoration: InputDecoration(
                hintText:"PIN",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
                ),
              ),
              validator:(val)=> val.isEmpty ? 'Enter a valid name' : null,
            ),

              RaisedButton(
                child: Text("Submit"),
                onPressed: (){
                  print(actualPin);
                  if(pinInputController.text == actualPin){
                    Navigator.pushReplacementNamed(context, '/home');
                  }

                },
              )


              ],
            );
          } else if (state is WakeUpIsNotLoadedState) {
            return Text(
              "error",
              style: TextStyle(color: Colors.black54, fontSize: 25),
            );
          } else {
            return Text(
              "Loading",
              style: TextStyle(color: Colors.black54, fontSize: 25),
            );
          }
        }),
      ],
    );
  }
}
