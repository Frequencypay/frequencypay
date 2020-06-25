// Service class containing all Firestore operations
import 'package:cloud_firestore/cloud_firestore.dart';

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

  //Create a contract object






}