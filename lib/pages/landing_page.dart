import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frequencypay/blocs/landing_bloc.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/services/contract_service.dart';
import 'package:frequencypay/services/firebase_auth_service.dart';
import 'package:frequencypay/services/firestore_db_service.dart';
import 'package:frequencypay/widgets/loan_request_button.dart';
import 'package:intl/intl.dart';
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

  LandingBloc createBloc(
    var context,
  ) {
    final user = Provider.of<User>(context, listen: false);

    FirestoreService firestoreService = FirestoreService(uid: user.uid);
    ContractService contractService = ContractService(firestoreService);

    LandingBloc bloc = LandingBloc(firestoreService, contractService);

    bloc.add(LoadLandingEvent());

    return bloc;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => createBloc(context),
      child: Scaffold(
          floatingActionButton:
              LoanRequestWidgets.LoanRequestFloatingActionButton(context),
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
            ),
            centerTitle: false,
            backgroundColor: Colors.white10,
            elevation: 0,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () async {
                  //await _auth.signOut();
//                  getOut();
                  Navigator.pushReplacementNamed(context, '/sign_in');

                },
                color: Colors.black45,
              )
            ],
          ),
          body: ListView(children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
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
                      child: _greetingMessage(),
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
                            Expanded(flex: 1, child: _progressCircle()),
                            Expanded(flex: 2, child: _progressMessage())
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

                Container(
                    height: 100,
                    child: ListView.separated(
                      itemCount: 20,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => SizedBox(width: 5),
                      itemBuilder: (context, index) =>
                          buildContactListItem(context, index),
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
      return SizedBox(width: MediaQuery.of(context).size.width / 7);
    }

    return CircleAvatar();
  }

  Widget _greetingMessage() {
    return BlocBuilder<LandingBloc, LandingState>(
      builder: (context, state) {
        if (state is LandingIsLoadedState) {
          return RichText(
              text: TextSpan(
                  style: TextStyle(fontFamily: 'Leelawadee UI', fontSize: 25),
                  children: <TextSpan>[
                TextSpan(
                    text: "Good Morning,\n",
                    style: TextStyle(color: Colors.black45)),
                TextSpan(
                    text: state.getProfile.fname + ".\n",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: blueHighlight)),
                TextSpan(
                    text: _displayDate(),
                    style: TextStyle(color: Colors.grey, fontSize: 14))
              ]));
        } else if (state is LandingIsNotLoadedState) {
          return RichText(
              text: TextSpan(
                  style: TextStyle(fontFamily: 'Leelawadee UI', fontSize: 25),
                  children: <TextSpan>[
                TextSpan(
                    text: "Good Morning,\n",
                    style: TextStyle(color: Colors.black45)),
                TextSpan(
                    text: "error.\n",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: blueHighlight)),
                TextSpan(
                    text: "error",
                    style: TextStyle(color: Colors.grey, fontSize: 14))
              ]));
        } else {
          return RichText(
              text: TextSpan(
                  style: TextStyle(fontFamily: 'Leelawadee UI', fontSize: 25),
                  children: <TextSpan>[
                TextSpan(
                    text: "Good Morning,\n",
                    style: TextStyle(color: Colors.black45)),
                TextSpan(
                    text: "<name>.\n",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: blueHighlight)),
                TextSpan(
                    text: "<date>",
                    style: TextStyle(color: Colors.grey, fontSize: 14))
              ]));
        }
      },
    );
  }

  Widget _progressCircle() {
    return ClipOval(
      child: Material(
        child: InkWell(
          onTap: () => {Navigator.pushNamed(context, "/user_contracts")},
          child: Stack(children: <Widget>[
            Align(
                alignment: Alignment.center,
                child: SizedBox(
                    width: 90,
                    height: 90,
                    child: BlocBuilder<LandingBloc, LandingState>(
                        builder: (context, state) {
                      if (state is LandingIsLoadedState) {

                        //If a repayment overview exists
                        if (state.getRepaymentOverview != null) {
                          return CircularProgressIndicator(
                            backgroundColor: Colors.grey[300],
                            value: double.parse(
                                state.getRepaymentOverview.percentCompletion) /
                                100,
                          );
                        } else {

                          return CircularProgressIndicator(
                            backgroundColor: Colors.grey[300],
                            value: 0,
                          );
                        }
                      } else if (state is LandingIsLoadingState) {

                        return CircularProgressIndicator(
                          backgroundColor: Colors.grey[300],
                        );
                      } else {

                        return CircularProgressIndicator(
                          backgroundColor: Colors.grey[300],
                          value: 0,
                        );
                      }
                    }))),
            Align(
                alignment: Alignment.center,
                child: Text("view\ncontracts",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14)))
          ]),
        ),
      ),
    );
  }

  Widget _progressMessage() {
    return BlocBuilder<LandingBloc, LandingState>(builder: (context, state) {
      if (state is LandingIsLoadedState) {

        if (state.getRepaymentOverview != null) {
          return Column(children: <Widget>[
            Expanded(
                flex: 1,
                child: Text("Your Progress",
                    style: TextStyle(fontSize: 18, color: Colors.grey))),
            Expanded(
                flex: 1,
                child: Column(children: <Widget>[
                  Text(state.getRepaymentOverview.percentCompletion +
                      "% of loans paid off"),
                  Text(
                      "Paid in full in " +
                          state.getRepaymentOverview.timeUntilCompletion,
                      style: TextStyle(fontSize: 14, color: Colors.grey))
                ])),
          ]);
        } else {

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Text("Future progress here",
                style: TextStyle(fontSize: 14, color: Colors.grey))
          ]);
        }
      } else if (state is LandingIsLoadingState) {

        return Column(children: <Widget>[
          Expanded(
              flex: 1,
              child: Text("Your Progress",
                  style: TextStyle(fontSize: 18, color: Colors.grey))),
          Expanded(
              flex: 1,
              child: Text("loading your progress...",
                  style: TextStyle(fontSize: 14, color: Colors.grey))),
        ]);
      } else {

        return Column(children: <Widget>[
          Expanded(
              flex: 1,
              child: Text("Your Progress",
                  style: TextStyle(fontSize: 18, color: Colors.grey))),
          Expanded(
              flex: 1,
              child: Text("error",
                  style: TextStyle(fontSize: 14, color: Colors.grey))),
        ]);
      }
    });
  }

  String _displayDate() {
    return DateFormat.yMMMMd().format(DateTime.now());
  }

  //KEEP FOR REFERENCE
  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

  void getOut(){
      FirebaseAuth.instance.signOut();
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
