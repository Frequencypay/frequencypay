import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frequencypay/models/contract_model.dart';
import 'package:frequencypay/models/user_expense_model.dart';
import 'package:frequencypay/route_arguments/contract_details_arguments.dart';
import 'package:frequencypay/route_arguments/loan_request_arguments.dart';
import 'package:intl/intl.dart';

class UserExpenseCards {

  static Widget buildExpenseCard(BuildContext context, UserExpense expense, var returnCallback) {
    return Container(
      height: 100,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: InkWell(
          onTap: () {

            beginLoanRequest(context, expense, returnCallback);
          },
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
                    Text(
                      expense.issuerName,
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "DUE ON: " + DateFormat.yMd().format(expense.dueDate),
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Text(
                      "\$" + expense.amount.toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Opens the loan request screen with the given user expense loaded onto it
  static void beginLoanRequest(BuildContext context, UserExpense expense, var returnCallback) async{

    //Navigate to the loan request screen with the given expense
    var hasReturned = Navigator.pushNamed(context, "/loan_request_page", arguments: LoanRequestArguments(expense));

    await hasReturned;

    //Activate a return callback if given
    if (returnCallback != null) {

      returnCallback();
    }
  }
}