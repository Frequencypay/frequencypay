
import 'package:frequencypay/models/contract_model.dart';

/* This class represents the arguments required to transition to the contract
*  details screen using Flutter routes.
*/
class ContractDetailsArguments {

  //The contract to be displayed on the screen
  Contract contract;

  ContractDetailsArguments(this.contract);
}