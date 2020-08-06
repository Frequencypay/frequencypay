import 'package:frequencypay/blocs/plaid/plaid_event_balance.dart';
import 'package:frequencypay/blocs/plaid/plaid_state_balance.dart';
import 'package:frequencypay/models/plaid/models.dart';
import 'package:frequencypay/repositories/plaid/plaid_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

class BlocPlaidBalance extends Bloc<PlaidEventBalance, PlaidStateBalance> {
  final PlaidRepository plaidRepository;

  BlocPlaidBalance({@required this.plaidRepository}) : assert(plaidRepository != null), super(PlaidBalanceInitial());


  @override
  Stream<PlaidStateBalance> mapEventToState(PlaidEventBalance event) async* {
    if (event is BalanceRequested) {
      yield PlaidBalanceLoadInProgress();
      try {
        final PlaidBalanceResponseModel
            plaidBalanceResponseModel =
            await plaidRepository.getBalance();
        yield PlaidBalanceLoadSuccess(
            plaidBalanceResponseModel:
                plaidBalanceResponseModel);
      } catch (_) {
        yield PlaidBalanceLoadFailure();
      }
    }
  }
}
