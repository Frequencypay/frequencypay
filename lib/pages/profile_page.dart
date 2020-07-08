import 'package:flutter/material.dart';
import 'package:frequencypay/models/plaid/models.dart';
import 'package:frequencypay/plaid_link/plaid_link_webview.dart';
import 'package:frequencypay/repositories/plaid/plaid_repository.dart';

void main() => runApp(MaterialApp(
  home:ProfileScreen(),
));

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String plaidText = "";

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Column(
        children: <Widget>[
          SizedBox(height: 20,),
          SafeArea(
            child:  Row(
              children: <Widget>[
                Text("  Your ",style: TextStyle(color: Colors.grey, fontSize: 30),),
                Text("Profile ",style: TextStyle(color: Colors.blue, fontSize: 30),),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),

          Container(
            child: profileImg(),
          ),

          SizedBox(
            height: 10,
          ),

          Container(
            child: profileInfo(),
          ),

          SizedBox(height: 40,),
          Text("Confidence Rating",style: TextStyle(color: Colors.black54, fontSize: 20),),

          SizedBox(height: 20,),

          Container(
            child: getConfidenceRating(),
          ),

          SizedBox(height: 30,),

          Container(
            child: getMailandPhone(),
          ),

          RaisedButton(
            child:  Text("Edit",style: TextStyle(color: Colors.white, fontSize: 20),),
            color: Colors.grey,
            onPressed: (){},

          ),
          RaisedButton(
            child: Text("Plaid"),
            color: Colors.blue,
            onPressed: showPlaidView ,
          ),

          Text(plaidText),
        ],
      ),
    );
  }

  Widget profileImg(){
    return CircleAvatar(
      child: Text("loaded from DB"),
      radius: 60,
    );
  } // end profileImg

  Widget profileInfo(){
    return ListView(
      children: <Widget>[
        Text("<<fname>> <<lname>>",style: TextStyle(color: Colors.black54, fontSize: 25),),
        Text("<<username>>",style: TextStyle(color: Colors.black54, fontSize: 17),),
        SizedBox(height: 20,),
        Row(
          children: <Widget>[
            Expanded(
              child:  Container(
                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child:  Text("x  Late Payments",style: TextStyle(color: Colors.grey, fontSize: 15),),
              ),
            ),
            Expanded(
              child:  Container(
                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),

                child:  Text("y Active Contracts",style: TextStyle(color: Colors.grey, fontSize: 15),),
              ),
            ),

            Expanded(
              child:  Container(
                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child:  Text("z Complete Contracts",style: TextStyle(color: Colors.grey, fontSize: 15),),
              ),
            ),
          ],
        ),
      ],
    );
  } // end profile info

  Widget getConfidenceRating(){
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.blue,
      child: Text("100%",style: TextStyle(color: Colors.white, fontSize: 20),),
    );
  } // end getConfidenceRating

  Widget getMailandPhone(){
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text("  Email Address:",style: TextStyle(color: Colors.blue, fontSize: 15),),
          ],
        ),

        Row(
          children: <Widget>[
            Text("  <<email>>",style: TextStyle(color: Colors.black54, fontSize: 15),),
          ],
        ),
        SizedBox(height: 20,),

        Row(
          children: <Widget>[
            Text("  Phone Number",style: TextStyle(color: Colors.blue, fontSize: 15),),
          ],
        ),

        Row(
          children: <Widget>[
            Text("  <<phone number>>",style: TextStyle(color: Colors.black54, fontSize: 15),),
          ],
        ),
      ],

    );
  }

  showPlaidView(){

   String clientID = "5cb68305fede9b00136aebb1";
   String secret = "54621c4436011f708c7916587c6fa8";

    PlaidLink plaidLink = PlaidLink();
    plaidLink.launch(context, (Result result) {
      getAccessToken(clientID, secret, result.token);
    });
  }

  getAccessToken( clientID,  secretKey, publicToken)async{
    PlaidPublicTokenExchangeResponseModel accessTokenModel;

    PlaidRepository plaid = PlaidRepository();
    plaid.signInWithCredentials(clientID, secretKey, publicToken).then((value) {
      setState(() {
        plaidText = value.access_token;
      });
    });
    plaidText = accessTokenModel.access_token;

  }
}




///////////////
