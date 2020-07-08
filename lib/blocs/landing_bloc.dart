import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frequencypay/PLACEHOLDERS/PlaceholderDataService.dart';
import 'package:frequencypay/PLACEHOLDERS/PlaceholderUserModel.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/services/firebase_auth_service.dart';
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

  LandingIsLoadedState(UserData this._profile);

  UserData get getProfile => _profile;
}

class LandingIsNotLoadedState extends LandingState {

}

class LandingBloc extends Bloc<LandingEvent, LandingState> {

  FirestoreService _service;

  LandingBloc(FirestoreService this._service);

  @override
  LandingState get initialState => LandingIsLoadingState();

  @override
  Stream<LandingState> mapEventToState(LandingEvent event) async*{

    if (event is LoadLandingEvent) {
      yield LandingIsLoadingState();

      try {

        Stream<UserData> userStream = _service.userData;

        UserData currentUser = await userStream.first;

        yield LandingIsLoadedState(currentUser);
      } catch (_){

        print(_);
        yield LandingIsNotLoadedState();
      }
    }
  }
}