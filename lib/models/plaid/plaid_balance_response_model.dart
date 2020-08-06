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
  String request_id;

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
  String account_id;
  Balances balances;
  String mask;
  String name;
  String official_name;
  String subtype;
  String type;

  Account(
      {this.account_id,
      this.balances,
      this.mask,
      this.name,
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
  String iso_currency_code;
  Object limit;
  String unofficial_currency_code;

  Balances(
      {this.available,
      this.current,
      this.iso_currency_code,
      this.limit,
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
  List<String> available_products;
  List<String> billed_products;
  Object consent_expiration_time;
  Object error;
  String institution_id;
  String item_id;
  String webhook;

  Item(
      {this.available_products,
      this.billed_products,
      this.consent_expiration_time,
      this.error,
      this.institution_id,
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
