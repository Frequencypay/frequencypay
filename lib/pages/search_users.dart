import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frequencypay/pages/loan_request_page.dart';

class SearchData extends StatefulWidget {
  @override
  _SearchDataState createState() => _SearchDataState();
}

class _SearchDataState extends State<SearchData> {
  TextEditingController searchInputController;
  String searchString;

  @override
  initState() {
    searchInputController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),

      body: SafeArea(
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchString = value.toLowerCase();
                      });
                    },
                  ),
                ),

              ],

            ),
            SearchResults(),

          ],
        ),
      ),

    );
  }

  Widget SearchResults(){
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: (searchString==null)?Firestore.instance.collection("user_data").snapshots():Firestore.instance.collection("user_data").where("searchIndex",arrayContains: searchString).snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return Text("Error");
          }
          switch(snapshot.connectionState){
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              return new ListView(
                children: snapshot.data.documents.map((DocumentSnapshot document){
                  return new Card(
                    color: Colors.grey[200],

                    child: Row(
                      children: <Widget>[
                        CircleAvatar(child: Text("profile pic"), radius: 40,),
                        Padding(
                          padding: EdgeInsets.all(50),
                        ),
                        Column(
                          children: <Widget>[
                            Text(document['name'],style: TextStyle(color: Colors.blueGrey,fontSize: 20),),
                            Text(document["email"]),
                            Text(document["username"]),
                            RaisedButton(
                              child: Text("Select",style: TextStyle(color: Colors.white),),
                              onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context)=>LoanRequest(value: document['name'],),
                                ));
                              },
                              color: Colors.blue,
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }
}




//            RaisedButton(
//              padding: EdgeInsets.all(10),
//              child: Text("Search", style: TextStyle(color: Colors.white, fontSize: 15)),
//              color: Colors.blue,
//              onPressed: (){
//                Navigator.of(context).push(MaterialPageRoute(
//                  builder: (context)=>SearchResults(value: searchString,),
//                ));
//              },
