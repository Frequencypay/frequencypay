import 'package:bloc/bloc.dart';
import 'package:frequencypay/PLACEHOLDERS/PlaceholderDataService.dart';
import 'package:frequencypay/PLACEHOLDERS/PlaceholderUserBillsModel.dart';
import 'package:frequencypay/PLACEHOLDERS/PlaceholderUserContractsModel.dart';

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

  final _contracts;

  UserContractsIsLoadedState(PlaceholderUserContractsModel this._contracts);

  PlaceholderUserContractsModel get getContracts => _contracts;
}

class UserBillsIsNotLoadedState extends UserContractsState {

}

class UserBillsBloc extends Bloc<UserContractsEvent, UserContractsState> {

  PlaceholderDataService service;

  UserBillsBloc(PlaceholderDataService service);

  @override
  UserContractsState get initialState => UserContractsIsLoadingState();

  @override
  Stream<UserContractsState> mapEventToState(UserContractsEvent event) async*{

    if (event is LoadUserContractsEvent) {
      yield UserContractsIsLoadingState();

      try {

        PlaceholderUserContractsModel contracts = await service.getLocalUserActiveContractsModel();
        yield UserContractsIsLoadedState(contracts);
      } catch (_){

        print(_);
        yield UserBillsIsNotLoadedState();
      }
    }
  }
}