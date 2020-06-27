import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frequencypay/models/contract_model.dart';
import 'package:frequencypay/pages/contract_list.dart';
import 'package:frequencypay/services/firestore_db_service.dart';
import 'package:provider/provider.dart';

class DisplayContracts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Contract>>.value(
      value: FirestoreService().contracts,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Current Contracts in the database"),
        ),
        body: ContractsList(),

      ),
    );
  }
}
