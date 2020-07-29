import 'package:bloc/bloc.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/services/firestore_db_service.dart';

//Events
class WakeUpEvent {

}

class LoadProfileEvent extends WakeUpEvent {

}

//States
class WakeUpState {

}

class WakeUpIsLoadingState extends WakeUpState {

}

class WakeUpIsLoadedState extends WakeUpState {

  final _profile;

  WakeUpIsLoadedState(UserData this._profile);

  UserData get getProfile => _profile;
}

class WakeUpIsNotLoadedState extends WakeUpState {

}

class WakeUpBloc extends Bloc<WakeUpEvent, WakeUpState> {

  FirestoreService _service;

  WakeUpBloc(FirestoreService this._service);

  @override
  WakeUpState get initialState => WakeUpIsLoadingState();

  @override
  Stream<WakeUpState> mapEventToState(WakeUpEvent event) async*{

    if (event is LoadProfileEvent) {
      yield WakeUpIsLoadingState();

      try {

        Stream<UserData> userStream = _service.userData;

        UserData currentUser = await userStream.first;

        yield WakeUpIsLoadedState(currentUser);
      } catch (_){

        print(_);
        yield WakeUpIsNotLoadedState();
      }
    }
  }
}