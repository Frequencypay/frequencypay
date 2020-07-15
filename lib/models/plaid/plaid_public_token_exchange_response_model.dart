import 'package:equatable/equatable.dart';

class PlaidPublicTokenExchangeResponseModel extends Equatable {
  final String accessToken;
  final String itemID;
  final String requestID;

  const PlaidPublicTokenExchangeResponseModel({this.accessToken, this.itemID, this.requestID});

  
  @override
  List<Object> get props => [
    accessToken,
    itemID,
    requestID,
  ];
  
  static PlaidPublicTokenExchangeResponseModel fromJson(Map<String, dynamic> json) {
    return PlaidPublicTokenExchangeResponseModel(
      accessToken: json['access_token'],
      itemID: json['item_id'],
      requestID: json['request_id'],
    );
  }
  
}