import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frequencypay/blocs/loan_request_bloc.dart';
import 'package:frequencypay/models/contract_model.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/services/firebase_auth_service.dart';
import 'package:frequencypay/services/firestore_db_service.dart';
import 'package:provider/provider.dart';

class LoanRequest extends StatefulWidget {
  LoanRequest({Key key}) : super(key: key);

  @override
  _LoanRequestState createState() => _LoanRequestState();
}

class _LoanRequestState extends State<LoanRequest> {
  static const Color blueHighlight = const Color(0xFF3665FF);

  LoanRequestBloc bloc;

  TextEditingController dueDateInputController;
  FirebaseUser currentUser;

  _LoanRequestState();

  double amount = 0;
  double paymentsOf = 0;
  int weeks = 0;
  double paymentsTotal = 0;

  @override
  initState() {
    dueDateInputController = new TextEditingController();

    this.getCurrentUser();
    super.initState();
  }

  LoanRequestBloc createBloc(
    var context,
  ) {
    final user = Provider.of<User>(context, listen: false);

    bloc = LoanRequestBloc(FirestoreService(uid: user.uid));

    bloc.add(LoadLoanRequestEvent());

    return bloc;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => createBloc(context),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    BackButton(color: blueHighlight),
                    Text(
                      "  Contract ",
                      style: TextStyle(color: Colors.grey, fontSize: 25),
                    ),
                    Text(
                      "Creation ",
                      style: TextStyle(color: Colors.blue, fontSize: 25),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                getBillIssuer(),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: selectLender(),
                    ),
                    Expanded(
                      flex: 2,
                      child: getDueDate(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                specifyBillAmt(),
                SizedBox(
                  height: 20,
                ),
                specifyRepaymentTerms(),
                SizedBox(
                  height: 20,
                ),
                specifyRepaymentMethod(),
                SizedBox(
                  height: 20,
                ),
                submitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getBillIssuer() {
    return Column(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.blue[900],
          child: Text("ISSUER"),
          radius: 50,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "<<Bill Issuer>>",
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
      ],
    );
  }

  Widget selectLender() {
    return BlocBuilder<LoanRequestBloc, LoanRequestState>(
        builder: (context, state) {
      if (state is LoanRequestIsLoadedState) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: 13,
            ),
            Text(
              "Select Lender",
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
            Text(
              "Lender: " +
                  ((state.getLender == null) ? "none" : state.getLender.fname),
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            FlatButton.icon(
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.green,
                size: 40,
              ),
              onPressed: () {
                openLenderSelectionPage(context);
              },
              label: Text(""),
            )
          ],
        );
      } else if (state is LoanRequestIsNotLoadedState) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: 13,
            ),
            Text(
              "Select Lender",
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
            Text(
              "Lender: " + "error",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            FlatButton.icon(
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.green,
                size: 40,
              ),
              onPressed: () {
                openLenderSelectionPage(context);
              },
              label: Text(""),
            )
          ],
        );
      } else {
        return Column(
          children: <Widget>[
            SizedBox(
              height: 13,
            ),
            Text(
              "Select Lender",
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
            Text(
              "Lender: ",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            FlatButton.icon(
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.green,
                size: 40,
              ),
              onPressed: () {
                openLenderSelectionPage(context);
              },
              label: Text(""),
            )
          ],
        );
      }
    });
  }

  //Pushes to the user searching screen and receives the selected user
  void openLenderSelectionPage(BuildContext context) async {
    var result = await Navigator.pushNamed(context, '/search_users');

    bloc.add(SetLenderLoanRequestEvent(result));
  }

  Widget getDueDate() {
    return Column(
      children: <Widget>[
        Text(
          "Due Date",
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: dueDateInputController,
          decoration: InputDecoration(
            hintText: "eg: 5/25/2020",
          ),
        ),
      ],
    );
  }

  Widget specifyBillAmt() {
    return Column(
      children: <Widget>[
        Text(
          "Bill Amount:",
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: FlatButton.icon(
                icon: Icon(
                  Icons.remove_circle,
                  color: Colors.deepPurple,
                  size: 50,
                ),
                label: Text(""),
                onPressed: () {
                  setState(() {
                    amount -= 1;
                    paymentsTotal = amount / paymentsOf;
                  });
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                " \$ $amount",
                style: TextStyle(color: Colors.grey, fontSize: 30),
              ),
            ),
            Expanded(
              flex: 2,
              child: FlatButton.icon(
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.deepPurple,
                  size: 50,
                ),
                label: Text(""),
                onPressed: () {
                  setState(() {
                    amount += 1;
                    paymentsTotal = amount / paymentsOf;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget specifyRepaymentTerms() {
    return Column(
      children: <Widget>[
        Text(
          "Repayment Terms:",
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Expanded(
                flex: 3,
                child: Text(
                  "Payments of:",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                )),
            Expanded(
              flex: 2,
              child: FlatButton.icon(
                icon: Icon(
                  Icons.remove_circle,
                  color: Colors.grey[900],
                  size: 40,
                ),
                label: Text(""),
                onPressed: () {
                  setState(() {
                    paymentsOf -= 1;
                    paymentsTotal = amount / paymentsOf;
                  });
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                " \$ $paymentsOf",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ),
            Expanded(
              flex: 2,
              child: FlatButton.icon(
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.grey[900],
                  size: 40,
                ),
                label: Text(""),
                onPressed: () {
                  setState(() {
                    paymentsOf += 1;
                    paymentsTotal = amount / paymentsOf;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Expanded(
                flex: 3,
                child: Text(
                  "Every:",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                )),
            Expanded(
              flex: 2,
              child: FlatButton.icon(
                icon: Icon(
                  Icons.remove_circle,
                  color: Colors.grey[900],
                  size: 40,
                ),
                label: Text(""),
                onPressed: () {
                  setState(() {
                    weeks -= 1;
                  });
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                "$weeks Weeks",
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ),
            Expanded(
              flex: 2,
              child: FlatButton.icon(
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.grey[900],
                  size: 40,
                ),
                label: Text(""),
                onPressed: () {
                  setState(() {
                    weeks += 1;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          "$paymentsTotal Payments total",
          style: TextStyle(color: Colors.grey[900], fontSize: 15),
        ),
      ],
    );
  }

  Widget specifyRepaymentMethod() {
    return Row(
      children: <Widget>[
        Text("   "),
        Expanded(
          flex: 2,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 13,
              ),
              Text(
                "Repayment Method",
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
              FlatButton.icon(
                icon: Icon(
                  Icons.add_circle_outline,
                  color: Colors.green,
                  size: 40,
                ),
                onPressed: () {},
                label: Text(""),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 13,
              ),
              Text(
                "ACH Details",
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
              FlatButton.icon(
                icon: Icon(
                  Icons.add_circle_outline,
                  color: Colors.green,
                  size: 40,
                ),
                onPressed: () {},
                label: Text(""),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget submitButton() {
    return BlocBuilder<LoanRequestBloc, LoanRequestState>(
        builder: (context, state) {
      if (state is LoanRequestIsLoadedState) {
        return RaisedButton(
          color: Colors.blue,
          child: Text(
            "Submit",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () {

            sumbitContract(state.getLocalUser, state.getLender);
          },
        );
      } else if (state is LoanRequestIsNotLoadedState) {
        return RaisedButton(
          color: Colors.blue,
          child: Text(
            "Submit",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        );
      } else {
        return RaisedButton(
          color: Colors.blue,
          child: Text(
            "Submit",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        );
      }
    });
  }

  void sumbitContract(UserData localUser, UserData lender) async {
    RepaymentTerms terms = RepaymentTerms(amount, paymentsOf, weeks);

    if (validateTerms(terms)) {

      bloc.add(
          SubmitLoanRequestEvent(localUser, lender, DateTime.now(), terms, _onContractSubmitted));
    }
  }

  //Validates terms according to the interface requirements
  bool validateTerms(RepaymentTerms terms) {

    bool valid = true;

    if (terms.amount <= 0 || terms.repaymentAmount <= 0 || terms.frequencyWeeks <= 0) {
      valid = false;
    }

    if (terms.repaymentAmount > terms.amount) {
      valid = false;
    }

    return valid;
  }

  //This is a callback function used to exit the screen after a successful contract request submission
  void _onContractSubmitted() {

    //Pop the screen
    Navigator.pop(context);
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }
}
