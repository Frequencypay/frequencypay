class Contract {
  //the contract properties we want:
  final String requester;
  final String loaner;
  final String dueDate;
  final double numPayments;
  final double amount;
  final bool isActive; //status: active or completed

  Contract({
    this.requester,
    this.loaner,
    this.dueDate,
    this.numPayments,
    this.amount,
    this.isActive
  });

}

class ContractListModel {

  //The contracts
  List<Contract> contracts;

  ContractListModel(List<Contract> this.contracts);
}