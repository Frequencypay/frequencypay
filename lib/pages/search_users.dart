import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frequencypay/pages/search_results.dart';

class SearchData extends StatefulWidget {
  @override
  _SearchDataState createState() => _SearchDataState();
}

class _SearchDataState extends State<SearchData> {
  TextEditingController searchInputController;
  String searchString;

  @override
  initState() {
    searchInputController=new TextEditingController();
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
                    onChanged: (value){
                      setState(() {
                        searchString=value.toLowerCase();
                      });
                    },
                  ),
                )
              ],
            ),

            RaisedButton(
              padding: EdgeInsets.all(10),
              child: Text("Search", style: TextStyle(color: Colors.white, fontSize: 15)),
              color: Colors.blue,
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>SearchResults(value: searchString,),
                ));
              },
            )
          ],
        ),
      ),

    );

  }

  Widget searchInput(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Search User...',
      ),
      controller: searchInputController,
      onChanged: (value){
        setState(() {
          searchString=value.toLowerCase();
        });
      },
    );
  }
}