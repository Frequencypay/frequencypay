import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frequencypay/models/contract_model.dart';
import 'package:frequencypay/route_arguments/contract_details_arguments.dart';

class ContractCards {

  static Widget buildCompleteContractCard(BuildContext context, Contract contract) {
    return Container(
      height: 100,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        elevation: 5,
        child: InkWell(
          onTap: () {
            //Transition to viewing the contract details using the contract loaded into this card
            Navigator.pushNamed(context, "/contract_details",
                arguments: ContractDetailsArguments(contract));
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

  static Widget buildActiveContractCard(BuildContext context, Contract contract) {
    return Container(
      height: 100,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        elevation: 5,
        child: InkWell(
          onTap: () {
            //Transition to viewing the contract details using the contract loaded into this card
            Navigator.pushNamed(context, "/contract_details",
                arguments: ContractDetailsArguments(contract));
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
                      LinearProgressIndicator(),
                      Text("\$" + contract.terms.amount.toString() + " from " + contract.loanerName,
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 14)),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text("<Amount Left>",
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

  static Widget buildRepaymentContractCard(BuildContext context, Contract contract) {
    return Container(
      height: 100,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        elevation: 5,
        child: InkWell(
          onTap: () {
            //Transition to viewing the contract details using the contract loaded into this card
            Navigator.pushNamed(context, "/contract_details",
                arguments: ContractDetailsArguments(contract));
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
            trailing: Icon(Icons.priority_high, color: Colors.grey[700]),
          ),
        ),
      ),
    );
  }
}
