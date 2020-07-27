import 'package:frequencypay/fuse/models/user_profile.dart';

import '../models/models.dart';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class FuseApiClient {
  static const baseUrl = 'https://fuseapi.billgo-dev.com:443/v1.0';
  static final token = 'eyJhZ2VudElkIjoiIiwiaWQiOiI0MDhlZTgwMjg2Nzk0MjcwYTVhYTk4MTlhYWU0MDMyOSIsImtleSI6IjZHVVh0KzlpM09TNTJmSGRVYW9pbU9HN3hNY1h1K1ZLREVxUTIyRmhiaTZQZjd6b0I0T0JrRml5UHdJV0NYMU1hdUptbTBKaVpjWjdjQnZxVkJtTmpBPT0iLCJ2ZXJzaW9uIjoiMi45LjIwNTQuNTA3In0'; //TODO SO WRONG
  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $token",
  };

  final http.Client httpClient;

  FuseApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<NewUser> createNewUser(Map body ) async {

    final newUserUrl = '$baseUrl/users/create';
    final newUserResponse = await this.httpClient.post(newUserUrl, headers: headers , body: json.encode(body),);
    print(newUserResponse);
    if (newUserResponse.statusCode != 200) {
      throw Exception('error creating new user');
    }

    final newUserJson = jsonDecode(newUserResponse.body);
    return NewUser.fromJson(newUserJson);
  }

  Future<UserProfile> createNewUserProfile( String userId, Map body, ) async {

    final profileUrl = '$baseUrl/users/$userId/profiles/create';
    final profileResponse = await this.httpClient.post(profileUrl, headers: headers, body: json.encode(body),);

    if (profileResponse.statusCode != 200) {
      throw Exception('error updating user profile');
    }

    final profileJson = jsonDecode(profileResponse.body);
    return UserProfile.fromJson(profileJson);
  }


}

