import 'dart:io';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frequencypay/blocs/profile_bloc.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/services/firestore_db_service.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

void main() => runApp(MaterialApp(
  home: ProfileScreen(),
));

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  static const Color blueHighlight = const Color(0xFF3665FF);

  File _image;
  final picker = ImagePicker();
  String  _uploadedFileUrl;
  String finalUrl;
  ProfileBloc createBloc(
      var context,
      ) {
    final user = Provider.of<User>(context, listen: false);

    ProfileBloc bloc = ProfileBloc(FirestoreService(uid: user.uid));

    bloc.add(LoadProfileEvent());

    return bloc;
  }

  @override
  Widget build(BuildContext context) {
    Future uploadFile(BuildContext context) async {
      String fileName = basename(_image.path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref()
          .child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      firebaseStorageRef.getDownloadURL().then((fileURL) async { //X
        print("Profile Picture uploaded");
        _uploadedFileUrl = fileURL;
        print(_uploadedFileUrl);
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text('Profile Picture Uploaded')));
        FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
        FirestoreService serviceInstance = FirestoreService(
            uid: currentUser.uid);
        serviceInstance.updateAvatar(_uploadedFileUrl);
        Navigator.pushReplacementNamed(context, '/profile_page');
      });
    }

    Future getImage() async {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        _image = File(pickedFile.path);
      });
      uploadFile(context);
    }

    return BlocProvider(
      create: (context) => createBloc(context),
      child: Scaffold(
          appBar: AppBar(
            title: RichText(
              text: new TextSpan(
                // Note: Styles for TextSpans must be explicitly defined.
                // Child text spans will inherit styles from parent
                style: new TextStyle(
                  fontSize: 25.0,
                  color: Colors.black45,
                ),
                children: <TextSpan>[
                  new TextSpan(text: 'Your '),
                  new TextSpan(
                      text: 'Profile',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, color: blueHighlight)),
                ],
              ),
            ),
            centerTitle: false,
            backgroundColor: Colors.white10,
            elevation: 0,
          ),
          body: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[

                  SizedBox(
                    height: 10,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: <Widget>[
                      SizedBox(width: 40,),
                      Container(
                        child: profileInfo(),
                      ),
                      IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () async{
                          getImage();
                        },
                      ),
                    ],
                  ),


                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Text(
                            "x  Late Payments",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Text(
                            "y Active Contracts",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: Text(
                            "z Complete Contracts",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                    ],

                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Confidence Rating",
                    style: TextStyle(color: Colors.black54, fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Container(
                    child: getConfidenceRating(),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: getMailandPhone(),
                  ),
                  RaisedButton(
                    child: Text(
                      "Edit",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Colors.grey,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          )),
    );
  }


  Widget profileInfo() {
    return Column(
      children: <Widget>[
        BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (state is ProfileIsLoadedState) {
            return CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blue,
              child: ClipOval(
                child: SizedBox(
                  width: 180.0,
                  height: 180.0,
                  child:(state.getProfile.avatarUrl !=null)? Image.network(state.getProfile.avatarUrl,fit:BoxFit.fill):Image(image: AssetImage('assets/temp_logo.png'),),
                ),
              ),
            );
          } else if (state is ProfileIsNotLoadedState) {
            return Text(
              "error",
              style: TextStyle(color: Colors.black54, fontSize: 25),
            );
          } else {
            return Text(
              "<<fname>> <<lname>>",
              style: TextStyle(color: Colors.black54, fontSize: 25),
            );
          }
        }),

        BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (state is ProfileIsLoadedState) {
            return Text(
              state.getProfile.fname,
              style: TextStyle(color: Colors.black54, fontSize: 25),
            );
          } else if (state is ProfileIsNotLoadedState) {
            return Text(
              "error",
              style: TextStyle(color: Colors.black54, fontSize: 25),
            );
          } else {
            return Text(
              "<<fname>> <<lname>>",
              style: TextStyle(color: Colors.black54, fontSize: 25),
            );
          }
        }),
        BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (state is ProfileIsLoadedState) {
            return Text(
              state.getProfile.username,
              style: TextStyle(color: Colors.black54, fontSize: 17),
            );
          } else if (state is ProfileIsNotLoadedState) {
            return Text(
              "error",
              style: TextStyle(color: Colors.black54, fontSize: 17),
            );
          } else {
            return Text(
              "<<fname>> <<lname>>",
              style: TextStyle(color: Colors.black54, fontSize: 25),
            );
          }
        }),
        SizedBox(
          height: 20,
        ),

      ],
    );
  } // end profile info

  Widget getConfidenceRating() {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.blue,
      child: Text(
        "100%",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  } // end getConfidenceRating

  Widget getMailandPhone() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              "  Email Address:",
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
              if (state is ProfileIsLoadedState) {
                return Text(
                  "  " + state.getProfile.email,
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                );
              } else if (state is ProfileIsNotLoadedState) {
                return Text(
                  "  error",
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                );
              } else {
                return Text(
                  "  <<email>>",
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                );
              }
            }),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: <Widget>[
            Text(
              "  Phone Number",
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
              if (state is ProfileIsLoadedState) {
                return Text(
                  "  " + state.getProfile.phoneNumber,
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                );
              } else if (state is ProfileIsNotLoadedState) {
                return Text(
                  "  error",
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                );
              } else {
                return Text(
                  "  <<phone number>>",
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                );
              }
            }),
          ],
        ),
      ],
    );
  }
}

