class Contract {
  //the contract properties we want:
  final String requester;
  final String loaner;
  final String requesterName;
  final String loanerName;
  final String dueDate;
  final double numPayments;
  final double amount;
  final bool isActive; //status: active or completed
  final bool isComplete;
  final bool isPending;

  Contract({
    this.requester,
    this.loaner,
    this.requesterName,
    this.loanerName,
    this.dueDate,
    this.numPayments,
    this.amount,
    this.isActive,
    this.isComplete,
    this.isPending
  });

}

class ContractListModel {
  //The contracts
  List<Contract> contracts;
  ContractListModel(List<Contract> this.contracts);
}