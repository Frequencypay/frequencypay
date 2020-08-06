import 'package:bloc/bloc.dart';
import 'package:frequencypay/models/contract_model.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/services/firestore_db_service.dart';

//Events
class LoanRequestEvent {}

class LoadLoanRequestEvent extends LoanRequestEvent {}

class SetLenderLoanRequestEvent extends LoanRequestEvent {
  String lenderUID;

  SetLenderLoanRequestEvent(this.lenderUID);
}

class SubmitLoanRequestEvent extends LoanRequestEvent {
  final UserData borrower;
  final UserData lender;
  final DateTime dueDate;
  final RepaymentTerms terms;
  final callback;

  SubmitLoanRequestEvent(
      this.borrower, this.lender, this.dueDate, this.terms, this.callback);
}

//States
class LoanRequestState {}

class LoanRequestIsLoadingState extends LoanRequestState {}

class LoanRequestIsLoadedState extends LoanRequestState {
  final _localUser;
  final _lender;

  LoanRequestIsLoadedState(this._localUser, this._lender);

  UserData get getLocalUser => _localUser;
  UserData get getLender => _lender;
}

class LoanRequestIsNotLoadedState extends LoanRequestState {}

class LoanRequestBloc extends Bloc<LoanRequestEvent, LoanRequestState> {
  FirestoreService _service;

  UserData currentUser;
  UserData lender;

  int amount;

  LoanRequestBloc(this._service) : super(null) {
    currentUser = null;
    lender = null;
  }

  LoanRequestState get initialState => LoanRequestIsLoadingState();

  @override
  Stream<LoanRequestState> mapEventToState(LoanRequestEvent event) async* {
    if (event is LoadLoanRequestEvent) {
      yield LoanRequestIsLoadingState();

      try {
        Stream<UserData> userStream = _service.userData;

        currentUser = await userStream.first;

        yield LoanRequestIsLoadedState(currentUser, lender);
      } catch (_) {
        print(_);
        yield LoanRequestIsNotLoadedState();
      }
    } else if (event is SetLenderLoanRequestEvent) {
      String lenderUID = event.lenderUID;

      Stream<UserData> userStream = _service.retrieveUser(lenderUID);

      lender = await userStream.first;

      //Refresh the screen
      yield LoanRequestIsLoadedState(currentUser, lender);
    } else if (event is SubmitLoanRequestEvent) {
      bool termsValid = validateTerms(event.terms);

      if (termsValid) {
        await FirestoreService().createContractRequest(
            currentUser.uid,
            lender.uid,
            currentUser.fname,
            lender.fname,
            event.dueDate.toIso8601String(),
            event.terms);

        //Message the screen
        event.callback();
      }

      //Refresh the screen
      yield LoanRequestIsLoadedState(currentUser, lender);
    }
  }

  //Validates terms according to the business logic requirements
  bool validateTerms(RepaymentTerms terms) {
    bool valid = true;

    if (terms.amount <= 0 ||
        terms.repaymentAmount <= 0 ||
        terms.frequencyWeeks <= 0) {
      valid = false;
    }

    if (terms.repaymentAmount > terms.amount) {
      valid = false;
    }

    return valid;
  }
}
