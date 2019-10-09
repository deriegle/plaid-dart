import 'package:meta/meta.dart';
import 'package:plaid_dart/src/models/account/balances.dart';
import 'package:plaid_dart/src/models/account/type.dart';

/// Plaid Account
/// [Plaid Docs Link](plaid.com/docs/#accounts)
class Account {
  /// The unique ID of the Account (may change)
  String account_id;

  /// The last four digits of the Account number
  String mask;

  /// The name of the account. (Assigned by user or Financial Institute)
  String name;

  /// The official name given by the Financial Institute.
  String official_name;

  AccountSubType subtype;
  AccountType type;
  AccountBalances balances;

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
      subtype: AccountSubType.fromString(json['subtype']),
      type: AccountType.fromString(json['type']),
      balances: AccountBalances.fromJson(json['balances']),
    );
  }
}
