import 'package:bloc/bloc.dart';
import 'package:frequencypay/models/contract_model.dart';
import 'package:frequencypay/services/firestore_db_service.dart';

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

        //PlaceholderUserBillsModel userExpenses = await service.getLocalUserBillsModel();
        ContractListModel activeContracts = ContractListModel([Contract(requester: "Borrower", loaner: "Lender", dueDate: "August 20", numPayments: 5, amount: 10.0, state: CONTRACT_STATE.OPEN_REQUEST)]);
        yield UserBillsIsLoadedState(activeContracts);
      } catch (_){

        print(_);
        yield UserBillsIsNotLoadedState();
      }
    }
  }
}