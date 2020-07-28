import 'package:bloc/bloc.dart';
import 'package:frequencypay/models/contract_model.dart';
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
  final _activeContracts;

  UserBillsIsLoadedState(ContractListModel this._activeContracts);

  //PlaceholderUserBillsModel get getExpenses => _expenses;
  ContractListModel get getContracts => _activeContracts;
}

class UserBillsIsNotLoadedState extends UserBillsState {

}

class UserBillsBloc extends Bloc<UserBillsEvent, UserBillsState> {

  FirestoreService _service;

  UserBillsBloc(FirestoreService this._service);

  @override
  UserBillsState get initialState => UserBillsIsLoadingState();

  @override
  Stream<UserBillsState> mapEventToState(UserBillsEvent event) async*{

    if (event is LoadUserBillsEvent) {
      yield UserBillsIsLoadingState();

      try {

        List<Contract> activeContracts = await _service.retrieveContracts(ContractSearchQuery.INBOUND_PENDING_CONTRACTS()).first;

        yield UserBillsIsLoadedState(ContractListModel(activeContracts));
      } catch (_){

        print(_);
        yield UserBillsIsNotLoadedState();
      }
    }
  }
}