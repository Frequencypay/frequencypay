import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

//class PlaidLinkScreen extends StatefulWidget{
//  @override
//  State<PlaidLinkScreen> createState() => _PlaidLinkScreenState();
//}
//
//class _PlaidLinkScreenState extends State<PlaidLinkScreen>{
//  final TextEditingController _linkToken = TextEditingController();
//
//
//
//  @override
//  Widget build(BuildContext context) {
//    PlaidLink _plaidLink = PlaidLink();
//    return _plaidLink.launch(context, (result)  {
//      result.token;
//      _linkToken.text = result.token;
//
////        Navigator.pop(context, _linkToken.text);
//    },);
//  }
//}


class PlaidLink {
  Configuration _configuration;

  PlaidLink() {
    bool plaidSandbox = true;
    String clientID = "5cb68305fede9b00136aebb1";
    String secret = "54621c4436011f708c7916587c6fa8";

    Configuration configuration = Configuration(
        plaidPublicKey: '5e8f6927464aa029be1a265eb95b79',
        plaidBaseUrl: 'https://cdn.plaid.com/link/v2/stable/link.html',
        plaidEnvironment: plaidSandbox ? 'sandbox' : 'production',
        environmentPlaidPathAccessToken:
        'https://sandbox.plaid.com/item/public_token/exchange',
        plaidClientId: clientID,
        secret: plaidSandbox ? secret : '',
        clientName: 'ClientName',
        webhook: 'http://requestb.in',
        product: 'auth',
        selectAccount: 'true'
    );
    this._configuration = configuration;
  }

  launch(BuildContext context, success(Result result),) {
    _WebViewPage _webViewPage = new _WebViewPage();
    _webViewPage._init(this._configuration, success, context);

    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return _webViewPage.build(context);
    }));
  }
}

class _WebViewPage {
  String _url;
  Function(Result) _success;
  Configuration _config;
  BuildContext _context;

  _init(Configuration config, success(Result result),
      BuildContext context) {
    this._success = success;
    this._config = config;
    this._context = context;
    _url = config.plaidBaseUrl +
        '?key=' +
        config.plaidPublicKey +
        '&isWebview=true' +
        '&product=auth' +
        '&isMobile=true' +
        '&apiVersion=v2' +
        '&selectAccount=true' +
        '&webhook=https://requestb.in' +
        '&env=' +
        config.plaidEnvironment;
    debugPrint('init plaid: ' + _url);
  }

  _parseUrl(String url) {
    if (url?.isNotEmpty != null) {
      Uri uri = Uri.parse(url);
      debugPrint('PLAID uri: ' + uri.toString());
      Map<String, String> queryParams = uri.queryParameters;
      List<String> segments = uri.pathSegments;
      debugPrint('queryParams: ' + queryParams?.toString());
      debugPrint('segments: ' + segments?.toString());
      _processParams(queryParams, url);
    }
  }

  _processParams(Map<String, String> queryParams, String url) async {
    if (queryParams != null) {
      String eventName = queryParams['event_name'] ?? 'unknown';
      debugPrint("PLAID Event name: " + eventName);

      if (eventName == 'EXIT' || (url?.contains('/exit?') ?? false)) {
        this._closeWebView();
      }
      else if (eventName == 'HANDOFF' || eventName == "unknown") {
        this._closeWebView();
      }
      dynamic token = queryParams['public_token'];
      dynamic accountId = queryParams['account_id'];
      if (token != null && accountId != null) {
          this._success(Result(token, accountId, queryParams));

      }
    }
  }


  _closeWebView() {
    if (_context != null && Navigator.canPop(_context)) {
      Navigator.pop(_context);
    }
  }

  Widget build(BuildContext context) {
    var webView = new WebView(
      initialUrl: _url,
      javascriptMode: JavascriptMode.unrestricted,
      navigationDelegate: (NavigationRequest navigation) {
        if (navigation.url.contains('plaidlink://')) {
          this._parseUrl(navigation.url);
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    );

    return Scaffold(body: webView);
  }
}

class Configuration {
  String plaidPublicKey;
  String plaidBaseUrl;
  String plaidEnvironment;
  String environmentPlaidPathAccessToken;
  String plaidClientId;
  String secret;
  String clientName;
  String webhook;
  String product;
  String selectAccount;

  Configuration(
      {@required this.plaidPublicKey,
        @required this.plaidBaseUrl,
        @required this.plaidEnvironment,
        @required this.environmentPlaidPathAccessToken,
        @required this.plaidClientId,
        @required this.secret,
        @required this.clientName,
        @required this.webhook,
        @required this.product,
        @required this.selectAccount,});
}

class Result {
  String token;
  String accountId;
  dynamic response;

  Result(this.token, this.accountId, this.response);
}
