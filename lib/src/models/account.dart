import 'package:meta/meta.dart';

class AccountBalances {
  /// Total amount of funds in account
  double available;

  /// The amount of funds available for withdrawal from an account.
  double current;

  /// The limit for the account, primarily populated by 'credit' type accounts
  double limit;

  /// The ISO currency code for the account
  String iso_currency_code;

  String unofficial_currency_code;

  AccountBalances({
    this.available,
    this.current,
    this.limit,
    this.iso_currency_code,
    this.unofficial_currency_code,
  });

  factory AccountBalances.fromJson(Map<String, dynamic> json) {
    return AccountBalances(
      available: json['available'],
      current: json['current'],
      iso_currency_code: json['iso_currency_code'],
      limit: json['limit'],
      unofficial_currency_code: json['unofficial_currency_code'],
    );
  }
}

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

  /// Account Subtypes
  /// brokerage - 401a, 401k, 403b, 457b, 529, brokerage, cash isa, education savings account
  /// credit - credit card, paypal, rewards
  /// depository - cd, checking, savings, money market
  /// loan - auto, commercial, construction, home
  /// other - cash management, mutual fund, safe deposit
  String subtype;

  /// Account Type
  /// brokerage - Brokerage account
  /// credit - Credit card
  /// depository - Checking or savings accounts
  /// loan - Loan account
  /// other - Non-specified account type
  String type;
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
      subtype: json['subtype'],
      type: json['type'],
      balances: AccountBalances.fromJson(json['balances']),
    );
  }
}
