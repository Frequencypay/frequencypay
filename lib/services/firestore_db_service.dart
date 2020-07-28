// Service class containing all Firestore operations
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frequencypay/models/contract_model.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/services/search_queries/contract_search_query.dart';

class FirestoreService {
  final String uid;
  final String value;

  FirebaseUser currentUser;
  FirestoreService({
    this.uid,
    this.value
  }) {

    getCurrentUser();
  } // V.I. When we create an instance of this service class, the UID must be passed,

  //so anytime we use this service class, we have the uid of the user (makes things more secure)


  //collection references (we can have one for each collection)

  final CollectionReference userDataCollection=Firestore.instance.collection('user_data');
  final CollectionReference contractCollection=Firestore.instance.collection('contracts');
  final CollectionReference userBillsCollection=Firestore.instance.collection('user_bills'); //NOT USED YET



  //CRUD OPERATIONS: CREATE

  //Set or Update user data
  //This function is called whenever a user signs up for the first time, or when user wants to update their data
  Future setOrUpdateUserData(String fname, String lname, String email,String username, String phone, String address, List indexList,String pin,String avatarUrl ) async{
    //if document doesn't exist yet, firestore creates one automatically
    return await userDataCollection.document(uid).setData({
      'fname':fname,
      'lname':lname,
      'email':email,
      'username':username,
      'phone':phone,
      'address':address,
      'searchIndex':indexList,
      'pin':pin,
      'avatarUrl':avatarUrl
    });
  }

  //Create a contract object in the database
  //This function is called whenever a loan request is submitted

  Future createContract(String requester, String loaner, String requesterName, String loanerName, String dueDate, double numPayments, double amount) async{
    return await contractCollection.document(uid).setData({
      'requester':requester,
      'loaner':loaner,
      'requesterName':requesterName,
      'loanerName':loanerName,
      'dueDate':dueDate,
      'numPayments':numPayments,
      'amount':amount,
      'state':CONTRACT_STATE.OPEN_REQUEST.toString()
    });
  }

  //Returns an arbitrary user based on the given uid
  Stream<UserData> retrieveUser(String uid) {

    return userDataCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  //CRUD OPERATION: READ

  //userData from snapshot
  //THIS IS THE FUNCTION THAT TRANSFORMS (WITH THE HELP OF THE STREAM) THE USER DATA WE GET FROM DB INTO OUR CUSTOM userData model
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid:snapshot.documentID,
      fname: snapshot.data['fname'],
      lname: snapshot.data['lname'],
      email: snapshot.data['email'],
      username: snapshot.data['username'],
      phoneNumber: snapshot.data['phone'],
      address: snapshot.data['address'],
      pin:snapshot.data['pin'],
      avatarUrl: snapshot.data['avatarUrl']
    );
  }

  //get user_data stream
  Stream<UserData> get userData {
    //the stream returns data based on UserData model, which is our model that we defined
    return userDataCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot); // map what we get back to our custom model
  }

//contract from snapshot (retrieves specific contract based on UID)
// THIS IS THE FUNCTION THAT TRANSFORMS THE CONTRACT DATA WE GET FROM DB INTO OUR CUSTOM contract model

  Contract _contractFromSnapshot(DocumentSnapshot snapshot){ //For a single contract
    return Contract(
      amount: snapshot.data['amount'],
      dueDate: snapshot.data['dueDate'],
      state: snapshot.data['state'],
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
        state: contractStateFromString(doc.data['state']),
        loaner: doc.data['loaner'],
        loanerName: doc.data['loanerName'],
        numPayments: doc.data['numPayments'],
        requester: doc.data['requester'],
        requesterName: doc.data['requesterName']
      );
    }).toList();
  }

  //PENDING contract list from snapshots (retrieves all the pending contracts a user has)
  //mapped to the custom contract model
  List<Contract> _pendingContractListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) { //perform an action for each document
      return Contract(
        amount: doc.data['amount'],
        dueDate: doc.data['dueData'],
        state: contractStateFromString(doc.data['state']),
        loaner: doc.data['loaner'],
        loanerName: doc.data['loanerName'],
        numPayments: doc.data['numPayments'],
        requester: doc.data['requester'],
        requesterName: doc.data['requesterName']
      );
    }).toList();
  }

  //COMPLETE contract list from snapshots (retrieves all the pending contracts a user has)
  //mapped to the custom contract model
  List<Contract> _completeContractListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) { //perform an action for each document
      return Contract(
        amount: doc.data['amount'],
        dueDate: doc.data['dueData'],
        state: contractStateFromString(doc.data['state']),
        loaner: doc.data['loaner'],
        loanerName: doc.data['loanerName'],
        numPayments: doc.data['numPayments'],
        requester: doc.data['requester'],
        requesterName: doc.data['requesterName'],
      );
    }).toList();
  }

  Stream<List<Contract>> retrieveContracts(ContractSearchQuery query) {

    //The resulting stream
    Stream<List<Contract>> contractsStream;

    //If the requester is required
    if (query.requirementMode == REQUIREMENT_MODE.REQUESTER) {
      contractsStream =
          contractCollection.where('state', isEqualTo: query.state.toString())
              .where('requester', isEqualTo: currentUser.uid)
              .snapshots().map(_activeContractListFromSnapshot);
    }

    //Assume loaner required otherwise
    else {
      contractsStream =
          contractCollection.where('state', isEqualTo: query.state.toString())
              .where('loaner', isEqualTo: currentUser.uid)
              .snapshots().map(_activeContractListFromSnapshot);
    }

    //Return the resulting contract stream
    return contractsStream;
  }

  //user search data from snapshot (retrieves specific contract based on UID)
  UserData _userSearchDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
        uid:uid,
        fname: snapshot.data['fname'],
        lname: snapshot.data['lname'],
        email: snapshot.data['email'],
        username: snapshot.data['username'],
        phoneNumber: snapshot.data['phone'],
        address: snapshot.data['address']
    );
  }

  Stream <QuerySnapshot> get userSearchData{
    return (value==null)?Firestore.instance.collection("user_data").snapshots():Firestore.instance.collection("user_data").where("searchIndex",arrayContains: value).snapshots();
  }
  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }


  //Set or Update user data
  //This function is called whenever a user signs up for the first time, or when user wants to update their data
  Future updateAvatar(String avatarUrl ) async{
    //if document doesn't exist yet, firestore creates one automatically
    return await userDataCollection.document(uid).updateData({
      'avatarUrl':avatarUrl
    });
  }

}
