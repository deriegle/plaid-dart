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
