import 'package:bloc/bloc.dart';
import 'package:frequencypay/models/contract_model.dart';
import 'package:frequencypay/services/firestore_db_service.dart';
import 'package:frequencypay/services/search_queries/contract_search_query.dart';

//Events
class UserContractsEvent {}

class LoadUserContractsEvent extends UserContractsEvent {}

//States
class UserContractsState {}

class UserContractsIsLoadingState extends UserContractsState {}

class UserContractsIsLoadedState extends UserContractsState {
  final _completeContracts;
  final _activeContracts;
  final _pendingContracts;

  UserContractsIsLoadedState(
      this._completeContracts, this._activeContracts, this._pendingContracts);

  ContractListModel get getCompleteContracts => _completeContracts;
  ContractListModel get getActiveContracts => _activeContracts;
  ContractListModel get getPendingContracts => _pendingContracts;
}

class UserContractsIsNotLoadedState extends UserContractsState {}

class UserContractsBloc extends Bloc<UserContractsEvent, UserContractsState> {
  FirestoreService _service;

  UserContractsBloc(this._service) : super(UserContractsIsLoadingState());

  @override
  Stream<UserContractsState> mapEventToState(UserContractsEvent event) async* {
    if (event is LoadUserContractsEvent) {
      yield UserContractsIsLoadingState();

      try {
        ContractListModel completeContracts = ContractListModel(await _service
            .retrieveContracts(ContractSearchQuery.COMPLETE_CONTRACTS())
            .first);

        List<Contract> activeContractsList = await _service
            .retrieveContracts(ContractSearchQuery.BORROWER_ACTIVE_CONTRACTS())
            .first;

        activeContractsList.addAll(await _service
            .retrieveContracts(ContractSearchQuery.LENDER_ACTIVE_CONTRACTS())
            .first);

        ContractListModel activeContracts =
            ContractListModel(activeContractsList);

        List<Contract> pendingContractsList = await _service
            .retrieveContracts(ContractSearchQuery.INBOUND_PENDING_CONTRACTS())
            .first;
        pendingContractsList.addAll(await _service
            .retrieveContracts(ContractSearchQuery.OUTBOUND_PENDING_CONTRACTS())
            .first);

        ContractListModel pendingContracts =
            ContractListModel(pendingContractsList);

        yield UserContractsIsLoadedState(
            completeContracts, activeContracts, pendingContracts);
      } catch (_) {
        print("Error loading contracts: " + _.toString());
        yield UserContractsIsNotLoadedState();
      }
    }
  }
}
