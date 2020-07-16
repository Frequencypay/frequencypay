import 'package:bloc/bloc.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/services/firestore_db_service.dart';

//Events
class LoanRequestEvent {

}

class LoadLoanRequestEvent extends LoanRequestEvent {

}

class SetLenderLoanRequestEvent extends LoanRequestEvent {

  String lenderUID;

  SetLenderLoanRequestEvent(this.lenderUID);
}

//States
class LoanRequestState {

}

class LoanRequestIsLoadingState extends LoanRequestState {

}

class LoanRequestIsLoadedState extends LoanRequestState {

  final _localUser;
  final _lender;

  LoanRequestIsLoadedState(UserData this._localUser, UserData this._lender);

  UserData get getLocalUser => _localUser;
  UserData get getLender => _lender;
}

class LoanRequestIsNotLoadedState extends LoanRequestState {

}

class LoanRequestBloc extends Bloc<LoanRequestEvent, LoanRequestState> {

  FirestoreService _service;

  UserData currentUser;
  UserData lender;

  //Expense expense = null;

  LoanRequestBloc(FirestoreService this._service) {

    currentUser = null;
    lender = null;
  }

  @override
  LoanRequestState get initialState => LoanRequestIsLoadingState();

  @override
  Stream<LoanRequestState> mapEventToState(LoanRequestEvent event) async*{

    if (event is LoadLoanRequestEvent) {
      yield LoanRequestIsLoadingState();

      try {

        Stream<UserData> userStream = _service.userData;

        currentUser = await userStream.first;

        yield LoanRequestIsLoadedState(currentUser, lender);

      } catch (_){

        print(_);
        yield LoanRequestIsNotLoadedState();
      }
    } else if (event is SetLenderLoanRequestEvent) {

      String lenderUID = event.lenderUID;

      Stream<UserData> userStream = _service.retrieveUser(lenderUID);

      lender = await userStream.first;

      //Refresh the screen
      yield LoanRequestIsLoadedState(currentUser, lender);
    }
  }
}