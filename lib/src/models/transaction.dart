class TransactionLocation {
  String address;
  String city;
  String region;
  String postalCode;
  String country;
  double lat;
  double lon;
}

class TransactionType {
  final String _value;

  const TransactionType(this._value);

  String get value => this._value;

  // digital: transactions that took place online.
  static const DIGITAL = TransactionType('digital');

  // place: transactions that were made at a physical location.
  static const PLACE = TransactionType('place');

  // special: transactions that relate to banks, e.g. fees or deposits.
  static const SPECIAL = TransactionType('special');

  // unresolved: transactions that do not fit into the other three types.
  static const UNRESOLVED = TransactionType('unresolved');
}

class Transaction {
  String accountId;
  double amount;
  String isoCurrencyCode;
  String unofficialCurrencyCode;
  List<String> category;
  String categoryId;
  DateTime date;
  TransactionLocation location;
  String name;
  bool pending;
  String pendingTransactionId;
  String transactionId;
  TransactionType transactionType;
}
