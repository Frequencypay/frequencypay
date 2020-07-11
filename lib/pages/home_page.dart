import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frequencypay/pages/profile_page.dart';
import 'package:frequencypay/pages/user_bills_page.dart';
import 'package:frequencypay/pages/user_contracts_page.dart';
import 'package:provider/provider.dart';

import '../vaulted_pages/firebase_authentication.dart';
import 'landing_page.dart';
import 'loan_request_page.dart';

class HomePage extends StatefulWidget {
  final String uid; //include this

  HomePage({Key key, this.uid}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static const Color blueHighlight = const Color(0xFF3665FF);

  static List<Widget> bottomNavigationBarOptions = <Widget>[LandingPage(), UserContractsPage(), ProfileScreen(), UserBills()];

  int bottomNavigationBarIndex = 0;

  FirebaseUser currentUser;
  final Auth _auth=Auth(); // instance to correctly sign out

  @override
  initState() {
    this.getCurrentUser();
    super.initState();
  }

  //When a bottom navigation bar icon is tapped
  void _onItemTapped(int index) {

    setState(() => {

      //Set the selected index
      bottomNavigationBarIndex = index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: bottomNavigationBarOptions.elementAt(bottomNavigationBarIndex),

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Padding(padding: EdgeInsets.all(0))
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              title: Padding(padding: EdgeInsets.all(0))
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.inbox),
              title: Padding(padding: EdgeInsets.all(0))
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              title: Padding(padding: EdgeInsets.all(0))
          )

        ],
        currentIndex: bottomNavigationBarIndex,
        selectedItemColor: blueHighlight,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,

      ),
    );
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }
}