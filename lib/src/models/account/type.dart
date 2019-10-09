class AccountSubType {
  final String _value;

  const AccountSubType(this._value);

  String get value => _value;

  /// brokerage - 401a, 401k, 403b, 457b, 529, brokerage, cash isa, education savings account
  static const BROKERAGE = AccountSubType('brokerage');

  /// credit - credit card, paypal, rewards
  static const CREDIT = AccountSubType('credit');

  /// depository - cd, checking, savings, money market
  static const DEPOSITORY = AccountSubType('depository');

  /// loan - auto, commercial, construction, home
  static const LOAN = AccountSubType('loan');

  /// other - cash management, mutual fund, safe deposit
  static const OTHER = AccountSubType('other');

  factory AccountSubType.fromString(String str) {
    return AccountSubType(str);
  }
}

class AccountType {
  final String _value;

  const AccountType(this._value);

  String get value => _value;

  /// Account Type
  /// brokerage - Brokerage account
  static const BROKERAGE = AccountType('brokerage');

  /// credit - Credit card
  static const CREDIT = AccountType('credit');

  /// depository - Checking or savings accounts
  static const DEPOSITORY = AccountType('depository');

  /// loan - Loan account
  static const LOAN = AccountType('loan');

  /// other - Non-specified account type
  static const OTHER = AccountType('other');
  
  factory AccountType.fromString(String str) {
    return AccountType(str);
  }
}