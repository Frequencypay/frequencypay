import 'package:frequencypay/models/plaid/models.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


abstract class PlaidStateBalance extends Equatable {
  const PlaidStateBalance();

  @override
  List<Object> get props => [];
}

class PlaidBalanceInitial extends PlaidStateBalance {
  PlaidBalanceInitial();
}

class PlaidBalanceLoadInProgress extends PlaidStateBalance {}

class PlaidBalanceLoadSuccess extends PlaidStateBalance {
  final PlaidBalanceResponseModel plaidBalanceResponseModel;

  const PlaidBalanceLoadSuccess({@required this.plaidBalanceResponseModel}) : assert(plaidBalanceResponseModel != null);

  @override
  List<Object> get props => [plaidBalanceResponseModel];
}

class PlaidBalanceLoadFailure extends PlaidStateBalance {}