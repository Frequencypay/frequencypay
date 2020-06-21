import 'package:flutter/material.dart';

class UserContractsPage extends StatefulWidget {
  @override
  _UserContractsPageState createState() {
    return _UserContractsPageState();
  }
}

class _UserContractsPageState extends State<UserContractsPage>
    with SingleTickerProviderStateMixin {
  static const Color blueHighlight = const Color(0xFF3665FF);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                Expanded(flex: 1, child: Container()),
                Expanded(
                  flex: 8,
                  child: Container(
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                fontFamily: 'Leelawadee UI', fontSize: 25),
                            children: <TextSpan>[
                          TextSpan(
                              text: "Your ",
                              style: TextStyle(color: Colors.black45)),
                          TextSpan(
                              text: "Contracts",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: blueHighlight))
                        ])),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            flex: 2,
            child: TabBar(
                labelStyle: TextStyle(
                    fontFamily: 'Leelawadee UI',
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black45,
                tabs: <Widget>[
                  Tab(text: "COMPLETE"),
                  Tab(text: "ACTIVE"),
                  Tab(text: "PENDING")
                ]),
          ),
          SizedBox(height: 20),
          Expanded(
              flex: 20,
              child: TabBarView(
                children: <Widget>[
                  buildCompleteContractList(),
                  buildActiveContractList(),
                  buildRepaymentContractList()
                ],
              ))
        ],
      )),
    );
  }

  //Each of these need to retrieve the contracts and build the widgets for the list
  //(ListView.builder is the way to implement)
  Widget buildCompleteContractList() {

    return ListView(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        children: <Widget>[
          buildCompleteContractCard(),
          buildCompleteContractCard(),
          buildCompleteContractCard(),
        ]);
  }

  Widget buildActiveContractList() {
    return ListView(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        children: <Widget>[
          buildActiveContractCard(),
          buildActiveContractCard(),
        ]);
  }

  Widget buildRepaymentContractList() {
    return ListView(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        children: <Widget>[
          buildRepaymentContractCard(),
        ]);
  }

  Widget buildCompleteContractCard() {
    return Container(
        height: 100,
        child: Card(
            elevation: 5,
            child: Row(children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                      padding: EdgeInsets.all(10), child: Text("ICON"))),
              Expanded(
                flex: 5,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 15),
                      Text("<Bill Issuer>", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700], fontSize: 16)),
                      SizedBox(height: 2),
                      Text("Paid in full on <date>", style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                      SizedBox(height: 2),
                      Text("<amount> from <name>", style: TextStyle(color: Colors.grey[600], fontSize: 14))
                    ]),
              ),
              Expanded(flex: 1, child: Container())
            ])));
  }

  Widget buildActiveContractCard() {
    return Container(
        height: 100,
        child: Card(
            elevation: 5,
            child: Row(children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                      padding: EdgeInsets.all(10), child: Text("ICON"))),
              Expanded(
                flex: 5,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("<Bill Issuer>", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700], fontSize: 16)),
                      Text("<Time Left>", style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                      LinearProgressIndicator(),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text("<Amount Left>", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600], fontSize: 14)))
                    ]),
              ),
              Expanded(flex: 1, child: Container())
            ])));
  }

  Widget buildRepaymentContractCard() {
    return Container(
        height: 100,
        child: Card(
            elevation: 5,
            child: Row(children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                      padding: EdgeInsets.all(10), child: Text("ICON"))),
              Expanded(
                flex: 5,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 15),
                      Text("<Bill Issuer>", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700], fontSize: 16)),
                      SizedBox(height: 2),
                      Text("<duration> repayment", style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                      SizedBox(height: 2),
                      Text("<amount> from <name>", style: TextStyle(color: Colors.grey[600], fontSize: 14))
                    ]),
              ),
              Expanded(flex: 1, child: Container())
            ])));
  }
}
