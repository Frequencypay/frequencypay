import 'package:bloc/bloc.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/services/contract_service.dart';
import 'package:frequencypay/services/firestore_db_service.dart';

//Events
class LandingEvent {

}

class LoadLandingEvent extends LandingEvent {

}

//States
class LandingState {

}

class LandingIsLoadingState extends LandingState {

}

class LandingIsLoadedState extends LandingState {

  final _profile;
  final _repaymentOverview;

  LandingIsLoadedState(this._profile, this._repaymentOverview);

  UserData get getProfile => _profile;
  RepaymentOverview get getRepaymentOverview => _repaymentOverview;
}

class LandingIsNotLoadedState extends LandingState {

}

class LandingBloc extends Bloc<LandingEvent, LandingState> {

  FirestoreService _service;
  ContractService _contractService;

  LandingBloc(this._service, this._contractService);

  @override
  LandingState get initialState => LandingIsLoadingState();

  @override
  Stream<LandingState> mapEventToState(LandingEvent event) async*{

    if (event is LoadLandingEvent) {
      yield LandingIsLoadingState();

      try {

        Stream<UserData> userStream = _service.userData;

        UserData currentUser = await userStream.first;

        RepaymentOverview overview = await _contractService.getRepaymentOverview();

        yield LandingIsLoadedState(currentUser, overview);
      } catch (_){

        print(_);
        yield LandingIsNotLoadedState();
      }
    }
  }
}