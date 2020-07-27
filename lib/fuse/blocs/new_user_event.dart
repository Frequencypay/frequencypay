import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

abstract class NewUserEvent {
  const NewUserEvent();
}

class NewUserCreated extends NewUserEvent {
  final Map baseUserInfo;
  final Map userProfile;

  const NewUserCreated({@required this.baseUserInfo, this.userProfile}) :
        assert( (baseUserInfo != null) && (userProfile != null));

  @override
  List<Object> get props => [baseUserInfo, baseUserInfo];
}
