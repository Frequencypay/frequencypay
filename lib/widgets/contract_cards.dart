import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frequencypay/models/contract_model.dart';
import 'package:frequencypay/route_arguments/contract_details_arguments.dart';
import 'package:frequencypay/services/contract_service.dart';

class ContractCards {

  static Widget buildCompleteContractCard(BuildContext context, Contract contract, var returnCallback) {
    return Container(
      height: 100,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        elevation: 5,
        child: InkWell(
          onTap: () {

            //Transition to viewing the contract details using the contract loaded into this card
            viewContractDetails(context, contract, returnCallback);
          },
          child: ListTile(
              leading: FlutterLogo(),
              title: Text("<Bill Issuer>",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                      fontSize: 16)),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Paid in full on <date>",
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 14)),
                    Text("<amount> from <name>",
                        style: TextStyle(color: Colors.grey[600], fontSize: 14))
                  ])),
        ),
      ),
    );
  }

  static Widget buildActiveContractCard(BuildContext context, Contract contract, var returnCallback) {
    return Container(
      height: 100,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        elevation: 5,
        child: InkWell(
          onTap: () {

            //Transition to viewing the contract details using the contract loaded into this card
            viewContractDetails(context, contract, returnCallback);
          },
          child: ListTile(
              leading: FlutterLogo(),
              title: Text("<Bill Issuer>",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                      fontSize: 16)),
              subtitle: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 40.0, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("<Time Left>",
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 14)),
                      LinearProgressIndicator(value: contract.repaymentProgress),
                      Text("\$" + contract.terms.amount.toString() + " from " + contract.loanerName,
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 14)),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text("\$" + contract.repaymentStatus.remainingAmount.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600],
                                  fontSize: 14)))
                    ]),
              )),
        ),
      ),
    );
  }

  static Widget buildPendingContractCard(BuildContext context, Contract contract, bool activeNotification, var returnCallback) {
    return Container(
      height: 100,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        elevation: 5,
        child: InkWell(
          onTap: () {

            //Transition to viewing the contract details using the contract loaded into this card
            viewContractDetails(context, contract, returnCallback);
          },
          child: ListTile(
            leading: FlutterLogo(),
            title: Text("<Bill Issuer>",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                    fontSize: 16)),
            subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("<duration> repayment",
                      style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                  Text("\$" + contract.terms.amount.toString() + " from " + contract.loanerName,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14))
                ]),
            trailing: Visibility(
              visible: activeNotification,
                child: Icon(Icons.priority_high, color: Colors.grey[700])),
          ),
        ),
      ),
    );
  }

  //Navigates to the contract details screen using the given contract, calling the given method on return
  static void viewContractDetails(BuildContext context, Contract contract, var returnCallback) async{

    //Navigate to the given contract
    var hasReturned = Navigator.pushNamed(context, "/contract_details",
        arguments: ContractDetailsArguments(contract));

    await hasReturned;

    //Activate a return callback if given
    if (returnCallback != null) {

      returnCallback();
    }
  }
}
