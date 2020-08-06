import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

  Future<PlaidBalanceResponseModel> getBalance() async {
    String accessToken;
    FlutterSecureStorage _storage = FlutterSecureStorage();
    accessToken = await _storage.read(key: 'access_token');
    final PlaidBalanceResponseModel plaidBalanceResponseModel =
        await plaidAPIClient.getPlaidBalance(accessToken);

    return plaidBalanceResponseModel;
  }
}
