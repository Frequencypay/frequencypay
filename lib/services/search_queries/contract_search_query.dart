
/*Defines the arguments required to perform a contract search query
  as well as several presets to avoid dependencies in many
 */

enum REQUIREMENT_MODE {

  REQUESTER,
  LOANER
}

class ContractSearchQuery {

  bool isComplete;
  bool isActive;
  bool isPending;

  REQUIREMENT_MODE requirementMode;

  //Standard constructor
  ContractSearchQuery._(bool isComplete, bool isActive, bool isPending, REQUIREMENT_MODE requirementMode) {

    this.isComplete = isComplete;
    this.isActive = isActive;
    this.isPending = isPending;
    this.requirementMode = requirementMode;
  }

  //Preset constructors
  ContractSearchQuery.COMPLETE_CONTRACTS() : this._(true, false, false, REQUIREMENT_MODE.REQUESTER);

  ContractSearchQuery.ACTIVE_CONTRACTS() : this._(false, true, false, REQUIREMENT_MODE.REQUESTER);

  ContractSearchQuery.OUTBOUND_PENDING_CONTRACTS() : this._(false, false, true, REQUIREMENT_MODE.REQUESTER);

  ContractSearchQuery.INBOUND_PENDING_CONTRACTS() : this._(false, false, true, REQUIREMENT_MODE.LOANER);
}