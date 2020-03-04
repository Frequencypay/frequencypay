import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:frequencypay/services/CustomException.dart';

class NetworkUtil {
  //Sandbox URL
  final String _baseUrl = "https://sandbox.plaid.com";

  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url);
      responseJson = _response(response);
    } on SocketException {
     // throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postPlaidLink(String url, {Map body} ) async{
    var responseJson;
    try{
      final response = await http.post(_baseUrl + url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),);
      responseJson = _response(response);
    } on SocketException{
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

}

