import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frequencypay/blocs/plaid/bloc.dart';
import 'package:frequencypay/blocs/plaid/plaid_blocs.dart';
import 'package:frequencypay/pages/home_page.dart';
import 'package:frequencypay/plaid_link/plaid_link_webview.dart';

class PlaidLinkSplashScreen extends StatefulWidget {
  @override
  _PlaidLinkSplashScreenState createState() => _PlaidLinkSplashScreenState();
}

class _PlaidLinkSplashScreenState extends State<PlaidLinkSplashScreen> {
  PlaidLink plaidLink = PlaidLink();
  static const Color blueHighlight = const Color(0xFF3665FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: RichText(
          text: new TextSpan(
            // Note: Styles for TextSpans must be explicitly defined.
            // Child text spans will inherit styles from parent
            style: new TextStyle(
              fontSize: 25.0,
              color: Colors.black45,
            ),
            children: <TextSpan>[
              new TextSpan(text: 'Welcome To '),
              new TextSpan(
                  text: 'FrequencyPay!',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, color: blueHighlight)),
            ],
          ),
        ),
      ),
      body: Center(
        child: BlocBuilder<PlaidBloc, PlaidState>(
          builder: (context, state) {
            if (state is PlaidInitial) {
              return Column(
                children: <Widget>[
                 
                      Image.asset('assets/frequency.png', fit: BoxFit.scaleDown,),

                  Container(
                      padding: EdgeInsets.all(15),
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            text:
                                'We use Plaid to help track your expenses and and '
                                'get you in tune with your finances. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi eget posuere dolor. Mauris imperdiet ac arcu sed accumsan. Nam congue sapien a feugiat facilisis. '),
                      )),
                  Expanded(
                    child:  Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          RaisedButton(
                            color: Colors.blue,
                            child: Text("Launch Plaid"),
                            textColor: Colors.white,
                            onPressed: () => plaidLink.launch(context, (result) {
                              if (result.token != null) {
                                BlocProvider.of<PlaidBloc>(context)
                                    .add(TokenRequested(publicToken: result.token));
                              }
                            }),
                          ),
                          RaisedButton(
                            child: Text("No Thanks"),
                            textColor: Colors.white,
                            onPressed: () =>
                                Navigator.of(context).pushReplacementNamed('/home'),
                          ),
//                          Padding(padding: EdgeInsets.fromLTRB(0,0,0,500))
                        ],
                      ),
                    )
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 40),)
                ],
              );
            }
            if (state is PlaidLoadInProgress) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is PlaidLoadSuccess) {
              final token = state.plaidPublicTokenExchangeResponseModel;
              FlutterSecureStorage _storage = FlutterSecureStorage();
              _storage.write(key: 'access_token', value: token.accessToken);

              Navigator.of(context).pushReplacementNamed('/home');
            }
            if (state is PlaidLoadFailure) {
              return Text(
                'Failure: Plaid did not return token',
                style: TextStyle(color: Colors.red),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget LoadHome(){
    return HomePage();
  }
}
