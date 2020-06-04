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
        body: RichText(text:TextSpan(style: TextStyle(fontFamily: 'Leelawadee UI', fontSize: 25), children: <TextSpan> [
          TextSpan(text: "Good Morning,\n", style: TextStyle(color: Colors.black45)),
          TextSpan(text: "<name>", style: TextStyle(fontWeight: FontWeight.bold, color: blueHighlight))
        ])),

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
