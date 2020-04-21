import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OverviewHomePage extends StatefulWidget {

  final DocumentSnapshot userInfo;
  final String uid;

  OverviewHomePage({this.userInfo, this.uid});

  @override
  _OverviewHomePageState createState() => _OverviewHomePageState();
}

class _OverviewHomePageState extends State<OverviewHomePage> {
  @override
  Widget build(BuildContext context) {

    return Stack(children: <Widget>[
      //===FIRST LAYER (main content)===
      Column(children: <Widget>[
        Container(
            child: Expanded(
                flex: 6,
                child: Container(
                    color: Colors.green,
                    child: Center(
                        child: Column(children: <Widget>[
                          Container(child: Expanded(flex: 1, child: Container())),
                          Container(
                              child: Expanded(
                                  flex: 4,
                                  child: Column(children: <Widget>[
                                    Text(widget.userInfo["fname"] + widget.userInfo["surname"],
                                        style: TextStyle(
                                            fontSize: 30, color: Colors.white)),
                                    Text("<@Usertag>",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white))
                                  ]))),
                          Container(child: Expanded(flex: 1, child: Container()))
                        ]))))),
        Container(
            child: Expanded(
                flex: 13,
                child: Center(
                    child: Column(children: <Widget>[
                      Container(child: Expanded(flex: 3, child: Container())),
                      Container(
                          child: Expanded(
                              flex: 1, child: Text("Member since <date>"))),
                      Container(child: Expanded(flex: 1, child: Container())),
                      Container(
                          child: Expanded(
                              flex: 8,
                              child: Column(children: <Widget>[
                                Text("Frequency Rating",
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.green[800])),
                                Text("<rating>",
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.green))
                              ]))),
                      Container(child: Expanded(flex: 1, child: Container()))
                    ]))))
      ]),

      //===SECOND LAYER (profile picture)===
      Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: Expanded(flex: 10, child: CircleAvatar(radius: 70))),
              Container(child: Expanded(flex: 6, child: Container()))
            ]),
      )
    ]);
  }
}