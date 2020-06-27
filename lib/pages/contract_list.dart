//responsible for cycling through contracts
import 'package:flutter/material.dart';
import 'package:frequencypay/models/contract_model.dart';
import 'package:provider/provider.dart';
import 'package:frequencypay/pages/contract_tile.dart';

class ContractsList extends StatefulWidget {
  @override
  _ContractsListState createState() => _ContractsListState();
}

class _ContractsListState extends State<ContractsList> {
  @override
  Widget build(BuildContext context) {
    final contracts=Provider.of<List<Contract>>(context);


    return ListView.builder(
      itemCount: contracts.length,
      itemBuilder: (context,index) {
        return ContractTile(contract:contracts[index]);

      },
    );
  }
}
