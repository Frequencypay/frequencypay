import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import '../repositories/repositories.dart';
import '../models/models.dart';
import 'blocs.dart';

class NewUserBloc extends Bloc<NewUserEvent, NewUserState> {
  final NewUserRepository newUserRepository;

  NewUserBloc({@required this.newUserRepository})
      : assert(newUserRepository != null);

  @override
  NewUserState get initialState => NewUserInitial();

  @override
  Stream<NewUserState> mapEventToState(NewUserEvent event) async* {
    if (event is NewUserCreated) {
      yield NewUserLoadInProgress();
      try {
        final UserProfile newUser = await newUserRepository.createNewUser(event.baseUserInfo, event.userProfile);
        yield NewUserLoadSuccess(newUser: newUser);
      } catch (_) {
        yield NewUserLoadFailure();
      }
    }
  }
}
