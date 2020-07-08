import 'package:frequencypay/models/plaid/models.dart';
import 'package:frequencypay/services/network_util.dart';
import 'dart:async';


class PlaidTokenRepo {
  NetworkUtil _networkUtil = NetworkUtil();

  Future<PlaidPublicTokenExchangeResponseModel> publicTokenExchangeRequest(String publicToken) async {
    Map body = {
      "public_token": publicToken,
    };
    final response = await _networkUtil.postPlaidLink("/item/public_token/exchange", body: body);
    return PlaidPublicTokenExchangeResponseModel.fromJson(response);
  }

}