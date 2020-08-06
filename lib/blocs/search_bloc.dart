import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frequencypay/models/user_model.dart';
import 'package:frequencypay/services/firebase_auth_service.dart';
import 'package:frequencypay/services/firestore_db_service.dart';

//Events
class SearchEvent {

}

class LoadSearchEvent extends SearchEvent {

}

//States
class SearchState {

}

class SearchIsLoadingState extends SearchState {

}

class SearchIsLoadedState extends SearchState {
  final _search;
  SearchIsLoadedState(UserData this._search);
  UserData get getSearch => _search;
}

class SearchIsNotLoadedState extends SearchState {

}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  FirestoreService _service;
  SearchBloc(FirestoreService this._service) : super(SearchIsLoadingState());


  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async*{

    if (event is LoadSearchEvent) {
      yield SearchIsLoadingState();

      try {
        Stream<UserData> userStream = _service.userData;
        UserData currentUser = await userStream.first;

        yield SearchIsLoadedState(currentUser);
      } catch (_){

        print(_);
        yield SearchIsNotLoadedState();
      }
    }
  }
}