import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frequencypay/blocs/landing_bloc.dart';
import 'package:frequencypay/blocs/plaid/bloc_plaid_balance.dart';
import 'package:frequencypay/blocs/plaid/plaid_event_balance.dart';
import 'package:frequencypay/blocs/plaid/plaid_state_balance.dart';
import 'package:frequencypay/blocs/plaid/token/bloc_plaid_token.dart';
import 'package:frequencypay/blocs/plaid/token/plaid_blocs.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/pages/plaid_link_splash_screen.dart';
import 'package:frequencypay/plaid_link/plaid_link_webview.dart';
import 'package:frequencypay/repositories/plaid/plaid_api_client.dart';
import 'package:frequencypay/repositories/plaid/plaid_repository.dart';
import 'package:frequencypay/services/contract_service.dart';
import 'package:frequencypay/services/firebase_auth_service.dart';
import 'package:frequencypay/services/firestore_db_service.dart';
import 'package:frequencypay/widgets/loan_request_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class LandingPage extends StatefulWidget {
  final String uid;
  final PlaidRepository plaidRepository = PlaidRepository(
    plaidAPIClient: PlaidAPIClient(
      httpClient: http.Client(),
    ),
  );

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
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);

    FirestoreService firestoreService = FirestoreService(uid: user.uid);
    ContractService contractService = ContractService(firestoreService);
    return MultiBlocProvider(
      providers: [
        BlocProvider<LandingBloc>(create: (BuildContext context) {
          LandingBloc bloc = LandingBloc(firestoreService, contractService);
          bloc.add(LoadLandingEvent());
          return bloc;
        }),
        BlocProvider<BlocPlaidBalance>(
            create: (BuildContext context) =>
                BlocPlaidBalance(plaidRepository: widget.plaidRepository))
      ],
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white10,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () async {
                  await _auth.signOut();
                },
                color: Colors.black45,
              )
            ],
          ),
          floatingActionButton:
              LoanRequestWidgets.LoanRequestFloatingActionButton(context),
//          appBar: CustomAppBar('Overview', context),
          body: ListView(children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: <Widget>[
                      _greetingMessage(),
                    ],
                  ),
                ),
                _balance(),

                SizedBox(height: 30),
                Container(
                  height: 130,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      color: blueHighlight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text("Congratulations!",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white)),
                            )
                          ],
                        ),
                      )),
                ),
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
              ],
            ),
          ])),
    );
  }

  _balance() {
    return BlocBuilder<BlocPlaidBalance, PlaidStateBalance>(
      builder: (context, state) {
        if (state is PlaidBalanceInitial) {
          BlocProvider.of<BlocPlaidBalance>(context).add(BalanceRequested());
          return Text("initial loading balance");
        }
        if (state is PlaidBalanceLoadSuccess) {
          return RichText(
              text: TextSpan(
                  style: TextStyle(fontFamily: 'Leelawadee UI', fontSize: 25),
                  children: <TextSpan>[
                TextSpan(
                    text: "Balance: \$",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: blueHighlight)),
                TextSpan(
                    text: state.plaidBalanceResponseModel.accounts[0].balances
                        .available
                        .toString(),
                    style: TextStyle(color: Colors.grey))
              ]));
        } else if (state is PlaidBalanceLoadInProgress) {
          print('loading balance');
          return Text('loading balance');
        }
        if (state is PlaidBalanceLoadFailure) {
          print('failed to load balance');
          return FlatButton(
              onPressed: () => MaterialPageRoute(
                  builder: (context) => PlaidLinkSplashScreen()),
              child: Text('load plaid balance'));
        }
        return Container();
      },
    );
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
                            value: double.parse(state
                                    .getRepaymentOverview.percentCompletion) /
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

  void getOut() {
    FirebaseAuth.instance.signOut();
  }
}
