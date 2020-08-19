import 'package:bloc/bloc.dart';
import 'package:frequencypay/models/contract_model.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/services/contract_service.dart';
import 'package:frequencypay/services/firestore_db_service.dart';
import 'package:frequencypay/services/search_queries/contract_search_query.dart';

//Events
class UserContractsEvent {

}

class LoadUserContractsEvent extends UserContractsEvent {

}

class ReloadUserContractsEvent extends UserContractsEvent {


}

//States
class UserContractsState {

}

class UserContractsIsLoadingState extends UserContractsState {

}

class UserContractsIsLoadedState extends UserContractsState {

  final _completeContracts;
  final _activeContracts;
  final _pendingContracts;
  final _activeNotifications;

  UserContractsIsLoadedState(ContractListModel this._completeContracts, ContractListModel this._activeContracts, ContractListModel this._pendingContracts, List<bool> this._activeNotifications);

  ContractListModel get getCompleteContracts => _completeContracts;
  ContractListModel get getActiveContracts => _activeContracts;
  ContractListModel get getPendingContracts => _pendingContracts;
  List<bool> get getActiveNotifications => _activeNotifications;
}

class UserContractsIsNotLoadedState extends UserContractsState {

}

class UserContractsBloc extends Bloc<UserContractsEvent, UserContractsState> {

  FirestoreService _service;
  ContractService _contractService;

  ContractListModel completeContracts;
  ContractListModel activeContracts;
  ContractListModel pendingContracts;
  List<bool> activeNotifications;

  UserContractsBloc(this._service, this._contractService);

  @override
  UserContractsState get initialState => UserContractsIsLoadingState();

  @override
  Stream<UserContractsState> mapEventToState(UserContractsEvent event) async*{

    if (event is LoadUserContractsEvent) {
      yield UserContractsIsLoadingState();

      try {

        await _loadContracts();

        yield UserContractsIsLoadedState(completeContracts, activeContracts, pendingContracts, activeNotifications);
      } catch (_, stacktrace){

        print("Error loading contracts: " + _.toString());
        print(stacktrace);

        yield UserContractsIsNotLoadedState();
      }
    } else if (event is ReloadUserContractsEvent) {

      yield UserContractsIsLoadingState();

      await _loadContracts();

      yield UserContractsIsLoadedState(completeContracts, activeContracts, pendingContracts, activeNotifications);
    }
  }

  Future _loadContracts() async{

    Stream<UserData> userStream = _service.userData;
    UserData currentUser = await userStream.first;

    completeContracts = ContractListModel(await _service.retrieveContracts(ContractSearchQuery.COMPLETE_CONTRACTS()).first);

    List<Contract> activeContractsList = await _service.retrieveContracts(ContractSearchQuery.BORROWER_ACTIVE_CONTRACTS()).first;

    activeContractsList.addAll(await _service.retrieveContracts(ContractSearchQuery.LENDER_ACTIVE_CONTRACTS()).first);

    activeContracts = ContractListModel(activeContractsList);

    List<Contract> pendingContractsList = await _service.retrieveContracts(ContractSearchQuery.INBOUND_PENDING_CONTRACTS()).first;
    pendingContractsList.addAll(await _service.retrieveContracts(ContractSearchQuery.OUTBOUND_PENDING_CONTRACTS()).first);

    pendingContracts = ContractListModel(pendingContractsList);

    activeNotifications = await getActiveNotifications(pendingContractsList);
  }

  Future<List<bool>> getActiveNotifications(List<Contract> contracts) async{

    List<bool> activeNotifications = List<bool>();

    for (int index = 0; index < contracts.length; index++) {

      activeNotifications.add(await _contractService.waitingOnUser(contracts[index]));
    }

    return activeNotifications;
  }
}