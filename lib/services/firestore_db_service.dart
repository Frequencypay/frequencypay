// Service class containing all Firestore operations
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frequencypay/models/contract_model.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/pages/authenticate/wakeup_auth.dart';
import 'package:frequencypay/pages/home_page.dart';
import 'package:frequencypay/pages/loan_request_page.dart';

class FirestoreService{
  final String uid;
  final String value;
  FirestoreService({this.uid,this.value}); // V.I. When we create an instance of this service class, the UID must be passed,
  //so anytime we use this service class, we have the uid of the user (makes things more secure)

  //collection references (we can have one for each collection)
  final CollectionReference userDataCollection=Firestore.instance.collection('user_data');
  final CollectionReference contractCollection=Firestore.instance.collection('contracts');
  final CollectionReference userBillsCollection=Firestore.instance.collection('user_bills');

  //Set or Update user data
  //This function is called whenever a user signs up for the first time, or when user wants to update their data
  Future setOrUpdateUserData(String name, String email,String username, String phone,List indexList,String pin,bool rememberMe ) async{
    //if document doesn't exist yet, firestore creates one automatically
    return await userDataCollection.document(uid).setData({
      'name':name,
      'email':email,
      'username':username,
      'phone':phone,
      'searchIndex':indexList,
      'PIN':pin,
      'rememberMe':rememberMe
    });
  }

  Future updateRememberMe(bool value) async{
    return await userDataCollection.document(uid).setData({
      'rememberMe':value
    });
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
      phoneNumber: snapshot.data['phone'],
      pin: snapshot.data['PIN'],
      rememberMe: snapshot.data['rememberMe'],
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



  Stream <QuerySnapshot> get userSearchData{
    return (value==null)?Firestore.instance.collection("user_data").snapshots():Firestore.instance.collection("user_data").where("searchIndex",arrayContains: value).snapshots();
  }













}