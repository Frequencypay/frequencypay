// Service class containing all Firestore operations
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frequencypay/models/contract_model.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/services/search_queries/contract_search_query.dart';

import 'contract_service.dart';

class FirestoreService {
  final String uid;
  final String value;

  FirebaseUser currentUser;

  Future _doneFuture;

  FirestoreService({
    this.uid,
    this.value
  }) {

    _doneFuture = getCurrentUser();
  } // V.I. When we create an instance of this service class, the UID must be passed,

  //so anytime we use this service class, we have the uid of the user (makes things more secure)

  Future get initializationDone => _doneFuture;

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
  Future createContractRequest(String requester, String loaner, String requesterName, String loanerName, String dueDate, RepaymentTerms terms) async{
    return await contractCollection.document(uid).setData({
      'requester':requester,
      'loaner':loaner,
      'requesterName':requesterName,
      'loanerName':loanerName,
      'dueDate':dueDate,
      'dateAccepted':null,
      'state':CONTRACT_STATE.OPEN_REQUEST.toString(),
      'waitState':WAIT_STATE.ON_LENDER.toString(),
      'terms':terms.toList(),
      'repaymentStatus':null,
      'scheduledTransactions': null,
    });
  }

  //This is called to attempt to accept a contract, making it an active, established contract which must be repaid between the two users.
  void acceptEstablishContract(Contract contract, List repaymentTransactions, List repaymentStatus, DateTime timeAccepted) async {

    //Perform any validation of the operation
    if (contract.requester == currentUser.uid && contract.loaner != currentUser.uid) {

      //Establish the contract
      _establishContract(contract.uid, contract, repaymentTransactions, repaymentStatus, timeAccepted);
    }
  }

  //This handles the actual process of establishing a contract.
  void _establishContract(String uid, Contract contract, List transactions, List repaymentStatus, DateTime timeAccepted) async{

    DocumentReference document = contractCollection.document(uid);

    //Update the state, mark the time accepted, add the repayment status, and add the scheduled transactions
    document.updateData({
      "state":CONTRACT_STATE.ACTIVE_CONTRACT.toString(),
      "waitState":WAIT_STATE.NONE.toString(),
      "dateAccepted": timeAccepted.toIso8601String(),
      "repaymentStatus": repaymentStatus,
      "scheduledTransactions":transactions
    });
  }

  //This is called to reject a contract request, making it unable to be accepted or further negotiated
  void rejectContract(Contract contract) {

    DocumentReference document = contractCollection.document(contract.uid);

    //Update the contract state
    document.updateData({"state":CONTRACT_STATE.REJECTED_REQUEST.toString(), "waitState":WAIT_STATE.NONE.toString()});
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
        uid: snapshot.documentID,
        terms: snapshot.data['terms'],
        dueDateString: snapshot.data['dueDate'],
        dateAccepted: snapshot.data['dateAccepted'],
        state: contractStateFromString(snapshot.data['state']),
        waitState: waitStateFromString(snapshot.data['waitState']),
        loaner: snapshot.data['loaner'],
        loanerName: snapshot.data['loanerName'],
        requester: snapshot.data['requester'],
        requesterName: snapshot.data['requesterName'],
        repayment: snapshot.data['repaymentStatus'],
        transactions: snapshot.data['scheduledTransactions'],
    );
  }

  Stream<Contract> get contract{
    return contractCollection.document(uid).snapshots().map(_contractFromSnapshot);
  }

  //Contract list from snapshots (retrieves all the active contracts a user has)
  //mapped to the custom contract model
  List<Contract> _contractListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc) { //perform an action for each document
      return Contract(
        uid: doc.documentID,
        terms: doc.data['terms'],
        dueDateString: doc.data['dueDate'],
        dateAccepted: doc.data['dateAccepted'],
        state: contractStateFromString(doc.data['state']),
        waitState: waitStateFromString(doc.data['waitState']),
        loaner: doc.data['loaner'],
        loanerName: doc.data['loanerName'],
        requester: doc.data['requester'],
        requesterName: doc.data['requesterName'],
        repayment: doc.data['repaymentStatus'],
        transactions: doc.data['scheduledTransactions'],
      );
    }).toList();
  }

  //Returns an arbitrary contract based on the given uid
  Stream<Contract> _retrieveContract(String uid) {

    return contractCollection.document(uid).snapshots().map(_contractFromSnapshot);
  }

  Stream<List<Contract>> retrieveContracts(ContractSearchQuery query) async*{

    //Wait for initialization to finish
    await initializationDone;

    //The resulting stream
    Stream<List<Contract>> contractsStream;

    //If the requester is required
    if (query.requirementMode == REQUIREMENT_MODE.REQUESTER) {
      contractsStream =
          contractCollection.where('state', isEqualTo: query.state.toString())
              .where('requester', isEqualTo: currentUser.uid)
              .snapshots().map(_contractListFromSnapshot);
    }

    //Assume loaner required otherwise
    else {
      contractsStream =
          contractCollection.where('state', isEqualTo: query.state.toString())
              .where('loaner', isEqualTo: currentUser.uid)
              .snapshots().map(_contractListFromSnapshot);
    }

    //Return the resulting contract stream
    yield* contractsStream;
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

  Future getCurrentUser() async {

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
