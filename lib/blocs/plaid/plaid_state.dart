import 'package:frequencypay/models/plaid/models.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


abstract class PlaidState extends Equatable {
  const PlaidState();

  @override
  List<Object> get props => [];
}

class PlaidInitial extends PlaidState {}

class PlaidLoadInProgress extends PlaidState {}

class PlaidLoadSuccess extends PlaidState {
  final PlaidPublicTokenExchangeResponseModel plaidPublicTokenExchangeResponseModel;

  const PlaidLoadSuccess({@required this.plaidPublicTokenExchangeResponseModel}) : assert(plaidPublicTokenExchangeResponseModel != null);

  @override
  List<Object> get props => [plaidPublicTokenExchangeResponseModel];
}

class PlaidLoadFailure extends PlaidState {}