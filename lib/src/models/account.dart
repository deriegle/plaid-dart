import 'package:meta/meta.dart';

class Balances {
  double available;
  double current;
  double limit;
  String iso_currency_code;
  String official_currency_code;

  Balances({
    this.available,
    this.current,
    this.limit,
    this.iso_currency_code,
    this.official_currency_code,
  });

  factory Balances.fromJson(Map<String, dynamic> json) {
    return Balances(
      available: json['available'],
      current: json['current'],
      iso_currency_code: json['iso_currency_code'],
      limit: json['limit'],
      official_currency_code: json['official_currency_code'],
    );
  }
}

class Account {
  String account_id;
  String mask;
  String name;
  String official_name;
  String subtype;
  String type;
  Balances balances;

  Account({
    @required this.account_id,
    this.mask,
    this.name,
    this.official_name,
    this.subtype,
    this.type,
    this.balances,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      account_id: json['account_id'],
      mask: json['mask'],
      name: json['name'],
      official_name: json['official_name'],
      subtype: json['subtype'],
      type: json['type'],
      balances: Balances.fromJson(json['balances']),
    );
  }
}
