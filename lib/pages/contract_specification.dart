import 'package:flutter/material.dart';

class ContractSpecification extends StatefulWidget {
  @override
  _ContractSpecificationState createState() => _ContractSpecificationState();
}

class _ContractSpecificationState extends State<ContractSpecification> {
  String lenderName = "Mohamad Darwiche"; // just an example value
  String expenseName= "DTE Bill"; // just an example value
  double expenseAmount=75;  // just an example value
  double amountRepaid=5;  // just an example value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Contract Creation"),
          backgroundColor: Colors.green,
        ),
        body: Column( // the overall page containing all other rows
          children: <Widget>[

            Row(
              children: <Widget>[
                Expanded(
                  flex:2,
                  child: Container(
                    child: Text("Borrowing From: ", style:TextStyle(color: Colors.grey,fontSize: 15.0)),
                  ),
                ),
                Expanded(
                  flex:3,
                  child: Container(
                    child: Text("$lenderName", style:TextStyle(color: Colors.grey,fontSize: 15.0,fontWeight: FontWeight.bold)),
                  ),
                ),
                Expanded(
                  flex:1,
                  child: Container(
                    child: CircleAvatar(backgroundColor: Colors.green, radius: 30),
                    padding: EdgeInsets.all(3),
                  ),
                ),
              ],
            ),

            Divider(
              height: 40,
              color: Colors.green,
            ),

            Row(
              children: <Widget>[
                Expanded(
                  flex:2,
                  child: Container(
                    child: Text("Borrowing For: ", style:TextStyle(color: Colors.grey,fontSize: 15.0)),
                  ),
                ),

                Expanded(
                  flex:3,
                  child: Container(
                    child: Text("$expenseName", style:TextStyle(color: Colors.grey,fontSize: 15.0,fontWeight: FontWeight.bold)),
                  ),
                ),

                Expanded(
                  flex:1,
                  child: Container(
                    child: CircleAvatar(backgroundColor: Colors.green, radius: 30),
                    padding: EdgeInsets.all(3),
                  ),
                ),
              ],
            ),

            Row(
              children: <Widget>[
                Container(
                  child: Text("Amount Borrowed: ", style:TextStyle(color: Colors.grey,fontSize: 15.0)),
                ),

                Container(
                  child: Text("$expenseAmount Dollars", style:TextStyle(color: Colors.grey,fontSize: 15.0,fontWeight: FontWeight.bold)),
                ),

              ],
            ),

            Row(
              children: <Widget>[
                Container(
                  child: Text("Ratio of Expense: ", style:TextStyle(color: Colors.grey,fontSize: 15.0)),
                ),
                Expanded(
                  child: Container(
                    child: TextField(
                      decoration: new InputDecoration(
                        hintText: "",
                      ),
                    ),
                  ),
                ),

              ],
            ),

            Divider(
              height: 40,
              color: Colors.green,
            ),

            Row(
              children: <Widget>[
                Text("Repayment Plan: ",style:TextStyle(color: Colors.grey,fontSize: 15.0)),
              ],
            ),

            SizedBox(height: 10,),

            Row(
              children: <Widget>[
                Text("Amount Repaid: ",style:TextStyle(color: Colors.grey,fontSize: 15.0)),
                Text("$amountRepaid Dollars",style:TextStyle(color: Colors.grey,fontSize: 15.0,fontWeight: FontWeight.bold)),
              ],
            ),


            Row(
              children: <Widget>[
                Container(
                  child: Text("Repayment Type: ", style:TextStyle(color: Colors.grey,fontSize: 15.0)),
                ),
                Expanded(
                  child: Container(
                    child: TextField(
                      decoration: new InputDecoration(
                        hintText: "",
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              children: <Widget>[
                Container(
                  child: Text("Repayment Starting Date: ", style:TextStyle(color: Colors.grey,fontSize: 15.0)),
                ),
                Expanded(
                  child: Container(
                    child: TextField(
                      decoration: new InputDecoration(
                        hintText: "",
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              children: <Widget>[
                Container(
                  child: Text("Repayment Completion Date: ", style:TextStyle(color: Colors.grey,fontSize: 15.0)),
                ),
                Expanded(
                  child: Container(
                    child: TextField(
                      decoration: new InputDecoration(
                        hintText: "",
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              children: <Widget>[
                Container(
                  child: Text("Repayment Interval: ", style:TextStyle(color: Colors.grey,fontSize: 15.0)),
                ),
                Expanded(
                  child: Container(
                    child: TextField(
                      decoration: new InputDecoration(
                        hintText: "",
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              children: <Widget>[
                Container(
                  child: Text("Interval Repayment Amount: ", style:TextStyle(color: Colors.grey,fontSize: 15.0)),
                ),
                Expanded(
                  child: Container(
                    child: TextField(
                      decoration: new InputDecoration(
                        hintText: "",
                      ),
                    ),
                  ),
                ),
              ],
            ),

            RaisedButton(
              onPressed: (){},
              color: Colors.green,
              child: Text("Create",style:TextStyle(color: Colors.white,fontSize: 15.0)),
            ),
          ],
        )

    );
  }
}
