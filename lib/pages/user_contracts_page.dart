import 'package:flutter/material.dart';

class UserContractsPage extends StatefulWidget {
  @override
  _UserContractsPageState createState() { return _UserContractsPageState();}
}

class _UserContractsPageState extends State<UserContractsPage> with SingleTickerProviderStateMixin {

  static const Color blueHighlight = const Color(0xFF3665FF);

  TabController tabController;

  @override
  void initState() {

    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Expanded (
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 8,
                    child: Container(
                      child: RichText(text:TextSpan(style: TextStyle(fontFamily: 'Leelawadee UI', fontSize: 25), children: <TextSpan> [
                        TextSpan(text: "Your ", style: TextStyle(color: Colors.black45)),
                        TextSpan(text: "Contracts", style: TextStyle(fontWeight: FontWeight.bold, color: blueHighlight))
                      ])),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              flex: 2,
              child: TabBar(controller: tabController, labelStyle: TextStyle(fontFamily: 'Leelawadee UI', fontSize: 12, fontWeight: FontWeight.bold), labelColor: Colors.black, unselectedLabelColor: Colors.black45, tabs: <Widget>[
                Tab(text: "COMPLETE"),
                Tab(text: "ACTIVE"),
                Tab(text: "PENDING")
              ]
              ),
            ),
            SizedBox(height: 20),
            Expanded(
                flex: 20,
                child: ListView(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    children: <Widget>[
                      buildActiveContractCard(),
                      buildActiveContractCard(),
                      buildActiveContractCard(),
                    ]
                )
            )
          ],
        )

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
