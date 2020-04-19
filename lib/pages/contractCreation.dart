import 'package:flutter/material.dart';

class contractCreation extends StatelessWidget {

  String billInfo; //text receive


  //parse string?
  // receive data from the FirstScreen as a parameter
  contractCreation({Key key, @required this.billInfo}) : super(key: key);

  List convertToArr(String str){
    return str.split(",");
  }

  @override
  Widget build(BuildContext context) {
    List<String> myList=convertToArr(billInfo);
    return Scaffold(
        appBar: AppBar(backgroundColor:Colors.green,title: Text('Contract Creation')),
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context,index){
            return Column( // the overall page containing all other rows
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("Bill Information: ",style: TextStyle(color: Colors.green,fontSize: 20)),
                    Row(
                      children: <Widget>[
                        Text("Bill Amount: ", style:TextStyle(color: Colors.grey,fontSize: 15.0)),
                        Text(myList[0].replaceAll("[", ""), style:TextStyle(color: Colors.grey,fontSize: 15.0,fontWeight: FontWeight.bold)),
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Text("Bill Type: ", style:TextStyle(color: Colors.grey,fontSize: 15.0)),
                        Text(myList[1], style:TextStyle(color: Colors.grey,fontSize: 15.0,fontWeight: FontWeight.bold)),
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Text("Bill Due Date: ", style:TextStyle(color: Colors.grey,fontSize: 15.0)),
                        Text(myList[2], style:TextStyle(color: Colors.grey,fontSize: 15.0,fontWeight: FontWeight.bold)),
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Text("Account Number: ", style:TextStyle(color: Colors.grey,fontSize: 15.0)),
                        Text(myList[3], style:TextStyle(color: Colors.grey,fontSize: 15.0,fontWeight: FontWeight.bold)),
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Text("Routing Number: ", style:TextStyle(color: Colors.grey,fontSize: 15.0)),
                        Text(myList[4], style:TextStyle(color: Colors.grey,fontSize: 15.0,fontWeight: FontWeight.bold)),
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Text("Bank Address: ", style:TextStyle(color: Colors.grey,fontSize: 15.0)),
                        Text(myList[5], style:TextStyle(color: Colors.grey,fontSize: 15.0,fontWeight: FontWeight.bold)),
                        Text(","),
                        Text(myList[6], style:TextStyle(color: Colors.grey,fontSize: 15.0,fontWeight: FontWeight.bold)),
                        Text(","),
                        Text(myList[7], style:TextStyle(color: Colors.grey,fontSize: 15.0,fontWeight: FontWeight.bold)),
                        Text(","),
                        Text(myList[8].replaceAll("]", ""), style:TextStyle(color: Colors.grey,fontSize: 15.0,fontWeight: FontWeight.bold)),
                      ],
                    ),

                  ],

                ),
                Divider(
                  height: 40,
                  color: Colors.green,
                ),

                Column(
                  children: <Widget>[
                    Text("Lender Information: ",style: TextStyle(color: Colors.green,fontSize: 20)),
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
                            child: Text("<some lender>", style:TextStyle(color: Colors.grey,fontSize: 15.0,fontWeight: FontWeight.bold)),
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

                  ],

                ),


                Divider(
                  height: 40,
                  color: Colors.green,
                ),

                Column(
                  children: <Widget>[
                    Text("Expense Information: ",style: TextStyle(color: Colors.green,fontSize: 20)),
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
                            child: Text("<some expense>", style:TextStyle(color: Colors.grey,fontSize: 15.0,fontWeight: FontWeight.bold)),
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
                          child: Text("<some amount> Dollars", style:TextStyle(color: Colors.grey,fontSize: 15.0,fontWeight: FontWeight.bold)),
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

                  ],
                ),



                Divider(
                  height: 40,
                  color: Colors.green,
                ),

                Column(
                  children: <Widget>[
                    Text("Expense Information: ",style: TextStyle(color: Colors.green,fontSize: 20)),
                    SizedBox(height:20),
                    Row(
                      children: <Widget>[
                        Text("Amount Repaid: ",style:TextStyle(color: Colors.grey,fontSize: 15.0)),
                        Text("<some amount> Dollars",style:TextStyle(color: Colors.grey,fontSize: 15.0,fontWeight: FontWeight.bold)),
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

                  ],
                ),





                RaisedButton(
                  onPressed: (){},
                  color: Colors.green,
                  child: Text("Create",style:TextStyle(color: Colors.white,fontSize: 15.0)),
                ),
              ],
            );
          }
        ),


    );
  }
}