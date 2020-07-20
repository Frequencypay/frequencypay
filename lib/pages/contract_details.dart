import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frequencypay/models/contract_model.dart';
import 'package:frequencypay/route_arguments/contract_details_arguments.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ContractDetails extends StatefulWidget {

  ContractDetails();
  @override
  _ContractDetailsState createState() => _ContractDetailsState();
}

class _ContractDetailsState extends State<ContractDetails> {

  static const Color blueHighlight = const Color(0xFF3665FF);

  _ContractDetailsState();

  @override
  Widget build(BuildContext context) {

    //Extracting the contract assigned to load this page
    final ContractDetailsArguments arguments = ModalRoute.of(context).settings.arguments;

    //The contract to use
    final Contract contract = arguments.contract;

    return Scaffold(
//      appBar: AppBar(title: Text('Your' + contract()),),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10,),
              Row(
                children: <Widget>[
                  BackButton(color: blueHighlight),
                  Text("  Your ",
                    style: TextStyle(color: Colors.grey, fontSize: 25),),
                  Text("Contract ",
                    style: TextStyle(color: Colors.blue, fontSize: 25),),
                ],
              ),
              SizedBox(height: 20,),
              getBillIssuer(),
              SizedBox(height: 25,),
              getProgress(),
              SizedBox(height: 25,),
              summaryBanner(),
              SizedBox(height: 25,),
              makePaymentButton(),
              SizedBox(height: 25,),
              RepaymentInfo(),
              ContractDetailsInfo(),
              getHistory(),

            ],
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
        SizedBox(height: 10,),
        Text("<<Bill Issuer>>",
          style: TextStyle(fontSize: 20, color: Colors.grey),),
      ],
    );
  }

  Widget getProgress() {
    return new LinearPercentIndicator(
      width: 200,
      lineHeight: 10.0,
      percent: 0,
      progressColor: Colors.deepPurple,
      alignment: MainAxisAlignment.center,
    );
  }

  Widget summaryBanner() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            children: <Widget>[
              CircleAvatar(
                child: Text("User"),
                radius: 30,
              ),
              Text("<<User>> paid on <<Month>><<Day>>",
                style: TextStyle(color: Colors.grey, fontSize: 15),),
            ],
          ),
        ),

        Expanded(
          flex: 2,
          child: Text("Repay in full on <<month>>/<<day>>",
            style: TextStyle(color: Colors.grey, fontSize: 15),),
        ),

        Expanded(
          flex: 2,
          child: Column(
            children: <Widget>[
              Text("AMOUNT", style: TextStyle(color: Colors.blue, fontSize: 25),),
              Text("  remaining for repayment",
                style: TextStyle(color: Colors.grey, fontSize: 15),),
            ],
          ),
        ),
      ],
    );
  }

  Widget makePaymentButton() {
    return RaisedButton(
      child: Text(
        "Make Payment", style: TextStyle(color: Colors.white, fontSize: 20),),
      onPressed: () {},
      color: Colors.deepPurple,
      padding: EdgeInsets.fromLTRB(60, 10, 60, 10),

    );
  }

  Widget RepaymentInfo() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
        margin: EdgeInsets.all(20),
        color: Colors.blue,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Repayment", style: TextStyle(color: Colors.white, fontSize: 20,)),
              ],
            ),
            SizedBox(height: 15,),
            Row(
              children: <Widget>[
                Expanded(flex:1,child: Text("X Payments remaining", style: TextStyle(color: Colors.white, fontSize: 15,))),
                Expanded(flex:1,child: Text("Amount, every X Weeks", style: TextStyle(color: Colors.white, fontSize: 15,))),
              ],
            ),
          ],
        )
    );
  }

  Widget ContractDetailsInfo() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
        margin: EdgeInsets.all(20),
        color: Colors.blue,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Contract Details", style: TextStyle(color: Colors.white, fontSize: 20,)),
              ],
            ),
            SizedBox(height: 15,),
            Row(
              children: <Widget>[
                Expanded(flex:1,child: Text("<<User>> paid <<Amount>> to <<Bill Issuer>>", style: TextStyle(color: Colors.white, fontSize: 15,))),
                Expanded(flex:1,child: Text("Bill Due Date: <<Month>> <<Day>>", style: TextStyle(color: Colors.white, fontSize: 15,))),
              ],
            ),
          ],
        )
    );
  }

  Widget getHistory() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
        margin: EdgeInsets.all(20),
        color: Colors.grey[200],
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("History", style: TextStyle(color: Colors.grey[700], fontSize: 15,)),
              ],
            ),
            SizedBox(height: 15,),
            historyEvent(),
            SizedBox(height: 15,),
            historyEvent(),
            SizedBox(height: 15,),
            historyEvent(),
          ],
        )
    );
  }

  Widget historyEvent(){
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
              Text("You paid <<User>>"),
              Text("<<Month>> <<Day>>"),
            ],
          ),
        ),

        Expanded(
          flex: 1,
          child: Text("   Amount"),
        )
      ],
    );
  }
}