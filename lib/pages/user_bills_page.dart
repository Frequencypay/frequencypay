import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frequencypay/blocs/user_bills_bloc.dart';
import 'package:frequencypay/models/contract_model.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/route_arguments/contract_details_arguments.dart';
import 'package:frequencypay/services/firestore_db_service.dart';
import 'package:frequencypay/widgets/contract_cards.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:frequencypay/pages/contract_details.dart';
import 'package:provider/provider.dart';

class UserBills extends StatefulWidget {
  @override
  _UserBillsState createState() => _UserBillsState();
}

class _UserBillsState extends State<UserBills> {
  double percentComplete;

  final _maxContractsDisplayed = 3;

  UserBillsBloc createBloc(var context,) {
    final user = Provider.of<User>(context, listen: false);

    UserBillsBloc bloc = UserBillsBloc(FirestoreService(uid: user.uid));

    bloc.add(LoadUserBillsEvent());

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
                SizedBox(height: 10,),
                Row(
                  children: <Widget>[
                    Text("  Your ",style: TextStyle(color: Colors.grey, fontSize: 30),),
                    Text("Bills ",style: TextStyle(color: Colors.blue, fontSize: 30),),
                  ],
                ),

                SizedBox(height: 20,),
                Row(
                  children: <Widget>[
                    Text("    Upcoming: ",style: TextStyle(color: Colors.grey, fontSize: 17),),
                  ],
                ),

                //GENERATING BILL WITH DUMMY DATA
                getBill("DTE ENERGY","5/15/2020","130"),
                getBill("T-MOBILE","6/25/2020","75"),

                SizedBox(height: 20,),
                viewAllBills(),

                Row(
                  children: <Widget>[
                    Text("    Contracts: ",style: TextStyle(color: Colors.grey, fontSize: 17),),
                  ],
                ),

                //getContracts("DTE ENERGY","3 WEEKS",130,75),
                //getContracts("T-MOBILE","1 WEEK",75,60),
                buildActiveContractList(),

                SizedBox(height: 20,),
                viewAllContracts(),
                SizedBox(height: 10,),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getBill(String billName, String billDue,String billAmount){
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(

          children: <Widget>[
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue[900],
            ),
            Text("     "),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("$billName",style: TextStyle(fontSize: 16),),
                Text("DUE ON: $billDue",style: TextStyle(fontSize: 16,color: Colors.grey),),
                Text("\$ $billAmount",style: TextStyle(fontSize: 16),),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getContracts(String contractName, String timeLeft,double totalAmount, double amountPaid){
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(

          children: <Widget>[
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue[900],
            ),
            Text("     "),
            Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("$contractName",style: TextStyle(fontSize: 16),),
                Text("$timeLeft LEFT",style: TextStyle(fontSize: 16,color: Colors.grey),),
                SizedBox(height: 5,),
                getProgress(totalAmount, amountPaid),
                SizedBox(height: 5,),
                Text("\$ $totalAmount",style: TextStyle(fontSize: 16),),
                FlatButton.icon(
                  icon: Icon(Icons.expand_less),
                  label: Text("View Details"),
                  onPressed: (){
                    setPercentComplete(totalAmount, amountPaid);
                    Navigator.pushNamed(context, "/contract_details", arguments: ContractDetailsArguments(null));
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget viewAllBills(){
    return FlatButton(
      child: Text("View All",style: TextStyle(color: Colors.grey),),
      color: Colors.white24,
      onPressed: (){},
    );
  }

  Widget viewAllContracts(){
    return FlatButton(
      child: Text("View All",style: TextStyle(color: Colors.grey),),
      color: Colors.white24,
      onPressed: (){

        //Navigator.push(context, "/user_contracts");
      },
    );
  }

  Widget getProgress(double totalAmount, double amountPaid){
    setPercentComplete(totalAmount, amountPaid);
    return new LinearPercentIndicator(
      width: 200,
      lineHeight: 5.0,
      percent: percentComplete,
      progressColor: Colors.deepPurple,
    );
  }

  void setPercentComplete(double totalAmount, double amountPaid){
    percentComplete=amountPaid/totalAmount;
  }

  Widget buildActiveContractList() {

    return BlocBuilder<UserBillsBloc, UserBillsState>(
        builder: (context, state) {

          if (state is UserBillsIsLoadedState) {
            return ListView.builder(

                itemBuilder: (context, index) {
                  return ContractCards.buildActiveContractCard(context, state.getContracts.contracts[index]);
                },
                itemCount: min<int>(_maxContractsDisplayed, state.getContracts.contracts.length),
                shrinkWrap: true);
          } else if (state is UserBillsIsLoadingState) {
            return ListView.builder(

                itemBuilder: (context, index) {
                  return ContractCards.buildActiveContractCard(context, null);
                },
                itemCount: 2,
                shrinkWrap: true);//Center(child: SizedBox(width: 50, height: 50,child: CircularProgressIndicator()));
          } else {
            return Center(child: Text("error"));
          }
        });
  }

}