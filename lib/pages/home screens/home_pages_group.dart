import 'package:flutter/material.dart';
import 'package:frequencypay/pages/config%20screens/config_menu_page.dart';
import 'package:frequencypay/pages/home screens/overview_home_page.dart';
import 'package:frequencypay/pages/home screens/transaction_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frequencypay/pages/contract_specification.dart';
import 'package:frequencypay/services/PlaidRepo.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:frequencypay/plaid/plaid_link_network.dart';
import 'package:frequencypay/pages/settings_page.dart';

class HomePagesGroup extends StatefulWidget {
  @override
  _HomePagesGroupState createState() => _HomePagesGroupState();
}

class _HomePagesGroupState extends State<HomePagesGroup> {
  List<String> pageTitles = ["Overview", "Transactions", "Tools"];
  List<Icon> pageIcons = [
    Icon(Icons.search),
    Icon(Icons.assignment),
    Icon(Icons.person)
  ];

  PageController pageController;
  int selectedIndex;
  String appBarTitle;

  FirebaseUser currentUser;

  @override
  void initState() {
    selectedIndex = 0;
    appBarTitle = pageTitles[0];
    pageController = PageController(initialPage: 0, keepPage: true);

    this.getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(appBarTitle),
            actions: <Widget>[
          PopupMenuButton(
              onSelected: onPopupMenuButtonSelected,
              itemBuilder: popupMenuBuilder)
        ]),
        floatingActionButton: floatingActionButtonBuilder(),
        bottomNavigationBar: BottomNavigationBar(
            onTap: onNavigationBarTapped,
            currentIndex: selectedIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: pageIcons[0], title: Text(pageTitles[0])),
              BottomNavigationBarItem(
                  icon: pageIcons[1], title: Text(pageTitles[1])),
              BottomNavigationBarItem(
                  icon: pageIcons[2], title: Text(pageTitles[2])),
            ]),
        body: PageView(
            controller: pageController,
            onPageChanged: OnPageChanged,
            children: <Widget>[
              buildOverviewScreen(),
              buildTransactionScreen(),
              buildToolsScreen()
            ]));
  }

  void onNavigationBarTapped(int index) {
    setState(() {
      selectedIndex = index;
      appBarTitle = pageTitles[index];
    });
    pageController.jumpToPage(index);
  }

  void OnPageChanged(int page) {
    setState(() {
      selectedIndex = page;
      appBarTitle = pageTitles[page];
    });
  }

  Widget buildOverviewScreen() {
    return OverviewHomePage();
  }

  Widget buildTransactionScreen() {
    return TransactionHomePage();
  }

  Widget buildToolsScreen() {
    return Icon(Icons.speaker_notes);
  }

  Widget floatingActionButtonBuilder() {
    if (selectedIndex == 0) {
      return FloatingActionButton(backgroundColor: Colors.greenAccent[700],
          child: Icon(Icons.person_add, color: Colors.black,));
    } else {
      return Container();
    }
  }

  void onPopupMenuButtonSelected(var selection) {

    switch (selection) {
      case "PLAID":

        showPlaidView();
        break;
      case "SETTINGS":

        Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
        break;
      case "CONTRACT":

        Navigator.push(context, MaterialPageRoute(builder: (context) => ContractSpecification()));
        break;
      case "CONFIG":

        Navigator.push(context, MaterialPageRoute(builder: (context) => ConfigMenu()));
        break;
      case "LOGOUT":

        FirebaseAuth.instance.signOut().then((result) => Navigator.pushReplacementNamed(context, "/login")).catchError((err) => print(err));
        break;

    }
  }

  List<PopupMenuEntry> popupMenuBuilder(BuildContext context) {
    List<PopupMenuEntry> popupEntries = [
      PopupMenuItem(value: "PLAID", child: Text("Plaid View")),
      PopupMenuItem(value: "SETTINGS", child: Text("Settings")),
      PopupMenuItem(value: "CONTRACT", child: Text("New Contract")),
      PopupMenuItem(value: "CONFIG", child: Text("Configuration")),
      PopupMenuItem(value: "LOGOUT", child: Text("Log Out"))
    ];

    return popupEntries;
  }

  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser();
  }

  showPlaidView(){
    bool plaidSandbox = true;
    String clientID = "5cb68305fede9b00136aebb1";
    String secret = "54621c4436011f708c7916587c6fa8";

    Configuration configuration = Configuration(
        plaidPublicKey: '5e8f6927464aa029be1a265eb95b79',
        plaidBaseUrl: 'https://cdn.plaid.com/link/v2/stable/link.html',
        plaidEnvironment: plaidSandbox ? 'sandbox' : 'production',
        environmentPlaidPathAccessToken:
        'https://sandbox.plaid.com/item/public_token/exchange',
        environmentPlaidPathStripeToken:
        'https://sandbox.plaid.com/processor/stripe/bank_account_token/create',
        plaidClientId: clientID,
        secret: plaidSandbox ? secret : '',
        clientName: 'ClientName',
        webhook: 'http://requestb.in',
        product: 'auth',
        selectAccount: 'true'
    );

    PlaidLink plaidLink = PlaidLink(configuration);
    plaidLink.launch(context, (Result result) {
      getAccessToken(clientID, secret, result.token);
    }, stripeToken: false);
  }

  getAccessToken( clientID,  secretKey, publicToken){
    PlaidRepo plaid = PlaidRepo();
    plaid.signInWithCredentials(clientID, secretKey, publicToken);

  }
}