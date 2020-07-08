import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frequencypay/blocs/user_contracts_bloc.dart';
import 'package:frequencypay/models/contract_model.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/services/firestore_db_service.dart';
import 'package:provider/provider.dart';

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

  UserContractsBloc createBloc(var context,) {
    final user = Provider.of<User>(context, listen: false);

    UserContractsBloc bloc = UserContractsBloc(FirestoreService(uid: user.uid));

    bloc.add(LoadUserContractsEvent());

    return bloc;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => createBloc(context),
      child: DefaultTabController(
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
      ),
    );
  }

  //Each of these need to retrieve the contracts and build the widgets for the list
  //(ListView.builder is the way to implement)
  Widget buildCompleteContractList() {

    return BlocBuilder<UserContractsBloc, UserContractsState>(
      builder: (context, state) {

        if (state is UserContractsIsLoadedState) {
          return ListView.builder(

              itemBuilder: (context, index) {
                return buildCompleteContractCard(index, state.getCompleteContracts.contracts[index]);
              },
              itemCount: state.getCompleteContracts.contracts.length,
              shrinkWrap: true);
        } else if (state is UserContractsIsLoadingState) {
          return ListView.builder(

              itemBuilder: (context, index) {
                return buildCompleteContractCard(0, null);
              },
              itemCount: 2,
              shrinkWrap: true);//Center(child: SizedBox(width: 50, height: 50,child: CircularProgressIndicator()));
        } else {
          return Center(child: Text("error"));
        }
    });
    }

  Widget buildActiveContractList() {

    return BlocBuilder<UserContractsBloc, UserContractsState>(
        builder: (context, state) {

          if (state is UserContractsIsLoadedState) {
            return ListView.builder(

                itemBuilder: (context, index) {
                  return buildActiveContractCard(index, state.getActiveContracts.contracts[index]);
                },
                itemCount: state.getActiveContracts.contracts.length,
                shrinkWrap: true);
          } else if (state is UserContractsIsLoadingState) {
            return ListView.builder(

                itemBuilder: (context, index) {
                  return buildActiveContractCard(0, null);
                },
                itemCount: 2,
                shrinkWrap: true);//Center(child: SizedBox(width: 50, height: 50,child: CircularProgressIndicator()));
          } else {
            return Center(child: Text("error"));
          }
        });
  }

  Widget buildRepaymentContractList() {

    return BlocBuilder<UserContractsBloc, UserContractsState>(
        builder: (context, state) {

          if (state is UserContractsIsLoadedState) {
            return ListView.builder(

                itemBuilder: (context, index) {
                  return buildRepaymentContractCard(index, state.getPendingContracts.contracts[index]);
                },
                itemCount: state.getPendingContracts.contracts.length,
                shrinkWrap: true);
          } else if (state is UserContractsIsLoadingState) {
            return ListView.builder(

                itemBuilder: (context, index) {
                  return buildRepaymentContractCard(0, null);
                },
                itemCount: 2,
                shrinkWrap: true);//Center(child: SizedBox(width: 50, height: 50,child: CircularProgressIndicator()));
          } else {
            return Center(child: Text("error"));
          }
        });
  }

  Widget buildCompleteContractCard(var index, Contract contract) {
    return Container(
      height: 100,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        elevation: 5,
        child: InkWell(
          onTap: () {

            print("test");
          },
          child: ListTile(
            leading: FlutterLogo(),
            title: Text("<Bill Issuer>", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700], fontSize: 16)),
            subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget> [
              Text("Paid in full on <date>", style: TextStyle(color: Colors.grey[600], fontSize: 14)),
              Text("<amount> from <name>", style: TextStyle(color: Colors.grey[600], fontSize: 14))
            ])
          ),
        ),
      ),
    );/*Container(
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
            ])));*/
  }

  Widget buildActiveContractCard(var index, Contract contract) {
    return Container(
      height: 100,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        elevation: 5,
        child: InkWell(
          onTap: () {

            print("test");
          },
          child: ListTile(
              leading: FlutterLogo(),
              title: Text("<Bill Issuer>", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700], fontSize: 16)),
              subtitle: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 40.0, 0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget> [
                  Text("<Time Left>", style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                  LinearProgressIndicator(),
                  Text("<amount> from <name>", style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text("<Amount Left>", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600], fontSize: 14)))
                ]),
              )
          ),
        ),
      ),
    );
    /*return Container(
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
            ])));*/
  }

  Widget buildRepaymentContractCard(var index, Contract contract) {
    return Container(
      height: 100,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        elevation: 5,
        child: InkWell(
          onTap: () {

            print("test");
          },
          child: ListTile(
              leading: FlutterLogo(),
              title: Text("<Bill Issuer>", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700], fontSize: 16)),
              subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,children: <Widget> [
                Text("<duration> repayment", style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                Text("<amount> from <name>", style: TextStyle(color: Colors.grey[600], fontSize: 14))
              ]),
            trailing: Icon(Icons.priority_high, color: Colors.grey[700]),
          ),
        ),
      ),
    );
    /*return Container(
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
            ])));*/
  }
}
