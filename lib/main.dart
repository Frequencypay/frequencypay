import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:frequencypay/blocs/plaid/bloc.dart';
import 'package:frequencypay/blocs/plaid/simple_bloc_delegate.dart';
import 'package:frequencypay/repositories/plaid/plaid_api_client.dart';
import 'package:frequencypay/repositories/plaid/plaid_repository.dart';

import 'package:frequencypay/fuse/blocs/blocs.dart';
import 'package:frequencypay/fuse/repositories/fuse_client.dart';
import 'package:frequencypay/fuse/repositories/new_user_repository.dart';
import 'package:frequencypay/pages/authenticate/wrapper.dart';

import 'package:frequencypay/routes.dart';
import 'package:frequencypay/services/firebase_auth_service.dart';
import 'package:provider/provider.dart';

import 'package:frequencypay/models/user_model.dart';
import 'package:http/http.dart' as http;

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final PlaidRepository plaidRepository = PlaidRepository(
    plaidAPIClient: PlaidAPIClient(
      httpClient: http.Client(),
    ),
  );

  final NewUserRepository newUserRepository = NewUserRepository(
    fuseApiClient: FuseApiClient(
      httpClient: http.Client(),
    ),
  );
  runApp(MyApp(plaidRepository: plaidRepository, newUserRepository: newUserRepository,));
}

class MyApp extends StatelessWidget {
  final PlaidRepository plaidRepository;
  final NewUserRepository newUserRepository;

  MyApp({Key key, @required this.plaidRepository, @required this.newUserRepository})
      : assert((plaidRepository != null)&&(newUserRepository != null)),
        super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      // New -> Provider Package
      value: AuthService()
          .user, // New -> listens to stream for authentication changes
      child: MaterialApp(

        title: 'FrequencyPay',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<PlaidBloc>(
              create: (BuildContext context) =>
                  PlaidBloc(plaidRepository: plaidRepository),
            ),
            BlocProvider<NewUserBloc>(
              create: (BuildContext context) =>
                  NewUserBloc(newUserRepository: newUserRepository),
            ),

          ],
          child: Wrapper(),
        ),
        routes: routes,

//          routes: routes,

      ),
    );
  }
}
