import 'package:frequencypay/models/contract_model.dart';
import 'package:frequencypay/services/search_queries/contract_search_query.dart';

import 'firestore_db_service.dart';

class ContractService {

  FirestoreService data;

  List<Contract> activeContracts;

  //This is a flag that marks initialization
  Future _doneFuture;

  ContractService(this.data) {

    _doneFuture = loadActiveContracts();
  }

  //Returns whether the class is initialized
  Future get initializationDone => _doneFuture;

  //Used to initialize or update the active contracts list
  Future loadActiveContracts() async{

    activeContracts = await data.retrieveContracts(ContractSearchQuery.BORROWER_ACTIVE_CONTRACTS()).first;
  }

  //Returns the amount of time (days, weeks, months, years) until the last contract is repaid
  Future<RepaymentOverview> getRepaymentOverview() async{

    //Wait until initialization is finished
    await initializationDone;

    RepaymentOverview overview;

    //If no active contracts exist
    if (activeContracts.length == 0) {

      //Return no overview
      overview = null;
    } else {

      //The current contract
      Contract current;
      double currentAmount;
      double currentAmountPaid;
      DateTime currentFinalPayment;

      //The current total amount
      double totalAmount = 0.0;
      double totalAmountPaid = 0.0;

      //The current latest date
      DateTime latestDate = DateTime.now();

      //For each active contract
      for (int index = 0; index < activeContracts.length; index++) {

        //Retrieve the contract
        current = activeContracts[index];

        //Retrieve the total and paid back amounts
        currentAmount = current.terms.amount;
        currentAmountPaid = 0;//TODO Make this actually read the amount paid back

        //Add the amounts to the totals
        totalAmount += currentAmount;
        totalAmountPaid += currentAmountPaid;

        //Retrieve the contract's final scheduled payment date
        currentFinalPayment = _finalPaymentTime(current);

        if (latestDate.isBefore(currentFinalPayment)) {

          latestDate = currentFinalPayment;
        }
      }

      //Get the duration of time until the final payment
      int daysLeft = latestDate.difference(DateTime.now()).inDays;

      //Convert the duration into string format
      String duration = _convertDuration(daysLeft);

      //Compute the payback ratio
      String paybackRatio = (totalAmountPaid / totalAmount * 100).toString();

      overview = RepaymentOverview(paybackRatio, duration);
    }

    //Return overview
    return overview;
  }

  //Attempts to retrieve the time of the final transaction of a given contract
  DateTime _finalPaymentTime(Contract contract) {

    DateTime result;

    try {

      result = contract.scheduledTransactions.last.time;
    } catch (_) {

      print("Error retrieving final transaction: " + _.toString());
    }

    return result;
  }

  //Converts a number of days into a string representation of the duration it represents
  String _convertDuration(int days) {

    int numberComponent;
    String typeComponent;

    if (days < 0) {

      numberComponent = -1;
      typeComponent = " invalid duration";
    } else if (days < 7) {

      numberComponent = days;
      typeComponent = " days";
    } else if (days < 60) {

      numberComponent = (days / 7).round();
      typeComponent = " weeks";
    } else if (days < 730) {

      numberComponent = (days / 30).round();
      typeComponent = " months";
    } else {

      numberComponent = (days / 730).round();
      typeComponent = " years";
    }

    return numberComponent.toString() + typeComponent;
  }

  //Accepts a contract request
  void acceptContractRequest(Contract contract) {

    //Compute the transactions using the current moment to begin the schedule
    List<ScheduledTransaction> repaymentTransactions = _computeFutureTransactions(contract, DateTime.now());

    //Convert the transactions to serializable data
    List serializableTransactions = _convertTransactions(repaymentTransactions);

    //Send the contract data
    data.acceptEstablishContract(contract, serializableTransactions);
  }

  //Computes a series of dated transactions required to repay a contract
  List<ScheduledTransaction> _computeFutureTransactions(Contract contract, DateTime startTime) {

    //The list of transactions
    List<ScheduledTransaction> transactions = List<ScheduledTransaction>();

    //The current transaction
    ScheduledTransaction currentTransaction;

    //The next time to schedule a transaction
    DateTime currentTime = startTime;

    //The amount of time between each transaction
    Duration timeBetweenTransactions = Duration(days: contract.terms.frequencyWeeks * 7);

    //Start at the first payment date after the start time
    currentTime = currentTime.add(timeBetweenTransactions);

    //The amount currently repaid
    var amountRepaid = 0.0;

    //The standard payment amount
    var repaymentAmount = contract.terms.repaymentAmount;

    //Until the contract is fully repaid
    while (amountRepaid <= contract.terms.amount - repaymentAmount) {

      //Create a new transaction
      currentTransaction = ScheduledTransaction(repaymentAmount, currentTime);
      transactions.add(currentTransaction);

      //Count amount as repaid
      amountRepaid += repaymentAmount;

      //Move forward in time
      currentTime = currentTime.add(timeBetweenTransactions);
    }

    //In case the repayment amount isn't an even divider of the total amount
    if (amountRepaid < contract.terms.amount) {

      //Schedule a final transaction for less than the repayment amount
      currentTransaction = ScheduledTransaction(contract.terms.amount - amountRepaid, currentTime);
      transactions.add(currentTransaction);
    }

    return transactions;
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

//Just a simple bag of data about the status of repayment
class RepaymentOverview {

  final String percentCompletion;
  final String timeUntilCompletion;

  RepaymentOverview(this.percentCompletion, this.timeUntilCompletion);
}