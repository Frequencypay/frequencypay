import 'package:frequencypay/models/PlaidModel.dart';
import 'package:frequencypay/services/network_util.dart';
import 'dart:async';


class PlaidRepo {
  NetworkUtil _networkUtil = NetworkUtil();

  Future<PlaidModel> signInWithCredentials(String clientID, String secretKey, String publicToken) async {
    Map body = {
      "client_id": "5cb68305fede9b00136aebb1",
      "secret": "54621c4436011f708c7916587c6fa8",
      "public_token": publicToken,
    };
    final response = await _networkUtil.postPlaidLink("/item/public_token/exchange", body: body);
    return PlaidModel.fromJson(response);
  }

}