import 'package:bloc/bloc.dart';
import 'package:frequencypay/PLACEHOLDERS/PlaceholderDataService.dart';
import 'package:frequencypay/PLACEHOLDERS/PlaceholderUserBillsModel.dart';
import 'package:frequencypay/PLACEHOLDERS/PlaceholderUserContractsModel.dart';

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

  final _expenses;
  final _activeContracts;

  UserBillsIsLoadedState(PlaceholderUserBillsModel this._expenses, PlaceholderUserContractsModel this._activeContracts);

  PlaceholderUserBillsModel get getExpenses => _expenses;
  PlaceholderUserContractsModel get getContracts => _activeContracts;
}

class UserBillsIsNotLoadedState extends UserBillsState {

}

class UserBillsBloc extends Bloc<UserBillsEvent, UserBillsState> {

  PlaceholderDataService service;

  UserBillsBloc(PlaceholderDataService service);

  @override
  UserBillsState get initialState => UserBillsIsLoadingState();

  @override
  Stream<UserBillsState> mapEventToState(UserBillsEvent event) async*{

    if (event is LoadUserBillsEvent) {
      yield UserBillsIsLoadingState();

      try {

        PlaceholderUserBillsModel userExpenses = await service.getLocalUserBillsModel();
        PlaceholderUserContractsModel activeContracts = await service.getLocalUserActiveContractsModel();
        yield UserBillsIsLoadedState(userExpenses, activeContracts);
      } catch (_){

        print(_);
        yield UserBillsIsNotLoadedState();
      }
    }
  }
}