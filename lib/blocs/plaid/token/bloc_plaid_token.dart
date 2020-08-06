import 'package:frequencypay/blocs/plaid/plaid_blocs.dart';
import 'package:frequencypay/models/plaid/models.dart';
import 'package:frequencypay/repositories/plaid/plaid_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

class BlocPlaidToken extends Bloc<PlaidEvent, PlaidState> {
  final PlaidRepository plaidRepository;

  BlocPlaidToken({@required this.plaidRepository}) : assert(plaidRepository != null);

  @override
  PlaidState get initialState => PlaidInitial();

  @override
  Stream<PlaidState> mapEventToState(PlaidEvent event) async* {
    if (event is TokenRequested) {
      yield PlaidLoadInProgress();
      try {
        final PlaidPublicTokenExchangeResponseModel
            plaidPublicTokenExchangeResponseModel =
            await plaidRepository.getAccessToken(event.publicToken);
        yield PlaidLoadSuccess(
            plaidPublicTokenExchangeResponseModel:
                plaidPublicTokenExchangeResponseModel);
      } catch (_) {
        yield PlaidLoadFailure();
      }
    }
  }
}
