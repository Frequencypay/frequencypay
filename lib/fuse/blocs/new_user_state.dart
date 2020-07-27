import 'package:meta/meta.dart';

import '../models/models.dart';

abstract class NewUserState {
  const NewUserState();

  @override
  List<Object> get props => [];
}

class NewUserInitial extends NewUserState {}

class NewUserLoadInProgress extends NewUserState {}

class NewUserLoadSuccess extends NewUserState {
  final UserProfile newUser;

  const NewUserLoadSuccess({@required this.newUser}) : assert(newUser != null);

  @override
  List<Object> get props => [newUser];
}

class NewUserLoadFailure extends NewUserState {}
