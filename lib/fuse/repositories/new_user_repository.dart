import 'dart:async';

import 'package:frequencypay/fuse/models/user_profile.dart';
import 'package:meta/meta.dart';

import 'fuse_client.dart';
import '../models/models.dart';

class NewUserRepository {
  final FuseApiClient fuseApiClient;

  NewUserRepository({@required this.fuseApiClient})
      : assert(fuseApiClient != null);

  Future<UserProfile> createNewUser(Map baseUserInfo, Map userProfile) async {

    final NewUser newUser = await fuseApiClient.createNewUser(baseUserInfo );

    String userId = newUser.usersAdded[0].id;

    return fuseApiClient.createNewUserProfile(userId, userProfile );
  }
}
