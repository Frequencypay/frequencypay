import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:frequencypay/models/user_model.dart';


class MessageHandler extends StatefulWidget {
  @override
  _MessageHandlerState createState() => _MessageHandlerState();
}

class _MessageHandlerState extends State<MessageHandler> {
  final Firestore _db=Firestore.instance;
  final FirebaseMessaging _fcm=FirebaseMessaging();

  @override
  void initState(){
    super.initState();
    print("notifications initialized");
    _fcm.configure( //here, we will handle all the possible notification receiving times
      onMessage: (Map<String,dynamic> message) async{ //if a notification is received when user is using the app (app in foreground)
        print("onMessage: $message");
        //when a user is using the app and receives a notification, we show a snackbar
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          )
        );
      },

      onResume: (Map<String,dynamic> message) async{ //if a notification is received when user is using the app (app in foreground)
      print("onResume: $message");
      //todo
      },

      onLaunch: (Map<String,dynamic> message) async{ //if a notification is received when user is using the app (app in foreground)
        print("onLaucnh: $message");
        //todo
      }

    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 300, width: 500,),
            Text("Allow Notifications"),
            RaisedButton(
              child: Text("proceed"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/wake_up');
              },
            ),
          ],
        ),
      ),
    );
  }

  //get the token
 _saveDeviceToken() async{
   final user = Provider.of<User>(context, listen: false);
   String fcmToken = await _fcm.getToken();

   if(fcmToken != null){
     var tokenRef = _db.collection('user_data').document(user.uid).collection('tokens').document(fcmToken);
     await tokenRef.setData({
       'token':fcmToken,
       'createdAt':FieldValue.serverTimestamp(),
       'platform':Platform.operatingSystem
     });
   }

 }
}
