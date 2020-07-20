import 'package:bloc/bloc.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/services/firestore_db_service.dart';

//Events
class ProfileEvent {

}

class LoadProfileEvent extends ProfileEvent {

}

//States
class ProfileState {

}

class ProfileIsLoadingState extends ProfileState {

}

class ProfileIsLoadedState extends ProfileState {

  final _profile;

  ProfileIsLoadedState(UserData this._profile);

  UserData get getProfile => _profile;
}

class ProfileIsNotLoadedState extends ProfileState {

}

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  FirestoreService _service;

  ProfileBloc(FirestoreService this._service);

  @override
  ProfileState get initialState => ProfileIsLoadingState();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async*{

    if (event is LoadProfileEvent) {
      yield ProfileIsLoadingState();

      try {

        Stream<UserData> userStream = _service.userData;

        UserData currentUser = await userStream.first;

        yield ProfileIsLoadedState(currentUser);
      } catch (_){

        print(_);
        yield ProfileIsNotLoadedState();
      }
    }
  }
}