import 'package:frequencypay/models/contract_model.dart';

import 'firestore_db_service.dart';

class ContractService {

  FirestoreService data;

  ContractService(this.data);

  //Computes a series of dated transactions required to repay a contract
  List<ScheduledTransaction> _computeFutureTransactions(Contract contract) {

    List<ScheduledTransaction> transactions = List<ScheduledTransaction>();



    return [ScheduledTransaction(500, DateTime.now())];
  }

  //Accepts a contract request
  void acceptContractRequest(Contract contract) {

    List<ScheduledTransaction> repaymentTransactions = _computeFutureTransactions(null);

    List serializableTransactions = _convertTransactions(repaymentTransactions);

    data.acceptEstablishContract(contract, serializableTransactions);
  }

  //Converts a scheduled transaction list into a serializable list
  List _convertTransactions(List<ScheduledTransaction> transactions) {

    List converted = List();

    List currentItems;

    //For each transaction
    for (int index = 0; index < transactions.length; index++) {

      currentItems = transactions[index].toList();

      //Add the transaction to the list
      converted.addAll(currentItems);
    }

    return converted;
  }
}