import 'package:frequencypay/services/contract_service.dart';

class Contract {
  //the contract properties we want:
  final String uid;
  final String requester;
  final String loaner;
  final String requesterName;
  final String loanerName;
  final String dateAccepted;
  final CONTRACT_STATE state;
  final WAIT_STATE waitState;

  DateTime dueDate;
  RepaymentTerms terms;
  RepaymentStatus repaymentStatus;
  List<ScheduledTransaction> scheduledTransactions;

  double get repaymentProgress => (1.0 - repaymentStatus.remainingAmount / terms.amount);

  Contract(
      {this.uid,
      this.requester,
      this.loaner,
      this.requesterName,
      this.loanerName,
      this.dateAccepted,
      this.state,
      this.waitState,
      String dueDateString,
      List terms,
      List repayment,
      List transactions}) {

    this.terms = RepaymentTerms.fromList(terms);

    dueDate = DateTime.parse(dueDateString);

    if (repayment == null) {

      this.repaymentStatus = null;
    } else {

      this.repaymentStatus = RepaymentStatus.fromList(repayment);
    }

    if (transactions == null) {

      scheduledTransactions = null;
    } else {

      scheduledTransactions = ScheduledTransaction.fromList(transactions);
    }
  }
}

//The status of the contract along its lifetime
enum CONTRACT_STATE { OPEN_REQUEST, REJECTED_REQUEST, ACTIVE_CONTRACT, COMPLETED_CONTRACT}

//Who the contract request is waiting on
enum WAIT_STATE { ON_LENDER, ON_BORROWER, NONE}

CONTRACT_STATE contractStateFromString(String str) {
  return CONTRACT_STATE.values.firstWhere((e) => e.toString() == str);
}

WAIT_STATE waitStateFromString(String str) {
  return WAIT_STATE.values.firstWhere((e) => e.toString() == str);
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

class RepaymentStatus {

  final double remainingAmount;
  final int missedPayments;

  RepaymentStatus(this.remainingAmount, this.missedPayments);

  //Returns a list of the class members for JSON serialization
  List toList() {
    return [remainingAmount, missedPayments];
  }

  //Converts a JSON serialized list into a class member
  static RepaymentStatus fromList(List data) {


    RepaymentStatus status = RepaymentStatus(data[0].toDouble(), data[1]);

    return status;
  }
}