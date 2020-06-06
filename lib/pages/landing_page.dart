import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() { return _LandingPageState();}
}

class _LandingPageState extends State<LandingPage> {

  static const Color blueHighlight = const Color(0xFF3665FF);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: ListView(children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

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
}
