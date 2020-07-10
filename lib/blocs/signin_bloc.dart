import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frequencypay/PLACEHOLDERS/PlaceholderDataService.dart';
import 'package:frequencypay/PLACEHOLDERS/PlaceholderUserModel.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/services/firebase_auth_service.dart';
import 'package:frequencypay/services/firestore_db_service.dart';

//Events
class SigninEvent {

}

class LoadSigninEvent extends SigninEvent {

}

//States
class SigninState {

}

class SigninIsLoadingState extends SigninState {

}

class SigninIsLoadedState extends SigninState {

  final _profile;

  SigninIsLoadedState(UserData this._profile);

  UserData get getProfile => _profile;
}

class SigninIsNotLoadedState extends SigninState {

}

class SigninBloc extends Bloc<SigninEvent, SigninState> {

  FirestoreService _service;

  SigninBloc(FirestoreService this._service);

  @override
  SigninState get initialState => SigninIsLoadingState();

  @override
  Stream<SigninState> mapEventToState(SigninEvent event) async*{

    if (event is LoadSigninEvent) {
      yield SigninIsLoadingState();

      try {

        Stream<UserData> userStream = _service.userData;

        UserData currentUser = await userStream.first;

        yield SigninIsLoadedState(currentUser);
      } catch (_){

        print(_);
        yield SigninIsNotLoadedState();
      }
    }
  }
}