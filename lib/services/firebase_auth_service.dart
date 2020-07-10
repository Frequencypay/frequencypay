//Service class containing all the Firebase Auth logic
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/services/firestore_db_service.dart';

class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance; //instance so we can use firebase auth. We use this whenever we want to interact with any authentication functionality inside this class (sign in / out / register, etc)

  //create user object (from model class) based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid:user.uid) :null; // get the model
  }

  //create user object (from model class) based on FirebaseUser
  //(Public version to avoid dependencies)
  User userFromFirebaseUser(FirebaseUser user){
  return user != null ? User(uid:user.uid) :null; // get the model
  }

  //Auth change user stream
  Stream<User> get user{ //custom user model
    return _auth.onAuthStateChanged.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  //Sign in anon
  Future signInAnon() async{
    try{
      AuthResult result=await _auth.signInAnonymously();
      FirebaseUser user=result.user;
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user; // user from firebase (not our model)
      return _userFromFirebaseUser(user); // transform to our custom model
    } catch(e){
      print(e.toString());
      return null;
    }
  }


  //Register with email and password
  Future registerWithEmailAndPassword(String email, String password,String name,String username, String phone,String pin) async{
    List<String> splitList=name.split(" ");
    List<String> indexList=[];

    try{
      AuthResult result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user; // user from firebase (not our model)

      //for searching functionality:
      for(int i=0; i<splitList.length;i++){
        for(int y=1; y<splitList[i].length+1;y++){
          if(i==1){ // we are on last name
            indexList.add(splitList[i-1].toLowerCase()+" "+splitList[i].substring(0,y).toLowerCase());
          }
          indexList.add(splitList[i].substring(0,y).toLowerCase());
          print((splitList[i].substring(0,y).toLowerCase()));
        }
      }

      //create a new document for the new user to save their user Data
      bool rememberMe = false;
      await FirestoreService(uid: user.uid).setOrUpdateUserData(name, email, username, phone,indexList,pin,rememberMe); //create an instance of the firestore db service (need to pass UID!) and then set the data for the first time
      return _userFromFirebaseUser(user); // transform to our custom model
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //Sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }


  //validation

  //get current user
  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _auth.currentUser();
    return user;
  }


}