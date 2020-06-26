import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frequencypay/pages/profile_page.dart';
import 'package:frequencypay/pages/user_bills_page.dart';
import 'package:frequencypay/pages/user_contracts_page.dart';
import 'package:frequencypay/services/firebase_auth_service.dart';
import '../vaulted_pages/firebase_authentication.dart';
import 'landing_page.dart';
import 'loan_request_page.dart';
import 'package:frequencypay/pages/temp_user_data.dart';

class LandingPage extends StatefulWidget {
  final String uid;
  LandingPage({Key key, this.uid}):super(key:key);
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  FirebaseUser currentUser;
  final AuthService _auth=AuthService();

  @override
  initState() {
    //this.getCurrentUser();
    super.initState();
  }

  static const Color blueHighlight = const Color(0xFF3665FF);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: ListView(children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 250,),
                  FlatButton.icon(
                    icon: Icon(Icons.person,color: Colors.grey,),
                    label: Text("Log out",style: TextStyle(color: Colors.grey),),
                    onPressed: () async {
                      await _auth.signOut();
                    },
                  ),
                ],
              ),

              FlatButton.icon(
                icon: Icon(Icons.person,color: Colors.grey,),
                label: Text("Get current user data",style: TextStyle(color: Colors.grey),),
                onPressed: ()  {
                  Navigator.pushNamed(context, '/temp_user_data');
                },
              ),


              //ROW 1
              Row(
                children: <Widget>[

                  Expanded(flex: 1, child: Container()),

                  Expanded(
                    flex: 5,
                    child: RichText(text:TextSpan(style: TextStyle(fontFamily: 'Leelawadee UI', fontSize: 25), children: <TextSpan> [
                      TextSpan(text: "Good Morning,\n", style: TextStyle(color: Colors.black45)),
                      TextSpan(text: "<name>.\n", style: TextStyle(fontWeight: FontWeight.bold, color: blueHighlight)),
                      TextSpan(text: "<date>", style: TextStyle(color: Colors.grey, fontSize: 14))
                    ])),
                  ),
                  Expanded(flex: 1, child: Container())
                ],
              ),

              SizedBox(height: 30),

              //ROW 2
              Row(children: <Widget>[
                Expanded(flex: 1, child: Container()),
                Expanded(
                  flex: 5,
                  child: Container(height: 130,
                      child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          color: blueHighlight,
                          elevation: 10,
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: <Widget> [
                          Expanded(flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget> [
                              Expanded(flex: 1, child: Text("Congratulations!", style: TextStyle(fontSize: 18, color: Colors.white))),
                              Expanded(flex: 2, child: Container()),
                              Expanded(flex: 1, child: Text("<message>", style: TextStyle(fontSize: 12, color: Colors.white)))
                            ]
                          )),
                          Expanded(flex: 1,
                          child: Container())
                        ]),
                      )))
                ),
                Expanded(flex: 1, child: Container())
              ]),

              SizedBox(height: 30),

              //ROW 3
              Row(
                children: <Widget>[
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 5,
                    child: Container(height: 100,
                      child: Row(children: <Widget> [
                        Expanded(flex: 1, child: Stack(children: <Widget> [
                          Align(alignment: Alignment.center, child: SizedBox(width: 90, height: 90, child: CircularProgressIndicator(backgroundColor: Colors.grey[300], ))),
                          Align(alignment: Alignment.center, child: Text("view\ncontracts", textAlign: TextAlign.center,))
                        ])),
                        Expanded(flex: 2, child:
                        Column(children: <Widget> [
                          Expanded(flex: 1, child: Text("Your Progress", style: TextStyle(fontSize: 18, color: Colors.grey))),
                          Expanded(
                            flex: 1,
                            child: Column(children: <Widget> [
                              Text("<x>% of loans paid off"),
                              Text("<time> until paid in full", style: TextStyle(fontSize: 14, color: Colors.grey))
                            ])
                          ),
                        ]))
                      ]),
                    )
                  ),
                  Expanded(flex: 1, child: Container())
                ],
              ),

              SizedBox(height: 30),


              //CONTACTS
              Row(children: <Widget> [
                Expanded(flex: 1, child: Container()),
                Expanded(flex: 3, child: Text("Contacts")),
                Expanded(flex: 1, child: Container())
              ]),

              Container(height: 100, child: ListView.separated(
                itemCount: 20,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(width: 5),
                itemBuilder: (context, index) => CircleAvatar(),

              ))

            ],

          ),

        ])
        );
  }

  Widget buildActiveContractCard() {
    return Container(height: 100, child: Card(elevation: 5,child: Row(children: <Widget> [
      Expanded(flex: 1, child: Container(padding: EdgeInsets.all(10), child: Text("ICON"))),
      Expanded(
        flex: 5,
        child: Column( crossAxisAlignment: CrossAxisAlignment.start,children: <Widget> [
          Text("<Bill Issuer>"),
          Text("<Time Left>"),
          LinearProgressIndicator(),
          Align(alignment: Alignment.centerRight, child: Text("<Amount Left>"))

        ]),
      ),
      Expanded( flex: 1, child: Container())
    ])));
  }

  //KEEP FOR REFERENCE
  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }
}
