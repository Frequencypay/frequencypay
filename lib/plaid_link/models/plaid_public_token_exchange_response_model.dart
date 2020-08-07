class PlaidPublicTokenExchangeResponseModel {
  // ignore: non_constant_identifier_names
  String access_token;
  // ignore: non_constant_identifier_names
  String item_id;
  // ignore: non_constant_identifier_names
  String request_id;

  PlaidPublicTokenExchangeResponseModel(
      // ignore: non_constant_identifier_names
      {this.access_token,
      this.item_id,
      this.request_id});

  factory PlaidPublicTokenExchangeResponseModel.fromJson(
      Map<String, dynamic> json) {
    return PlaidPublicTokenExchangeResponseModel(
      access_token: json['access_token'],
      item_id: json['item_id'],
      request_id: json['request_id'],
    );
  }
}
