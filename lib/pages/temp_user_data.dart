//This is just a temporary page that shows user data that we get from the custom userData model
import 'package:flutter/material.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/pages/authenticate/loading.dart';
import 'package:frequencypay/services/firestore_db_service.dart';
import 'package:provider/provider.dart';

class currentUserData extends StatefulWidget {
  @override
  _currentUserDataState createState() => _currentUserDataState();
}

class _currentUserDataState extends State<currentUserData> {
  @override
  Widget build(BuildContext context) {
    final user =Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Current User Data"),
      ),
      
      body: StreamBuilder<UserData>( //we get userData (custom model) from the stream
        stream: FirestoreService(uid: user.uid).userData, //userData is the stream name we defined in service class
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData userData=snapshot.data;

            return SafeArea(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("Name: "),
                      Text(userData.name),
                    ],
                  ),

                  Row(
                    children: <Widget>[
                      Text("UID: "),
                      Text(userData.uid),
                    ],
                  ),

                  Row(
                    children: <Widget>[
                      Text("Email: "),
                      Text(userData.email),
                    ],
                  ),

                  Row(
                    children: <Widget>[
                      Text("Username: "),
                      Text(userData.username),
                    ],
                  ),

                  Row(
                    children: <Widget>[
                      Text("Phone: "),
                      Text(userData.phoneNumber),
                    ],
                  ),
                ],

              ),
            );

          }
          else{
            return Loading();
          }

        }
      ),
    );
  }
}
