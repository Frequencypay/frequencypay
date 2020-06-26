import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frequencypay/PLACEHOLDERS/PlaceholderDataService.dart';
import 'package:frequencypay/PLACEHOLDERS/PlaceholderUserModel.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/services/firebase_auth_service.dart';

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

  ProfileIsLoadedState(User this._profile);

  User get getProfile => _profile;
}

class ProfileIsNotLoadedState extends ProfileState {

}

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  AuthService service;

  ProfileBloc(AuthService service);

  @override
  ProfileState get initialState => ProfileIsLoadingState();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async*{

    if (event is LoadProfileEvent) {
      yield ProfileIsLoadingState();

      try {

        //TODO: May need to change into a "UserModel" instead
        FirebaseUser currentFirebaseUser = await service.getCurrentUser();
        User currentUser = await service.userFromFirebaseUser(currentFirebaseUser);

        yield ProfileIsLoadedState(currentUser);
      } catch (_){

        print(_);
        yield ProfileIsNotLoadedState();
      }
    }
  }
}