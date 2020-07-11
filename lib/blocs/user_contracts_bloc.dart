import 'package:bloc/bloc.dart';
import 'package:frequencypay/PLACEHOLDERS/PlaceholderDataService.dart';
import 'package:frequencypay/PLACEHOLDERS/PlaceholderUserBillsModel.dart';
import 'package:frequencypay/PLACEHOLDERS/PlaceholderUserContractsModel.dart';
import 'package:frequencypay/models/contract_model.dart';
import 'package:frequencypay/services/firestore_db_service.dart';

//Events
class UserContractsEvent {

}

class LoadUserContractsEvent extends UserContractsEvent {

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

  UserContractsIsLoadedState(ContractListModel this._completeContracts, ContractListModel this._activeContracts, ContractListModel this._pendingContracts);

  ContractListModel get getCompleteContracts => _completeContracts;
  ContractListModel get getActiveContracts => _activeContracts;
  ContractListModel get getPendingContracts => _pendingContracts;
}

class UserContractsIsNotLoadedState extends UserContractsState {

}

class UserContractsBloc extends Bloc<UserContractsEvent, UserContractsState> {

  FirestoreService _service;

  UserContractsBloc(FirestoreService this._service);

  @override
  UserContractsState get initialState => UserContractsIsLoadingState();

  @override
  Stream<UserContractsState> mapEventToState(UserContractsEvent event) async*{

    if (event is LoadUserContractsEvent) {
      yield UserContractsIsLoadingState();

      try {


        /*ContractListModel completeContracts = await _service.getCompleteUserContracts();
        ContractListModel activeContracts = await _service.getActiveUserContracts();
        ContractListModel pendingContracts = await _service.getPendingUserContracts();*/

        ContractListModel completeContracts = ContractListModel([Contract(requester: "Borrower", loaner: "Lender", dueDate: "August 20", numPayments: 5, amount: 10.0, isActive: true)]);
        ContractListModel activeContracts = ContractListModel([Contract(requester: "Borrower", loaner: "Lender", dueDate: "August 20", numPayments: 5, amount: 10.0, isActive: true)]);
        ContractListModel pendingContracts = ContractListModel([Contract(requester: "Borrower", loaner: "Lender", dueDate: "August 20", numPayments: 5, amount: 10.0, isActive: true)]);

        yield UserContractsIsLoadedState(completeContracts, activeContracts, pendingContracts);
      } catch (_){

        print(_);
        yield UserContractsIsNotLoadedState();
      }
    }
  }
}