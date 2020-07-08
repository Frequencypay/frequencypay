import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frequencypay/blocs/profile_bloc.dart';
import 'package:frequencypay/models/plaid/models.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/plaid_link/plaid_link_webview.dart';
import 'package:frequencypay/repositories/plaid/plaid_repository.dart';
import 'package:frequencypay/services/firebase_auth_service.dart';
import 'package:frequencypay/services/firestore_db_service.dart';
import 'package:frequencypay/vaulted_pages/firebase_authentication.dart';
import 'package:provider/provider.dart';

void main() => runApp(MaterialApp(
      home: ProfileScreen(),
    ));

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String plaidText = "";
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
    return BlocProvider(
      create: (context) => createBloc(context),
      child: Scaffold(
          body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              SafeArea(
                child: Row(
                  children: <Widget>[
                    Text(
                      "  Your ",
                      style: TextStyle(color: Colors.grey, fontSize: 30),
                    ),
                    Text(
                      "Profile ",
                      style: TextStyle(color: Colors.blue, fontSize: 30),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: profileImg(),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: profileInfo(),
              ),
              SizedBox(
                height: 40,
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
              RaisedButton(
                child: Text("Plaid"),
                color: Colors.blue,
                onPressed: showPlaidView,
              ),
              SelectableText(plaidText),
            ],
          ),
        ],
      )),
    );
  }

  Widget profileImg() {
    return CircleAvatar(
      child: Text("loaded from DB"),
      radius: 60,
    );
  } // end profileImg

  Widget profileInfo() {
    return Column(
      children: <Widget>[
        BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (state is ProfileIsLoadedState) {
            return Text(
              state.getProfile.name,
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
          ],
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

  showPlaidView() {
    String clientID = "5cb68305fede9b00136aebb1";
    String secret = "54621c4436011f708c7916587c6fa8";

    PlaidLink plaidLink = PlaidLink();
    plaidLink.launch(context, (Result result) {
      getAccessToken(clientID, secret, result.token);
    });
  }

  getAccessToken(clientID, secretKey, publicToken) async {
    PlaidPublicTokenExchangeResponseModel accessTokenModel;

    PlaidRepository plaid = PlaidRepository();
    plaid.signInWithCredentials(clientID, secretKey, publicToken).then((value) {
      setState(() {
        plaidText = value.access_token;
      });
    });
    plaidText = accessTokenModel.access_token;
  }
}
