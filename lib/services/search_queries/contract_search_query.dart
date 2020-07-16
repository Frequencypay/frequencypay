
/*Defines the arguments required to perform a contract search query
  as well as several presets to avoid dependencies in many
 */

import 'package:frequencypay/models/contract_model.dart';

enum REQUIREMENT_MODE {

  REQUESTER,
  LOANER
}

class ContractSearchQuery {

  CONTRACT_STATE state;

  REQUIREMENT_MODE requirementMode;

  //Standard constructor
  ContractSearchQuery._(CONTRACT_STATE state, REQUIREMENT_MODE requirementMode) {

    this.state = state;
    this.requirementMode = requirementMode;
  }

  //Preset constructors
  ContractSearchQuery.COMPLETE_CONTRACTS() : this._(CONTRACT_STATE.COMPLETED_CONTRACT, REQUIREMENT_MODE.REQUESTER);

  ContractSearchQuery.ACTIVE_CONTRACTS() : this._(CONTRACT_STATE.ACTIVE_CONTRACT, REQUIREMENT_MODE.REQUESTER);

  ContractSearchQuery.OUTBOUND_PENDING_CONTRACTS() : this._(CONTRACT_STATE.OPEN_REQUEST, REQUIREMENT_MODE.REQUESTER);

  ContractSearchQuery.INBOUND_PENDING_CONTRACTS() : this._(CONTRACT_STATE.OPEN_REQUEST, REQUIREMENT_MODE.LOANER);
}