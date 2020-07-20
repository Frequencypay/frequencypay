import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frequencypay/blocs/landing_bloc.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/services/firebase_auth_service.dart';
import 'package:frequencypay/services/firestore_db_service.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  final String uid;
  LandingPage({Key key, this.uid}) : super(key: key);
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  static const Color blueHighlight = const Color(0xFF3665FF);

  FirebaseUser currentUser;
  final AuthService _auth = AuthService();

  String balance = "";
  @override
  initState() {
    //this.getCurrentUser();
    super.initState();
  }

  LandingBloc createBloc(var context,) {
    final user = Provider.of<User>(context, listen: false);

    LandingBloc bloc = LandingBloc(FirestoreService(uid: user.uid));

    bloc.add(LoadLandingEvent());

    return bloc;
  }

  @override
  Widget build(BuildContext context) {
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
                      text: 'Overview',
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, color: blueHighlight)),
                ],
              ),
            ),centerTitle: false,
            backgroundColor: Colors.white10,
            elevation: 0,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () async {
                  await _auth.signOut();
                },
                color: Colors.black45,
              )
            ],
          ),

          body: ListView(children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(width: 250,),
                    FlatButton.icon(
                      icon: Icon(Icons.person,color: Colors.grey,),
                      label: Text("Log out",style: TextStyle(color: Colors.grey),),
                      onPressed: () async {
                        await _auth.signOut();
                      },
                    ),
                  ],
                ),

              FlatButton.icon(
                icon: Icon(Icons.person,color: Colors.grey,),
                label: Text("Loan Request",style: TextStyle(color: Colors.grey),),
                onPressed: ()  {
                  Navigator.pushNamed(context, '/loan_request_page');
                },
              ),
          //ROW 1
                Row(
                  children: <Widget>[
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                      flex: 5,
                      child: BlocBuilder<LandingBloc, LandingState>(builder: (context, state) {
                        if (state is LandingIsLoadedState) {
                          return RichText(text:TextSpan(style: TextStyle(fontFamily: 'Leelawadee UI', fontSize: 25), children: <TextSpan> [
                            TextSpan(text: "Good Morning,\n", style: TextStyle(color: Colors.black45)),
                            TextSpan(text: state.getProfile.fname + ".\n", style: TextStyle(fontWeight: FontWeight.bold, color: blueHighlight)),
                            TextSpan(text: "<date>", style: TextStyle(color: Colors.grey, fontSize: 14))
                          ]));
                        } else if (state is LandingIsNotLoadedState) {
                          return RichText(text:TextSpan(style: TextStyle(fontFamily: 'Leelawadee UI', fontSize: 25), children: <TextSpan> [
                            TextSpan(text: "Good Morning,\n", style: TextStyle(color: Colors.black45)),
                            TextSpan(text: "error.\n", style: TextStyle(fontWeight: FontWeight.bold, color: blueHighlight)),
                            TextSpan(text: "error", style: TextStyle(color: Colors.grey, fontSize: 14))
                          ]));
                        } else {
                          return RichText(text:TextSpan(style: TextStyle(fontFamily: 'Leelawadee UI', fontSize: 25), children: <TextSpan> [
                            TextSpan(text: "Good Morning,\n", style: TextStyle(color: Colors.black45)),
                            TextSpan(text: "<name>.\n", style: TextStyle(fontWeight: FontWeight.bold, color: blueHighlight)),
                            TextSpan(text: "<date>", style: TextStyle(color: Colors.grey, fontSize: 14))
                          ]));
                        }},
                      ),
                    ),
                    Expanded(flex: 1, child: Container())
                  ],
                ),

                SizedBox(height: 30),

                //ROW 2
                Row(children: <Widget>[
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                      flex: 5,
                      child: Container(
                          height: 130,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              color: blueHighlight,
                              elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(children: <Widget>[
                                  Expanded(
                                      flex: 2,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                                flex: 1,
                                                child: Text("Congratulations!",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white))),
                                            Expanded(
                                                flex: 2, child: Container()),
                                            Expanded(
                                                flex: 1,
                                                child: Text("<message>",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white)))
                                          ])),
                                  Expanded(flex: 1, child: Container())
                                ]),
                              )))),
                  Expanded(flex: 1, child: Container())
                ]),

                SizedBox(height: 30),

                //ROW 3
                Row(
                  children: <Widget>[
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                        flex: 5,
                        child: Container(
                          height: 100,
                          child: Row(children: <Widget>[
                            Expanded(
                                flex: 1,
                                child: Stack(children: <Widget>[
                                  Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                          width: 90,
                                          height: 90,
                                          child: CircularProgressIndicator(
                                            backgroundColor: Colors.grey[300],
                                          ))),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "view\ncontracts",
                                        textAlign: TextAlign.center,
                                      ))
                                ])),
                            Expanded(
                                flex: 2,
                                child: Column(children: <Widget>[
                                  Expanded(
                                      flex: 1,
                                      child: Text("Your Progress",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey))),
                                  Expanded(
                                      flex: 1,
                                      child: Column(children: <Widget>[
                                        Text("<x>% of loans paid off"),
                                        Text("<time> until paid in full",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey))
                                      ])),
                                ]))
                          ]),
                        )),
                    Expanded(flex: 1, child: Container())
                  ],
                ),

                SizedBox(height: 30),

                //CONTACTS
                Row(children: <Widget>[
                  Expanded(flex: 1, child: Container()),
                  Expanded(flex: 3, child: Text("Contacts")),
                  Expanded(flex: 1, child: Container())
                ]),

                Container(height: 100, child: ListView.separated(
                  itemCount: 20,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => SizedBox(width: 5),
                  itemBuilder: (context, index) => buildContactListItem(context, index),

                ))
              ],
            ),
          ])),
    );
  }
  //Populates the contact listview
  Widget buildContactListItem(BuildContext context, int index) {

    //Create some space on the left border
    if (index == 0) {

      return SizedBox(width: MediaQuery.of(context).size.width/7);
    }

    return CircleAvatar();
  }

  //KEEP FOR REFERENCE
  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

//  getBalance() async{
//    PlaidRepository plaidBalanceResponseModel;
//  PlaidRepository plaidAPIClient = PlaidRepository();
//
//  plaidAPIClient.postPlaidBalances("access-sandbox-182847fd-8331-45a4-ab54-a8cafeaa0959").then((value) {
//    setState(() {
//      balance = value.accounts[0].balances.current.toString();
//    });
//  });
//  }
}
