class Contract {
  //the contract properties we want:
  final String requester;
  final String loaner;
  final String requesterName;
  final String loanerName;
  final String dueDate;
  final double numPayments;
  final double amount;
  final CONTRACT_STATE state;

  Contract({
    this.requester,
    this.loaner,
    this.requesterName,
    this.loanerName,
    this.dueDate,
    this.numPayments,
    this.amount,
    this.state
  });

}

enum CONTRACT_STATE {

  OPEN_REQUEST,
  ACTIVE_CONTRACT,
  COMPLETED_CONTRACT
}

CONTRACT_STATE contractStateFromString(String str) {
  return CONTRACT_STATE.values.firstWhere((e) => e.toString() == str);
}


class ContractListModel {
  //The contracts
  List<Contract> contracts;
  ContractListModel(List<Contract> this.contracts);
}