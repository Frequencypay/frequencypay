import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frequencypay/PLACEHOLDERS/PlaceholderDataService.dart';
import 'package:frequencypay/PLACEHOLDERS/PlaceholderUserModel.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/services/firebase_auth_service.dart';
import 'package:frequencypay/services/firestore_db_service.dart';

//Events
class WakeupEvent {

}

class LoadProfileEvent extends WakeupEvent {

}

//States
class WakeupState {

}

class WakeupIsLoadingState extends WakeupState {

}

class WakeupIsLoadedState extends WakeupState {

  final _wakeupauth;
  WakeupIsLoadedState(UserData this._wakeupauth);
  UserData get getProfile => _wakeupauth;
}

class WakeupIsNotLoadedState extends WakeupState {

}

class WakeupBloc extends Bloc<WakeupEvent, WakeupState> {

  FirestoreService _service;
  WakeupBloc(FirestoreService this._service);

  @override
  WakeupState get initialState => WakeupIsLoadingState();

  @override
  Stream<WakeupState> mapEventToState(WakeupEvent event) async*{

    if (event is LoadProfileEvent) {
      yield WakeupIsLoadingState();

      try {

        Stream<UserData> userStream = _service.userData;

        UserData currentUser = await userStream.first;

        yield WakeupIsLoadedState(currentUser);
      } catch (_){

        print(_);
        yield WakeupIsNotLoadedState();
      }
    }
  }
}