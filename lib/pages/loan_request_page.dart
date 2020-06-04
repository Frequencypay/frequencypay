import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoanRequest extends StatefulWidget {
  @override
  _LoanRequestState createState() => _LoanRequestState();
}

class _LoanRequestState extends State<LoanRequest> {
  double amount=0;
  double paymentsOf=0;
  int weeks=0;
  double paymentsTotal=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10,),
              Row(
                children: <Widget>[
                  Text("  Contract ",
                    style: TextStyle(color: Colors.grey, fontSize: 25),),
                  Text("Creation ",
                    style: TextStyle(color: Colors.blue, fontSize: 25),),
                ],
              ),
              SizedBox(height: 20,),
              getBillIssuer(),
              SizedBox(height: 25,),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: selectLender(),
                  ),

                  Expanded(
                    flex: 2,
                    child: getDueDate(),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              specifyBillAmt(),
              SizedBox(height: 20,),
              specifyRepaymentTerms(),
              SizedBox(height: 20,),
              specifyRepaymentMethod(),
              SizedBox(height: 20,),
              submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getBillIssuer(){
    return Column(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.blue[900],
          child: Text("ISSUER"),
          radius: 50,
        ),
        SizedBox(height: 10,),
        Text("<<Bill Issuer>>",style: TextStyle(fontSize: 20,color: Colors.grey),),
      ],
    );
  }

  Widget selectLender(){
    return Column(
      children: <Widget>[
        SizedBox(height: 13,),
        Text("Select Lender",style: TextStyle(fontSize: 20,color: Colors.blue),),
        FlatButton.icon(
          icon: Icon(Icons.add_circle_outline,color: Colors.green,size: 40,),
          onPressed: (){},
          label: Text(""),
        )
      ],
    );
  }

  Widget getDueDate(){
    return Column(
      children: <Widget>[
        Text("Due Date",style: TextStyle(fontSize: 20,color: Colors.blue),),
        SizedBox(height: 10,),
        Text("05/25/2020",style: TextStyle(fontSize: 20,color: Colors.grey),),
      ],
    );
  }

  Widget specifyBillAmt(){
    return Column(
      children: <Widget>[
        Text("Bill Amount:",style: TextStyle(fontSize: 20,color: Colors.blue),),
        SizedBox(height: 10,),
        Row(
          children: <Widget>[
            Expanded(
              flex:2,
              child: FlatButton.icon(
                icon: Icon(Icons.remove_circle,color: Colors.deepPurple,size: 50,),
                label: Text(""),
                onPressed: (){
                  setState((){
                    amount-=1;
                    paymentsTotal=amount/paymentsOf;
                  });
                },
              ),
            ),


            Expanded(
              flex:2,
              child: Text(" \$ $amount",style: TextStyle(color: Colors.grey,fontSize: 30),),
            ),

            Expanded(
              flex:2,
              child: FlatButton.icon(
                icon: Icon(Icons.add_circle,color: Colors.deepPurple,size: 50,),
                label: Text(""),
                onPressed: (){
                  setState((){
                    amount+=1;
                    paymentsTotal=amount/paymentsOf;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget specifyRepaymentTerms(){
    return Column(
      children: <Widget>[
        Text("Repayment Terms:",style: TextStyle(fontSize: 20,color: Colors.blue),),
        SizedBox(height: 10,),
        Row(
          children: <Widget>[
            Expanded(flex:3,child: Text("Payments of:",style: TextStyle(fontSize: 20,color: Colors.grey),)),
            Expanded(
              flex:2,
              child: FlatButton.icon(
                icon: Icon(Icons.remove_circle,color: Colors.grey[900],size: 40,),
                label: Text(""),
                onPressed: (){
                  setState((){
                    paymentsOf-=1;
                    paymentsTotal=amount/paymentsOf;
                  });
                },
              ),
            ),


            Expanded(
              flex:2,
              child: Text(" \$ $paymentsOf",style: TextStyle(color: Colors.grey,fontSize: 20),),
            ),

            Expanded(
              flex:2,
              child: FlatButton.icon(
                icon: Icon(Icons.add_circle,color: Colors.grey[900],size: 40,),
                label: Text(""),
                onPressed: (){
                  setState((){
                    paymentsOf+=1;
                    paymentsTotal=amount/paymentsOf;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: <Widget>[
            Expanded(flex:3,child: Text("Every:",style: TextStyle(fontSize: 20,color: Colors.grey),)),
            Expanded(
              flex:2,
              child: FlatButton.icon(
                icon: Icon(Icons.remove_circle,color: Colors.grey[900],size: 40,),
                label: Text(""),
                onPressed: (){
                  setState((){
                    weeks-=1;
                  });
                },
              ),
            ),


            Expanded(
              flex:2,
              child: Text("$weeks Weeks",style: TextStyle(color: Colors.grey,fontSize: 18),),
            ),

            Expanded(
              flex:2,
              child: FlatButton.icon(
                icon: Icon(Icons.add_circle,color: Colors.grey[900],size: 40,),
                label: Text(""),
                onPressed: (){
                  setState((){
                    weeks+=1;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(height:10),
        Text("$paymentsTotal Payments total",style: TextStyle(color: Colors.grey[900],fontSize: 15),),

      ],
    );
  }

  Widget specifyRepaymentMethod(){
    return Row(
      children: <Widget>[
        Text("   "),
        Expanded(
          flex: 2,
          child: Column(
            children: <Widget>[
              SizedBox(height: 13,),
              Text("Repayment Method",style: TextStyle(fontSize: 20,color: Colors.blue),),
              FlatButton.icon(
                icon: Icon(Icons.add_circle_outline,color: Colors.green,size: 40,),
                onPressed: (){},
                label: Text(""),
              ),
            ],
          ),
        ),

        Expanded(
          flex: 2,
          child: Column(
            children: <Widget>[
              SizedBox(height: 13,),
              Text("ACH Details",style: TextStyle(fontSize: 20,color: Colors.blue),),
              FlatButton.icon(
                icon: Icon(Icons.add_circle_outline,color: Colors.green,size: 40,),
                onPressed: (){},
                label: Text(""),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget submitButton(){
    return RaisedButton(
      color: Colors.blue,
      child: Text("Submit",style: TextStyle(color: Colors.white, fontSize: 18),),
      onPressed: (){
        amount=0;
        paymentsOf=0;
        weeks=0;
        paymentsTotal=0;
      },
    );
  }
}