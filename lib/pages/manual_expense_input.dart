import 'package:flutter/material.dart';

class ManualBillInput extends StatefulWidget {
  @override
  _ManualBillInputState createState() => _ManualBillInputState();
}

class _ManualBillInputState extends State<ManualBillInput> {
  String lenderName = "Mohamad Darwiche"; // just an example value
  String expenseName= "DTE Bill"; // just an example value
  double expenseAmount=75;  // just an example value
  double amountRepaid=5;  // just an example value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Manual Expense Input"),
          backgroundColor: Colors.green,
        ),
        body: Column( // the overall page containing all other rows
          children: <Widget>[
            SizedBox(height: 10,),
            Row(
              children: <Widget>[
                Text("Expense Information: ", style: TextStyle(color: Colors.green,fontSize: 20),),
              ],
            ),

            Divider(
              height: 20,
              color: Colors.green,
            ),

            Row(
              children: <Widget>[
                Container(
                  child: Text("Amount: ", style:TextStyle(color: Colors.grey,fontSize: 15.0)),
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
                Container(
                  child: Text("Type: ", style:TextStyle(color: Colors.grey,fontSize: 15.0)),
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

            SizedBox(height: 20,),

            Row(
              children: <Widget>[
                Container(
                  child: Text("Due Date: ", style:TextStyle(color: Colors.grey,fontSize: 15.0)),
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
                Container(
                  child: Text("Proof Photo: ", style:TextStyle(color: Colors.grey,fontSize: 15.0)),
                ),
                Expanded(
                  child: Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 30,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20,),

            Row(
              children: <Widget>[
                Text("Billing Information: ", style: TextStyle(color: Colors.green,fontSize: 20),),
              ],
            ),

            Divider(
              height: 20,
              color: Colors.green,
            ),

            Row(
              children: <Widget>[
                Container(
                  child: Text("Account No. : ", style:TextStyle(color: Colors.grey,fontSize: 15.0)),
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
                Container(
                  child: Text("Routing No. : ", style:TextStyle(color: Colors.grey,fontSize: 15.0)),
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

            SizedBox(height: 20,),
            Row(
              children: <Widget>[
                Text("Bank Adress: ", style: TextStyle(color: Colors.green,fontSize: 20),),
              ],
            ),

            Divider(
              height: 20,
              color: Colors.green,
            ),

            Row(
              children: <Widget>[
                Container(
                  child: Text("Street : ", style:TextStyle(color: Colors.grey,fontSize: 15.0)),
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
                Container(
                  child: Text("City : ", style:TextStyle(color: Colors.grey,fontSize: 15.0)),
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

            SizedBox(height: 10,),

            Row(
              children: <Widget>[
                Container(
                  child: Text("State : ", style:TextStyle(color: Colors.grey,fontSize: 15.0)),
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
                Container(
                  child: Text("Zip Code : ", style:TextStyle(color: Colors.grey,fontSize: 15.0)),
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

            SizedBox(height: 30,),

            RaisedButton(
              onPressed: (){},
              color: Colors.green,
              child: Text("Proceed",style:TextStyle(color: Colors.white,fontSize: 15.0)),
            ),
          ],
        )

    );
  }
}

