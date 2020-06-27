import 'package:flutter/material.dart';
import 'package:frequencypay/models/contract_model.dart';

class ContractTile extends StatelessWidget {
  final Contract contract;
  ContractTile({this.contract});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0,6.0,20.0,0.0),
        child:Column(
          children: <Widget>[
            Text("Requester: "+contract.requester),
            Text("Loaner: "+contract.loaner),
            Text("Due Date: "+contract.dueDate),
            Text("Number of Payments: "+contract.numPayments.toString()),
            Text("Amount: "+contract.amount.toString()),
            Text("Is active? : "+contract.isActive.toString()),
          ],
        ) ,

      ),
    );
  }
}
