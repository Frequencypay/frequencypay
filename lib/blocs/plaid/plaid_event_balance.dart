import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class PlaidEvent extends Equatable {
  const PlaidEvent();
}

class TokenRequested extends PlaidEvent {
  final String publicToken;

  const TokenRequested({@required this.publicToken}) : assert(publicToken != null);

  @override
  List<Object> get props => [publicToken];
}