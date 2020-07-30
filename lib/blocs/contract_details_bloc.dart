import 'package:bloc/bloc.dart';
import 'package:frequencypay/models/contract_model.dart';
import 'package:frequencypay/services/contract_service.dart';
import 'package:frequencypay/services/firestore_db_service.dart';

//Events
class ContractDetailsEvent {

}

class LoadContractDetailsEvent extends ContractDetailsEvent {

  final Contract contract;

  LoadContractDetailsEvent(this.contract);
}

class EstablishContractContractDetailsEvent extends ContractDetailsEvent {

}

//States
class ContractDetailsState {

}

class ContractDetailsIsLoadingState extends ContractDetailsState {

}

class ContractDetailsIsLoadedState extends ContractDetailsState {

  final _contract;
  final _finalPaymentDate;
  final _repaymentProjection;

  ContractDetailsIsLoadedState(this._contract, this._finalPaymentDate, this._repaymentProjection);

  Contract get getContract => _contract;
  DateTime get getFinalPaymentDate => _finalPaymentDate;
  RepaymentProjection get getRepaymentProjection => _repaymentProjection;
}

class ContractDetailsIsNotLoadedState extends ContractDetailsState {

}

class ContractDetailsBloc extends Bloc<ContractDetailsEvent, ContractDetailsState> {

  final FirestoreService service;
  final ContractService contractService;

  Contract loadedContract;

  ContractDetailsBloc(this.service, this.contractService);

  @override
  ContractDetailsState get initialState => ContractDetailsIsLoadingState();

  @override
  Stream<ContractDetailsState> mapEventToState(ContractDetailsEvent event) async*{

    if (event is LoadContractDetailsEvent) {
      yield ContractDetailsIsLoadingState();

      try {

        loadedContract = event.contract;

        //The date of the final payment of an active or completed contract
        DateTime finalPaymentDate = contractService.finalPaymentTime(loadedContract);

        //The projected repayment information of a contract request
        RepaymentProjection repaymentProjection = contractService.projectRepayment(loadedContract);

        yield ContractDetailsIsLoadedState(loadedContract, finalPaymentDate, repaymentProjection);
      } catch (_){

        print(_);
        yield ContractDetailsIsNotLoadedState();
      }
    } else if (event is EstablishContractContractDetailsEvent) {

      try {

        contractService.acceptContractRequest(loadedContract);

        //TODO: make callback to contract details
      } catch (_){

        print(_);
      }
    }
  }
}