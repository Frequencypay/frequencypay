import 'package:bloc/bloc.dart';
import 'package:frequencypay/models/contract_model.dart';
import 'package:frequencypay/services/contract_service.dart';
import 'package:frequencypay/services/firestore_db_service.dart';

//Events
class ContractDetailsEvent {}

class LoadContractDetailsEvent extends ContractDetailsEvent {
  final Contract contract;

  LoadContractDetailsEvent(this.contract);
}

class EstablishContractContractDetailsEvent extends ContractDetailsEvent {}

//States
class ContractDetailsState {}

class ContractDetailsIsLoadingState extends ContractDetailsState {}

class ContractDetailsIsLoadedState extends ContractDetailsState {
  final _contract;

  ContractDetailsIsLoadedState(this._contract);

  Contract get getContract => _contract;
}

class ContractDetailsIsNotLoadedState extends ContractDetailsState {}

class ContractDetailsBloc
    extends Bloc<ContractDetailsEvent, ContractDetailsState> {
  final FirestoreService service;
  final ContractService contractService;

  Contract loadedContract;

  ContractDetailsBloc(this.service, this.contractService)
      : super(ContractDetailsIsLoadingState());

  @override
  Stream<ContractDetailsState> mapEventToState(
      ContractDetailsEvent event) async* {
    if (event is LoadContractDetailsEvent) {
      yield ContractDetailsIsLoadingState();

      try {
        loadedContract = event.contract;

        yield ContractDetailsIsLoadedState(loadedContract);
      } catch (_) {
        print(_);
        yield ContractDetailsIsNotLoadedState();
      }
    } else if (event is EstablishContractContractDetailsEvent) {
      try {
        contractService.acceptContractRequest(loadedContract);
      } catch (_) {
        print(_);
      }
    }
  }
}
