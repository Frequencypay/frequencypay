// Service class containing all Firestore operations
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frequencypay/pages/loan_request_page.dart';

class FirestoreService{
  final String uid;
  FirestoreService({this.uid}); // V.I. When we create an instance of this service class, the UID must be passed,
  //so anytime we use this service class, we have the uid of the user (makes things more secure)

  //collection references (we can have one for each collection)
  final CollectionReference userCollection=Firestore.instance.collection('users');
  final CollectionReference userDataCollection=Firestore.instance.collection('user_data');
  final CollectionReference contractCollection=Firestore.instance.collection('contracts');

  //Set or Update user data
  //This function is called whenever a user signs up for the first time, or when user wants to update their data
  Future setOrUpdateUserData(String name, String email,String username, String phone,List indexList ) async{
    //if document doesn't exist yet, firestore creates one automatically
    return await userDataCollection.document(uid).setData({
      'name':name,
      'email':email,
      'username':username,
      'phone':phone,
      'searchIndex':indexList
    });
  }

  //Search for users //NEEDS SOME EXTRA WORK
  Future searchUsers(String searchString) async{
    StreamBuilder<QuerySnapshot>(
      stream: (searchString==null)?Firestore.instance.collection("user_data").snapshots():Firestore.instance.collection("user_data").where("searchIndex",arrayContains: searchString).snapshots(),
      builder: (context,snapshot){
        if(snapshot.hasError){
          return Text("Error");
        }
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default: // return the list of results
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document){
                return new Card(
                  color: Colors.grey[200],
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(child: Text("profile pic"), radius: 40,),
                      Padding(
                        padding: EdgeInsets.all(50),
                      ),
                      Column(
                        children: <Widget>[
                          Text(document['name'],style: TextStyle(color: Colors.blueGrey,fontSize: 20),),
                          Text(document["email"]),
                          Text(document["username"]),
                          RaisedButton(
                            child: Text("Select",style: TextStyle(color: Colors.white),),
                            onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context)=>LoanRequest(value: document['name'],),
                              ));
                            },
                            color: Colors.blue,
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
        }
      },
    );
  }

  //Create a contract object






}