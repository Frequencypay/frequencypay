import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frequencypay/pages/loan_request_page.dart';

class SearchResults extends StatefulWidget {
  String value;
  SearchResults({Key key, @required this.value}) :super(key:key);
  @override
  _SearchResultsState createState() => _SearchResultsState(value);
}

class _SearchResultsState extends State<SearchResults> {
  String value;
  _SearchResultsState(this.value);



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Search Results"),
      ),

      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20,),
            Center(child: Text("Results for \"$value\" :")),
            SizedBox(height: 10,),
            SearchResults(),

          ],
        ),
      ),
    );
  }

  Widget SearchResults(){
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: (value==null)?Firestore.instance.collection("users").snapshots():Firestore.instance.collection("users").where("searchIndex",arrayContains: value).snapshots(),
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
