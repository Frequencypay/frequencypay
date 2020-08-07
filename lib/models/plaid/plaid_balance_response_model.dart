class PlaidBalanceModelList {
  final List<PlaidBalanceResponseModel> accounts;

  PlaidBalanceModelList({
    this.accounts,
  });

  factory PlaidBalanceModelList.fromJson(List<dynamic> parsedJson) {
    List<PlaidBalanceResponseModel> account =
        new List<PlaidBalanceResponseModel>();
    account =
        parsedJson.map((i) => PlaidBalanceResponseModel.fromJson(i)).toList();

    return new PlaidBalanceModelList(accounts: account);
  }
}

class PlaidBalanceResponseModel {
  List<Account> accounts;
  Item item;
  // ignore: non_constant_identifier_names
  String request_id;

  // ignore: non_constant_identifier_names
  PlaidBalanceResponseModel({this.accounts, this.item, this.request_id});

  factory PlaidBalanceResponseModel.fromJson(Map<String, dynamic> json) {
    return PlaidBalanceResponseModel(
      accounts: json['accounts'] != null
          ? (json['accounts'] as List).map((i) => Account.fromJson(i)).toList()
          : null,
      item: json['item'] != null ? Item.fromJson(json['item']) : null,
      request_id: json['request_id'],
    );
  }
}

class Account {
  // ignore: non_constant_identifier_names
  String account_id;
  Balances balances;
  String mask;
  String name;
  // ignore: non_constant_identifier_names
  String official_name;
  String subtype;
  String type;

  Account(
      // ignore: non_constant_identifier_names
      {this.account_id,
      this.balances,
      this.mask,
      this.name,
      // ignore: non_constant_identifier_names
      this.official_name,
      this.subtype,
      this.type});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      account_id: json['account_id'],
      balances:
          json['balances'] != null ? Balances.fromJson(json['balances']) : null,
      mask: json['mask'],
      name: json['name'],
      official_name: json['official_name'],
      subtype: json['subtype'],
      type: json['type'],
    );
  }
}

class Balances {
  double available;
  double current;
  // ignore: non_constant_identifier_names
  String iso_currency_code;
  Object limit;
  // ignore: non_constant_identifier_names
  String unofficial_currency_code;

  Balances(
      {this.available,
      this.current,
      // ignore: non_constant_identifier_names
      this.iso_currency_code,
      this.limit,
      // ignore: non_constant_identifier_names
      this.unofficial_currency_code});

  factory Balances.fromJson(Map<String, dynamic> json) {
    return Balances(
      available: json['available'] == null ? 0 : json['available'].toDouble(),
      current: json['current'].toDouble(),
      iso_currency_code: json['iso_currency_code'],
      limit: json['limit'],
      unofficial_currency_code: json['unofficial_currency_code'],
    );
  }
}

class Item {
  // ignore: non_constant_identifier_names
  List<String> available_products;
  // ignore: non_constant_identifier_names
  List<String> billed_products;
  // ignore: non_constant_identifier_names
  Object consent_expiration_time;
  Object error;
  // ignore: non_constant_identifier_names
  String institution_id;
  // ignore: non_constant_identifier_names
  String item_id;
  String webhook;

  Item(
      // ignore: non_constant_identifier_names
      {this.available_products,
      // ignore: non_constant_identifier_names
      this.billed_products,
      // ignore: non_constant_identifier_names
      this.consent_expiration_time,
      this.error,
      // ignore: non_constant_identifier_names
      this.institution_id,
      // ignore: non_constant_identifier_names
      this.item_id,
      this.webhook});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      available_products: json['available_products'] != null
          ? new List<String>.from(json['available_products'])
          : null,
      billed_products: json['billed_products'] != null
          ? new List<String>.from(json['billed_products'])
          : null,
      consent_expiration_time: json['consent_expiration_time'],
      error: json['error'],
      institution_id: json['institution_id'],
      item_id: json['item_id'],
      webhook: json['webhook'],
    );
  }
}
