import 'package:bloc/bloc.dart';
import 'package:frequencypay/PLACEHOLDERS/PlaceholderDataService.dart';
import 'package:frequencypay/PLACEHOLDERS/PlaceholderUserModel.dart';

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

  ProfileIsLoadedState(PlaceholderUserModel this._profile);

  PlaceholderUserModel get getProfile => _profile;
}

class ProfileIsNotLoadedState extends ProfileState {

}

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  PlaceholderDataService service;

  ProfileBloc(PlaceholderDataService service);

  @override
  ProfileState get initialState => ProfileIsLoadingState();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async*{

    if (event is LoadProfileEvent) {
      yield ProfileIsLoadingState();

      try {

        PlaceholderUserModel user = await service.getLocalUserModel();
        yield ProfileIsLoadedState(user);
      } catch (_){

        print(_);
        yield ProfileIsNotLoadedState();
      }
    }
  }
}