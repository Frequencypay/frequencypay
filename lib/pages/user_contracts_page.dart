import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frequencypay/blocs/user_contracts_bloc.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/services/firestore_db_service.dart';
import 'package:frequencypay/widgets/app_bar_header.dart';
import 'package:frequencypay/widgets/contract_cards.dart';
import 'package:frequencypay/widgets/loan_request_button.dart';
import 'package:provider/provider.dart';

class UserContractsPage extends StatefulWidget {
  @override
  _UserContractsPageState createState() {
    return _UserContractsPageState();
  }
}

class _UserContractsPageState extends State<UserContractsPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  UserContractsBloc createBloc(var context) {
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
        initialIndex: 2,
        child: Scaffold(
            appBar: CustomAppBar('Contracts', context),
            floatingActionButton:
                LoanRequestWidgets.LoanRequestFloatingActionButton(context),
            body: Column(
              children: <Widget>[
                SizedBox(height: 20),
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
              return ContractCards.buildCompleteContractCard(
                  context, state.getCompleteContracts.contracts[index]);
            },
            itemCount: state.getCompleteContracts.contracts.length,
            shrinkWrap: true);
      } else if (state is UserContractsIsLoadingState) {
        return Center(
            child: SizedBox(
                width: 50, height: 50, child: CircularProgressIndicator()));
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
              return ContractCards.buildActiveContractCard(
                  context, state.getActiveContracts.contracts[index]);
            },
            itemCount: state.getActiveContracts.contracts.length,
            shrinkWrap: true);
      } else if (state is UserContractsIsLoadingState) {
        return Center(
            child: SizedBox(
                width: 50, height: 50, child: CircularProgressIndicator()));
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
              return ContractCards.buildRepaymentContractCard(
                  context, state.getPendingContracts.contracts[index]);
            },
            itemCount: state.getPendingContracts.contracts.length,
            shrinkWrap: true);
      } else if (state is UserContractsIsLoadingState) {
        return Center(
            child: SizedBox(
                width: 50, height: 50, child: CircularProgressIndicator()));
      } else {
        return Center(child: Text("error"));
      }
    });
  }
}
