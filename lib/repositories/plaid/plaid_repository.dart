//import 'dart:convert';
//import 'dart:io';
//import 'package:meta/meta.dart';
//import 'package:frequencypay/models/plaid/models.dart';
//import 'package:frequencypay/services/CustomException.dart';
//import 'package:frequencypay/services/network_util.dart';
//import 'dart:async';
//import 'package:http/http.dart' as http;
//
//class PlaidRepository {
//  NetworkUtil _networkUtil = NetworkUtil();
//
//  Future<PlaidPublicTokenExchangeResponseModel> signInWithCredentials(String publicToken) async {
//    Map body = {
//      "client_id": "5cb68305fede9b00136aebb1",
//      "secret": "54621c4436011f708c7916587c6fa8",
//      "public_token": publicToken,
//    };
//    final response = await _networkUtil
//        .postPlaidLink("/item/public_token/exchange", body: body);
//    return PlaidPublicTokenExchangeResponseModel.fromJson(response);
//  }
//
//  static const baseUrl = 'https://sandbox.plaid.com';
//
//  Map plaidKeys = {
//    "client_id": "5cb68305fede9b00136aebb1",
//    "secret": "54621c4436011f708c7916587c6fa8",
//  };
//
//  Future<PlaidBalanceResponseModel> postPlaidBalances(
//      String accessToken) async {
//    Map body = {};
//    final plaidBalancesUrl = '/accounts/balance/get';

////    FlutterSecureStorage _storage = FlutterSecureStorage();
////    var accessToken = await _storage.read(key: "accessToken");
//    plaidKeys["access_token"] = accessToken;
//    body.addAll(plaidKeys);
//    try {
//      final response = await http.post(
//        baseUrl + plaidBalancesUrl,
//        headers: {"Content-Type": "application/json"},
//        body: json.encode(body),
//      );
//      final balanceJson = jsonDecode(response.body);
//      return PlaidBalanceResponseModel.fromJson(balanceJson);
//    } on SocketException {
//      throw FetchDataException('No Internet connection');
//    }
//  }
//}

import 'package:frequencypay/models/plaid/models.dart';
import 'package:frequencypay/repositories/plaid/plaid_api_client.dart';
import 'dart:async';

import 'package:meta/meta.dart';

class PlaidRepository {
  final PlaidAPIClient plaidAPIClient;

  PlaidRepository({@required this.plaidAPIClient})
      : assert(plaidAPIClient != null);

  Future<PlaidPublicTokenExchangeResponseModel> getAccessToken(
      String publicToken) async {
    final PlaidPublicTokenExchangeResponseModel accessToken =
        await plaidAPIClient
            .exchangePlaidPublicTokenForAccessToken(publicToken);
    return accessToken;
  }
}
