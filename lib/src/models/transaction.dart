import 'package:meta/meta.dart';

class TransactionLocation {
  String address;
  String city;
  String region;
  String postalCode;
  String country;
  double lat;
  double lon;

  TransactionLocation({
    this.address,
    this.city,
    this.region,
    this.postalCode,
    this.country,
    this.lat,
    this.lon,
  });

  factory TransactionLocation.fromJson(Map<String, dynamic> json) {
    return TransactionLocation(
      address: json['address'],
      city: json['city'],
      region: json['region'],
      postalCode: json['postal_code'],
      country: json['country'],
      lat: json['lat'],
      lon: json['lon'],
    );
  }
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

  factory TransactionType.fromString(String str) {
    switch (str) {
      case 'place':
        return TransactionType.PLACE;
      case 'special':
        return TransactionType.SPECIAL;
      case 'digital':
        return TransactionType.DIGITAL;
      case 'unresolved':
        return TransactionType.UNRESOLVED;
      default:
        throw AssertionError(
            'String must be a defined constant in TransactionType');
    }
  }
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

  Transaction({
    @required this.accountId,
    this.amount,
    this.isoCurrencyCode,
    this.unofficialCurrencyCode,
    this.category,
    this.categoryId,
    this.date,
    this.location,
    this.name,
    this.pending,
    this.pendingTransactionId,
    this.transactionId,
    this.transactionType,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      accountId: json['account_id'],
      amount: json['amount'],
      isoCurrencyCode: json['iso_currency_code'],
      unofficialCurrencyCode: json['unofficial_currency_code'],
      category: List.from(json['category'] ?? []),
      categoryId: json['category_id'],
      date: DateTime.parse(json['date']),
      pending: json['pending'] as bool,
      pendingTransactionId: json['pending_transaction_id'],
      transactionId: json['transaction_id'],
      transactionType: TransactionType.fromString(json['transaction_type']),
      name: json['name'],
      location: TransactionLocation.fromJson(json['location']),
    );
  }
}
