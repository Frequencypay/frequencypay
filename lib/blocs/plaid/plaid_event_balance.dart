import 'package:equatable/equatable.dart';

abstract class PlaidEventBalance extends Equatable {
  const PlaidEventBalance();
}

class BalanceRequested extends PlaidEventBalance {
//  final String accessToken;

  const BalanceRequested();

  @override
  List<Object> get props => [];
}
