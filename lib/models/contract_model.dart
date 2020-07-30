import 'package:frequencypay/services/contract_service.dart';

class Contract {
  //the contract properties we want:
  final String uid;
  final String requester;
  final String loaner;
  final String requesterName;
  final String loanerName;
  final String dueDate;
  final String dateAccepted;
  final CONTRACT_STATE state;

  RepaymentTerms terms;
  List<ScheduledTransaction> scheduledTransactions;

  Contract(
      {this.uid,
      this.requester,
      this.loaner,
      this.requesterName,
      this.loanerName,
      this.dueDate,
      this.dateAccepted,
      this.state,
      List terms,
      List transactions}) {

    this.terms = RepaymentTerms.fromList(terms);

    if (transactions == null) {
      scheduledTransactions = null;
    } else {
      scheduledTransactions = ScheduledTransaction.fromList(transactions);
    }
  }
}

enum CONTRACT_STATE { OPEN_REQUEST, ACTIVE_CONTRACT, COMPLETED_CONTRACT }

CONTRACT_STATE contractStateFromString(String str) {
  return CONTRACT_STATE.values.firstWhere((e) => e.toString() == str);
}

class ContractListModel {
  //The contracts
  List<Contract> contracts;

  ContractListModel(List<Contract> this.contracts);
}

class ScheduledTransaction {
  static const int MEMBERS_PER_TRANSACTION = 2;

  final amount;
  final DateTime time;

  ScheduledTransaction(this.amount, this.time);

  //Returns a list of the class members for JSON serialization
  List toList() {
    return [amount, time.toIso8601String()];
  }

  //Converts a JSON serialized list into a list of class members
  static List<ScheduledTransaction> fromList(List data) {
    List<ScheduledTransaction> transactions = List<ScheduledTransaction>();

    ScheduledTransaction currentTransaction;

    for (int index = 0; index < data.length; index += MEMBERS_PER_TRANSACTION) {
      currentTransaction =
          ScheduledTransaction(data[index], DateTime.parse(data[index + 1]));
      transactions.add(currentTransaction);
    }

    return transactions;
  }
}

class RepaymentTerms {
  final double amount;
  final double repaymentAmount;
  final int frequencyWeeks;

  RepaymentTerms(this.amount, this.repaymentAmount, this.frequencyWeeks);

  //Returns a list of the class members for JSON serialization
  List toList() {
    return [amount, repaymentAmount, frequencyWeeks];
  }

  //Converts a JSON serialized list into a class member
  static RepaymentTerms fromList(List data) {
    RepaymentTerms terms = RepaymentTerms(data[0], data[1], data[2]);

    return terms;
  }
}
