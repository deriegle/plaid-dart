import 'package:plaid_dart/src/models/transaction.dart';
import 'package:test/test.dart';

void main() {
  test('Transaction fromJSON works', () {
    Map<String, dynamic> json = {
      "account_id": "vokyE5Rn6vHKqDLRXEn5fne7LwbKPLIXGK98d",
      "amount": 2307.21,
      "iso_currency_code": "USD",
      "unofficial_currency_code": null,
      "category": ["Shops", "Computers and Electronics"],
      "category_id": "19013000",
      "date": "2017-01-29",
      "location": {
        "address": "300 Post St",
        "city": "San Francisco",
        "region": "CA",
        "postal_code": "94108",
        "country": "US",
        "lat": null,
        "lon": null
      },
      "name": "Apple Store",
      "payment_meta": Object,
      "pending": false,
      "pending_transaction_id": null,
      "account_owner": null,
      "transaction_id": "lPNjeW1nR6CDn5okmGQ6hEpMo4lLNoSrzqDje",
      "transaction_type": "place"
    };

    var transaction = Transaction.fromJson(json);

    expect(transaction.accountId, json["account_id"]);
    expect(transaction.amount, json["amount"]);
    expect(transaction.isoCurrencyCode, json["iso_currency_code"]);
    expect(
        transaction.unofficialCurrencyCode, json['unofficial_currency_code']);
    expect(transaction.category, ["Shops", "Computers and Electronics"]);
    expect(transaction.categoryId, json['category_id']);
    expect(transaction.date.toString().substring(0, 10), json['date']);
    expect(transaction.pending, false);
    expect(transaction.pendingTransactionId, null);
    expect(transaction.transactionId, json['transaction_id']);
    expect(transaction.transactionType.value, TransactionType.PLACE.value);
    expect(transaction.name, json['name']);
    expect(transaction.location.address, (json['location'] as Map)['address']);
    expect(transaction.location.city, 'San Francisco');
    expect(transaction.location.region, 'CA');
    expect(transaction.location.postalCode, '94108');
    expect(transaction.location.country, 'US');
    expect(transaction.location.lat, isNull);
    expect(transaction.location.lon, isNull);
  });

  test('parses transaction location correctly', () {
    Map<String, dynamic> json = {
      "account_id": "vokyE5Rn6vHKqDLRXEn5fne7LwbKPLIXGK98d",
      "amount": 2307.21,
      "iso_currency_code": "USD",
      "unofficial_currency_code": null,
      "category": ["Shops", "Computers and Electronics"],
      "category_id": "19013000",
      "date": "2017-01-29",
      "location": {
        "address": null,
        "city": "San Francisco",
        "region": "CA",
        "postal_code": "94108",
        "country": "US",
        "lat": null,
        "lon": null
      },
      "name": "Apple Store",
      "payment_meta": {},
      "pending": false,
      "pending_transaction_id": null,
      "account_owner": null,
      "transaction_id": "lPNjeW1nR6CDn5okmGQ6hEpMo4lLNoSrzqDje",
      "transaction_type": "place"
    };

    var transaction = Transaction.fromJson(json);

    expect(transaction.location, isNull);

    json = {
      "account_id": "vokyE5Rn6vHKqDLRXEn5fne7LwbKPLIXGK98d",
      "amount": 2307.21,
      "iso_currency_code": "USD",
      "unofficial_currency_code": null,
      "category": ["Shops", "Computers and Electronics"],
      "category_id": "19013000",
      "date": "2017-01-29",
      "location": {
        "address": null,
        "city": "San Francisco",
        "region": "CA",
        "postal_code": "94108",
        "country": "US",
        "lat": 83,
        "lon": -45
      },
      "name": "Apple Store",
      "payment_meta": {},
      "pending": false,
      "pending_transaction_id": null,
      "account_owner": null,
      "transaction_id": "lPNjeW1nR6CDn5okmGQ6hEpMo4lLNoSrzqDje",
      "transaction_type": "place"
    };

    transaction = Transaction.fromJson(json);

    expect(transaction.location.lat, 83);
    expect(transaction.location.lon, -45);

    json = {
      "account_id": "vokyE5Rn6vHKqDLRXEn5fne7LwbKPLIXGK98d",
      "amount": 2307.21,
      "iso_currency_code": "USD",
      "unofficial_currency_code": null,
      "category": ["Shops", "Computers and Electronics"],
      "category_id": "19013000",
      "date": "2017-01-29",
      "location": {
        "address": null,
        "city": "San Francisco",
        "region": "CA",
        "postal_code": "94108",
        "country": "US",
        "lat": 83.2020,
        "lon": -45.3555
      },
      "name": "Apple Store",
      "payment_meta": {},
      "pending": false,
      "pending_transaction_id": null,
      "account_owner": null,
      "transaction_id": "lPNjeW1nR6CDn5okmGQ6hEpMo4lLNoSrzqDje",
      "transaction_type": "place"
    };

    transaction = Transaction.fromJson(json);
    expect(transaction.location.lat, 83.2020);
    expect(transaction.location.lon, -45.3555);
  });
}
