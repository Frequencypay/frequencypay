import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frequencypay/blocs/contract_details_bloc.dart';
import 'package:frequencypay/models/contract_model.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/route_arguments/contract_details_arguments.dart';
import 'package:frequencypay/services/contract_service.dart';
import 'package:frequencypay/services/firestore_db_service.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class ContractDetails extends StatefulWidget {
  ContractDetails();

  @override
  _ContractDetailsState createState() => _ContractDetailsState();
}

class _ContractDetailsState extends State<ContractDetails> {
  static const Color blueHighlight = const Color(0xFF3665FF);

  ContractDetailsBloc bloc;

  //The contract being described
  Contract contract;

  _ContractDetailsState();

  ContractDetailsBloc createBloc(var context, Contract contract) {
    final user = Provider.of<User>(context, listen: false);

    FirestoreService firestoreService = FirestoreService(uid: user.uid);
    ContractService contractService = ContractService(firestoreService);

    bloc = ContractDetailsBloc(firestoreService, contractService);

    bloc.add(LoadContractDetailsEvent(contract));

    print("Selected contract transactions: " +
        contract.scheduledTransactions.toString());

    return bloc;
  }

  @override
  Widget build(BuildContext context) {
    //Extracting the contract assigned to load this page
    final ContractDetailsArguments arguments =
        ModalRoute.of(context).settings.arguments;

    //Retrieve the contract from the route arguments
    contract = arguments.contract;

    return BlocProvider(
      create: (context) => createBloc(context, contract),
      child: Scaffold(
//      appBar: AppBar(title: Text('Your' + contract()),),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                greetingMessage(),
                SizedBox(height: 25),
                getBillIssuer(),
                Visibility(visible: contract.state == CONTRACT_STATE.ACTIVE_CONTRACT, child: SizedBox(height: 25)),
                Visibility(visible: contract.state == CONTRACT_STATE.ACTIVE_CONTRACT, child: getProgress()),
                Visibility(visible: contract.state == CONTRACT_STATE.ACTIVE_CONTRACT, child: SizedBox(height: 35)),
                summaryBanner(),
                Visibility(visible: contract.state == CONTRACT_STATE.ACTIVE_CONTRACT, child: SizedBox(height: 35)),
                Visibility(visible: contract.state == CONTRACT_STATE.ACTIVE_CONTRACT, child: makePaymentButton()),
                Visibility(visible: true, child: SizedBox(height: 35)),
                RepaymentInfo(),
                Visibility(visible: true, child: SizedBox(height: 15)),
                ContractDetailsInfo(),
                Visibility(visible: contract.state == CONTRACT_STATE.ACTIVE_CONTRACT, child: SizedBox(height: 30)),
                Visibility(visible: contract.state == CONTRACT_STATE.ACTIVE_CONTRACT, child: getHistory()),
                Visibility(visible: true, child: SizedBox(height: 30)),
                Visibility(visible: contract.state == CONTRACT_STATE.OPEN_REQUEST, child: responseButtons()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget greetingMessage() {

    return Row(
      children: <Widget>[
        BackButton(color: blueHighlight),
        Text("  Your ",
            style:
            TextStyle(color: Color(0xFF8C8C8C), fontSize: 18)),
        Text("Contract ",
            style: TextStyle(
                color: blueHighlight,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget getBillIssuer() {
    return Column(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.blue[900],
          child: Text("ISSUER"),
          radius: 35,
        ),
        SizedBox(height: 20),
        Text("<<Bill Issuer>>",
            style: TextStyle(fontSize: 18, color: Color(0xFF575757))),
      ],
    );
  }

  Widget getProgress() {

    return BlocBuilder<ContractDetailsBloc, ContractDetailsState>(
        builder: (context, state) {
      if (state is ContractDetailsIsLoadedState) {
        return new LinearPercentIndicator(
          width: 235,
          lineHeight: 8.0,
          progressColor: Color(0xFFB64FFA),
          alignment: MainAxisAlignment.center,
        );
      } else if (state is ContractDetailsIsLoadingState) {
        return new LinearPercentIndicator(
          width: 235,
          lineHeight: 8.0,
          progressColor: Color(0xFFB64FFA),
          alignment: MainAxisAlignment.center,
        );
      } else {
        return new LinearPercentIndicator(
          width: 235,
          lineHeight: 8.0,
          progressColor: Color(0xFFB64FFA),
          alignment: MainAxisAlignment.center,
        );
      }
    });
  }

  Widget summaryBanner() {
    return Row(
      children: <Widget>[
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 5,
          child: Column(
            children: <Widget>[
              CircleAvatar(
                child: Text("User"),
                radius: 20,
              ),
              Text(contract.loanerName + " paid on ",
                  style: TextStyle(color: Color(0xFF595959), fontSize: 10)),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: Text("Repay in full on <<month>>/<<day>>",
              style: TextStyle(color: Color(0xFF595959), fontSize: 10)),
        ),
        Expanded(
          flex: 5,
          child: Column(
            children: <Widget>[
              Text("<<AMOUNT>>",
                  style: TextStyle(
                      color: blueHighlight,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Text("remaining for repayment",
                  style: TextStyle(color: Color(0xFF595959), fontSize: 10)),
            ],
          ),
        ),
        Expanded(flex: 1, child: Container()),
      ],
    );
  }

  Widget makePaymentButton() {
    return RaisedButton(
      child: Text("Make Payment",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
      onPressed: () {},
      color: Color(0xFFB64FFA),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
      elevation: 10,
    );
  }

  Widget RepaymentInfo() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: blueHighlight,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Repayment",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
            SizedBox(height: 25),
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Text("<<Payments>> payments",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white, fontSize: 11))),
                Expanded(
                    flex: 1,
                    child: Text("\$<<Amount>>",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold))),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Text("remaining",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white, fontSize: 11))),
                Expanded(
                    flex: 1,
                    child: Text("Every <<Period>>",
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.white, fontSize: 11))),
              ],
            ),
          ],
        ));
  }

  Widget ContractDetailsInfo() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: blueHighlight,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Contract Details",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
            SizedBox(height: 25),
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Text("<<User>> paid <<Amount>>",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white, fontSize: 11))),
                Expanded(
                    flex: 1,
                    child: Text("Bill due date",
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.white, fontSize: 11))),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Text("to <<Bill Issuer>>",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white, fontSize: 11))),
                Expanded(
                    flex: 1,
                    child: Text("<<Month>> <<DayOrdinal>>",
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.white, fontSize: 11))),
              ],
            ),
          ],
        ));
  }

  Widget getHistory() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [BoxShadow(blurRadius: 5.0)],
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("History",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Color(0xFF8C8C8C), fontSize: 11)),
              ],
            ),
            SizedBox(height: 15),
            historyEvent(),
            SizedBox(height: 10),
            historyEvent(),
            SizedBox(height: 10),
            historyEvent(),
          ],
        ));
  }

  Widget historyEvent() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: CircleAvatar(
            radius: 20,
            child: Text("user"),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: <Widget>[
              Text("You paid <<User>>",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Color(0xFF595959), fontSize: 10)),
              Text("<<Month>> <<Day>>",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Color(0xFF8C8C8C), fontSize: 10)),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Text("<<Amount>>",
              textAlign: TextAlign.right,
              style: TextStyle(color: Color(0xFF68BA76), fontSize: 11)),
          //color for positive value (0xFF68BA76)
          //color for negative value (0xFFEE5353)
        )
      ],
    );
  }

  Widget responseButtons() {

    return BlocBuilder<ContractDetailsBloc, ContractDetailsState>(
      builder: (context, state) {
        if (state is ContractDetailsIsLoadedState) {
          return FlatButton(
              child: Text("Accept",
                  style: TextStyle(color: Colors.grey)),
              color: Colors.white24,
              onPressed: () {
                //Attempt to establish the contract
                bloc.add(EstablishContractContractDetailsEvent());


              });
        } else if (state is ContractDetailsIsNotLoadedState) {
          return FlatButton(
              child: Text("Accept",
                  style: TextStyle(color: Colors.grey)),
              color: Colors.white24,
              onPressed: null);
        } else {
          return FlatButton(
              child: Text("Accept",
                  style: TextStyle(color: Colors.grey)),
              color: Colors.white24,
              onPressed: null);
        }
      },
    );
  }
}
