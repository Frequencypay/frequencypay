import 'package:bloc/bloc.dart';

//Events
class ContractDetailsEvent {

}

class LoadContractDetailsEvent extends ContractDetailsEvent {

}

//States
class ContractDetailsState {

}

class ContractDetailsIsLoadingState extends ContractDetailsState {

}

class ContractDetailsIsLoadedState extends ContractDetailsState {

  //final _contract;

  //ContractDetailsIsLoadedState(PlaceholderUserContractsModel this._contract);

  //Implement getters for each portion of the contract needed by the screen?
  //PlaceholderUserContractsModel get getContract => _contract;
}

class ContractDetailsIsNotLoadedState extends ContractDetailsState {

}

class ContractDetailsBloc extends Bloc<ContractDetailsEvent, ContractDetailsState> {

  //PlaceholderDataService service;

  //ContractDetailsBloc(PlaceholderDataService service);

  @override
  ContractDetailsState get initialState => ContractDetailsIsLoadingState();

  @override
  Stream<ContractDetailsState> mapEventToState(ContractDetailsEvent event) async*{

    if (event is LoadContractDetailsEvent) {
      yield ContractDetailsIsLoadingState();

      try {

        //PlaceholderUserContractsModel contract = await service.getLocalUserActiveContractsModel();
        //yield ContractDetailsIsLoadedState(contract);
      } catch (_){

        print(_);
        yield ContractDetailsIsNotLoadedState();
      }
    }
  }
}