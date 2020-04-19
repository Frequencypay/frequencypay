import 'package:flutter/material.dart';
import 'contractCreation.dart';
void main() {
  runApp(MaterialApp(
    title: 'Flutter',
    home: manualExpenseInput(),
  ));
}

class manualExpenseInput extends StatefulWidget {
  @override
  _manualExpenseInputState createState() {
    return _manualExpenseInputState();
  }
}

class _manualExpenseInputState extends State<manualExpenseInput> {
  List<String> billItems = new List(9);

  // DEFINE A CONTROLLER FOR EACH TEXTFIELD
  TextEditingController amountController = TextEditingController();
  TextEditingController typeController= TextEditingController();
  TextEditingController dueDateController= TextEditingController();
  TextEditingController acctNumberController= TextEditingController();
  TextEditingController routingNumController= TextEditingController();
  TextEditingController streetController= TextEditingController();
  TextEditingController cityController= TextEditingController();
  TextEditingController stateController= TextEditingController();
  TextEditingController zipController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manual Expense Input'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                    controller: amountController,
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
                    controller: typeController,
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
                    controller: dueDateController,
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
                    controller: acctNumberController,
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
                    controller: routingNumController,
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
                    controller: streetController,
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
                    controller: cityController,
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
                    controller: stateController,
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
                    controller: zipController,
                    decoration: new InputDecoration(
                      hintText: "",
                    ),
                  ),
                ),
              ),
            ],
          ),

          RaisedButton(
            child: Text(
              'Proceed',
              style: TextStyle(fontSize: 24,color: Colors.white),
            ),
            onPressed: () {
              _sendDataToSecondScreen(context);
            },
            color: Colors.green,

          )

        ],
      ),
    );
  }

    // 2_______________________________________________________
  // get the text in the TextField and start the Second Screen
  void _sendDataToSecondScreen(BuildContext context) {
    billItems[0]=amountController.text;
    billItems[1]=typeController.text;
    billItems[2]=dueDateController.text;
    billItems[3]=acctNumberController.text;
    billItems[4]=routingNumController.text;
    billItems[5]=streetController.text;
    billItems[6]=cityController.text;
    billItems[7]=stateController.text;
    billItems[8]=zipController.text;

    //String textToSend = amountController.text;

    

    Navigator.push( //send data to the next screen
        context,
        MaterialPageRoute(
          builder: (context) => contractCreation(billInfo:billItems.toString()), // push a list later
        ));
  }
}

