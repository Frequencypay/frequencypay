class PlaidPublicTokenExchangeResponseModel {
  String access_token;
  String item_id;
  String request_id;

  PlaidPublicTokenExchangeResponseModel(
      {this.access_token, this.item_id, this.request_id});

  factory PlaidPublicTokenExchangeResponseModel.fromJson(
      Map<String, dynamic> json) {
    return PlaidPublicTokenExchangeResponseModel(
      access_token: json['access_token'],
      item_id: json['item_id'],
      request_id: json['request_id'],
    );
  }
}
