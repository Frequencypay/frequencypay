import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frequencypay/blocs/search_bloc.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/pages/loan_request_page.dart';
import 'package:frequencypay/services/firebase_auth_service.dart';
import 'package:frequencypay/services/firestore_db_service.dart';
import 'package:provider/provider.dart';

class SearchData extends StatefulWidget {

  @override
  _SearchDataState createState() => _SearchDataState();
}

class _SearchDataState extends State<SearchData> {
  SearchBloc createBloc(var context){
    final user=Provider.of<User>(context,listen: false);
    SearchBloc bloc=SearchBloc(FirestoreService(uid: user.uid));
    bloc.add(LoadSearchEvent());
    return bloc;
  }

  TextEditingController searchInputController;
  String searchString="";

  @override
  initState() {
    searchInputController = new TextEditingController();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>createBloc(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Search"),
        ),

        body: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10,),
              Text("Search for a user: ",style: TextStyle(color: Colors.grey,fontSize: 15),),
              searchBar(),
              searchResults(),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchBar(){
    return TextFormField(
      controller: searchInputController,
      decoration: InputDecoration(
        hintText: "Type Name Here...",
      ),
      onChanged: (value) {
        setState(() {
          searchString = value.toLowerCase();
        });
      },
    );
  }

  Widget searchResults(){
    final user =Provider.of<User>(context);
    return Expanded(
      child: Column(
        children: <Widget>[
          BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
            if (state is SearchIsLoadedState) {
              return Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirestoreService(uid: user.uid,value: searchString).userSearchData,
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
                                  SizedBox(width: 50,),
                                  Column(
                                    children: <Widget>[
                                      Text(document['name'],style: TextStyle(color: Colors.blueGrey,fontSize: 20),),
                                      Text(document["email"]),
                                      Text(document["username"]),
                                      RaisedButton(
                                        child: Text("Select",style: TextStyle(color: Colors.white),),
                                        onPressed: (){
                                          Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context)=>LoanRequest(value: document['email'],),
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
            } else if (state is SearchIsLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(
                child: Text(
                  "Search Results",
                  style: TextStyle(color: Colors.black54, fontSize: 25),
                ),
              );
            }
          }),
        ],
      ),
    );
  }

}





