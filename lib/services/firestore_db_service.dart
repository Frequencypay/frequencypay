// Service class containing all Firestore operations
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frequencypay/models/contract_model.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/pages/loan_request_page.dart';

class FirestoreService{
  final String uid;
  final String value;
  FirebaseUser currentUser;
  FirestoreService({this.uid,this.value}); // V.I. When we create an instance of this service class, the UID must be passed,
  //so anytime we use this service class, we have the uid of the user (makes things more secure)

  //collection references (we can have one for each collection)
  final CollectionReference userDataCollection=Firestore.instance.collection('user_data');
  final CollectionReference contractCollection=Firestore.instance.collection('contracts');
  final CollectionReference userBillsCollection=Firestore.instance.collection('user_bills'); //NOT USED YET

  //CRUD OPERATIONS: CREATE

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

  //Create a contract object in the database
  //This function is called whenever a loan request is submitted
  Future createContract(String requester, String loaner, String dueDate, double numPayments, double amount) async{
    return await contractCollection.document(uid).setData({
      'requester':requester,
      'loaner':loaner,
      'dueDate':dueDate,
      'numPayments':numPayments,
      'amount':amount,
      'isActive': false,
      'isPending':true,
      'isComplete':false,
    });
  }

  //CRUD OPERATION: READ

  //userData from snapshot
  //THIS IS THE FUNCTION THAT TRANSFORMS (WITH THE HELP OF THE STREAM) THE USER DATA WE GET FROM DB INTO OUR CUSTOM userData model
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



//contract from snapshot (retrieves specific contract based on UID)
// THIS IS THE FUNCTION THAT TRANSFORMS THE CONTRACT DATA WE GET FROM DB INTO OUR CUSTOM contract model

  Contract _contractFromSnapshot(DocumentSnapshot snapshot){ //For a single contract
    return Contract(
      amount: snapshot.data['amount'],
      dueDate: snapshot.data['dueDate'],
      isActive: snapshot.data['isActive'],
      isComplete: snapshot.data['isComplete'],
      isPending: snapshot.data['isPending'],
      loaner: snapshot.data['loaner'],
      numPayments: snapshot.data['numPayments'],
      requester: snapshot.data['requester'],
    );
  }

  Stream<Contract> get contract{
    return contractCollection.document(uid).snapshots().map(_contractFromSnapshot);
  }

  //ACTIVE contract list from snapshots (retrieves all the active contracts a user has)
  //mapped to the custom contract model
  List<Contract> _activeContractListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) { //perform an action for each document
      return Contract(
        amount: doc.data['amount'],
        dueDate: doc.data['dueData'],
        isActive: doc.data['isActive'],
        isComplete: doc.data['isComplete'],
        isPending: doc.data['isPending'],
        loaner: doc.data['loaner'],
        numPayments: doc.data['numPayments'],
        requester: doc.data['requester'],
      );
    }).toList();
  }

  Stream<List<Contract>> get activeContracts{
    return contractCollection.where('isActive', isEqualTo: true)
        .where('isComplete', isEqualTo: false)
        .where('isPending', isEqualTo: false)
        .where('requester', isEqualTo: currentUser.email)
        .snapshots().map(_activeContractListFromSnapshot);
  }

  //PENDING contract list from snapshots (retrieves all the pending contracts a user has)
  //mapped to the custom contract model
  List<Contract> _pendingContractListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) { //perform an action for each document
      return Contract(
        amount: doc.data['amount'],
        dueDate: doc.data['dueData'],
        isActive: doc.data['isActive'],
        isComplete: doc.data['isComplete'],
        isPending: doc.data['isPending'],
        loaner: doc.data['loaner'],
        numPayments: doc.data['numPayments'],
        requester: doc.data['requester'],
      );
    }).toList();
  }

  Stream<List<Contract>> get pendingContracts{
    return contractCollection.where('isActive', isEqualTo: false)
        .where('isComplete', isEqualTo: false)
        .where('isPending', isEqualTo: true)
        .where('requester', isEqualTo: currentUser.email)
        .snapshots().map(_activeContractListFromSnapshot);
  }

  //COMPLETE contract list from snapshots (retrieves all the pending contracts a user has)
  //mapped to the custom contract model
  List<Contract> _completeContractListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) { //perform an action for each document
      return Contract(
        amount: doc.data['amount'],
        dueDate: doc.data['dueData'],
        isActive: doc.data['isActive'],
        isComplete: doc.data['isComplete'],
        isPending: doc.data['isPending'],
        loaner: doc.data['loaner'],
        numPayments: doc.data['numPayments'],
        requester: doc.data['requester'],
      );
    }).toList();
  }

  Stream<List<Contract>> get completeContracts{
    return contractCollection.where('isActive', isEqualTo: false)
        .where('isComplete', isEqualTo: true)
        .where('isPending', isEqualTo: false)
        .where('requester', isEqualTo: currentUser.email)
        .snapshots().map(_activeContractListFromSnapshot);
  }



  //user search data from snapshot (retrieves specific contract based on UID)
  UserData _userSearchDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
        uid:uid,
        name: snapshot.data['name'],
        email: snapshot.data['email'],
        username: snapshot.data['username'],
        phoneNumber: snapshot.data['phone']
    );
  }

  Stream <QuerySnapshot> get userSearchData{
    return (value==null)?Firestore.instance.collection("user_data").snapshots():Firestore.instance.collection("user_data").where("searchIndex",arrayContains: value).snapshots();
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }











}