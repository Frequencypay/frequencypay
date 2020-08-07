import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:frequencypay/models/contract_model.dart';
import 'package:frequencypay/services/contract_service.dart';
import 'package:frequencypay/services/firestore_db_service.dart';
import 'package:frequencypay/services/search_queries/contract_search_query.dart';

//Events
class UserBillsEvent {

}

class LoadUserBillsEvent extends UserBillsEvent {

}

//States
class UserBillsState {

}

class UserBillsIsLoadingState extends UserBillsState {

}

class UserBillsIsLoadedState extends UserBillsState {

  //final _expenses;
  final _pendingContracts;
  final _activeNotifications;

  UserBillsIsLoadedState(this._pendingContracts, this._activeNotifications);

  ContractListModel get getContracts => _pendingContracts;
  List<bool> get getActiveNotifications => _activeNotifications;
}

class UserBillsIsNotLoadedState extends UserBillsState {

}

class UserBillsBloc extends Bloc<UserBillsEvent, UserBillsState> {

  FirestoreService _service;

  ContractService _contractService;

  UserBillsBloc(FirestoreService this._service, ContractService this._contractService);

  @override
  UserBillsState get initialState => UserBillsIsLoadingState();

  @override
  Stream<UserBillsState> mapEventToState(UserBillsEvent event) async*{

    if (event is LoadUserBillsEvent) {
      yield UserBillsIsLoadingState();

      try {

        List<Contract> pendingContractsList = await _service.retrieveContracts(ContractSearchQuery.INBOUND_PENDING_CONTRACTS()).first;

        List<bool> activeNotifications = await getActiveNotifications(pendingContractsList);

        yield UserBillsIsLoadedState(ContractListModel(pendingContractsList), activeNotifications);
      } catch (_){

        print(_);
        yield UserBillsIsNotLoadedState();
      }
    }
  }

  Future<List<bool>> getActiveNotifications(List<Contract> contracts) async{

    List<bool> activeNotifications = List<bool>();

    for (int index = 0; index < contracts.length; index++) {

      activeNotifications.add(await _contractService.waitingOnUser(contracts[index]));
    }

    return activeNotifications;
  }
}