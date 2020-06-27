// Service class containing all Firestore operations
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frequencypay/models/contract_model.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/pages/loan_request_page.dart';

class FirestoreService{
  final String uid;
  FirestoreService({this.uid}); // V.I. When we create an instance of this service class, the UID must be passed,
  //so anytime we use this service class, we have the uid of the user (makes things more secure)

  //collection references (we can have one for each collection)
  final CollectionReference userDataCollection=Firestore.instance.collection('user_data');
  final CollectionReference contractCollection=Firestore.instance.collection('contracts');
  final CollectionReference userBillsCollection=Firestore.instance.collection('user_bills');

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

  //Create a contract object in the database
  //This function is called whenever a loan request is submitted
  Future createContract(String requester, String loaner, String dueDate, double numPayments, double amount, bool isActive) async{
    return await contractCollection.document(uid).setData({
      'requester':requester,
      'loaner':loaner,
      'dueDate':dueDate,
      'numPayments':numPayments,
      'amount':amount,
      'isActive': isActive
    });
  }


  //userData from snapshot
  //THIS IS THE FUNCTION THAT TRANSFORMS THE USER DATA WE GET FROM DB INTO OUR CUSTOM userData model
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid:uid,
      name: snapshot.data['name'],
      email: snapshot.data['email'],
      username: snapshot.data['username'],
      phoneNumber: snapshot.data['phone']
    );
  }

  //get user_data stream
  Stream<UserData> get userData{ //the stream returns data based on UserData model, which is our model that we defined
    return userDataCollection.document(uid).snapshots().map(_userDataFromSnapshot); // map what we get back to our custom model
  }

  //contracts lists from snapshot
  //THIS IS THE FUNCTION THAT TRANSFORMS THE CONTRACTS WE GET FROM DB INTO OUR CUSTOM userData model
  List<Contract> _contractListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Contract(
        requester: doc.data['requester'] ?? '',
        loaner: doc.data['loaner'] ?? '',
        dueDate: doc.data['dueDate'] ?? '',
        numPayments: doc.data['numPayments'] ?? 0,
        amount: doc.data['amount'] ?? 0,
        isActive: doc.data['isActive'] ?? false
      );
    }).toList();
  }

  //get contracts stream
  Stream<List<Contract>> get contracts{
    return contractCollection.snapshots().map(_contractListFromSnapshot);
  }








}