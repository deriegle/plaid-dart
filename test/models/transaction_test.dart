import 'package:plaid_dart/src/models/transaction.dart';
import 'package:test/test.dart';

void main() {
  test('Transaction fromJSON works', () {
    var json = {
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

    // "unofficial_currency_code": null,
    // "category": ["Shops", "Computers and Electronics"],
    // "category_id": "19013000",
    // "date": "2017-01-29",
    // "location": {
    //   "address": "300 Post St",
    //   "city": "San Francisco",
    //   "region": "CA",
    //   "postal_code": "94108",
    //   "country": "US",
    //   "lat": null,
    //   "lon": null
    // },
    // "name": "Apple Store",
    // "payment_meta": Object,
    // "pending": false,
    // "pending_transaction_id": null,
    // "account_owner": null,
    // "transaction_id": "lPNjeW1nR6CDn5okmGQ6hEpMo4lLNoSrzqDje",
    // "transaction_type": "place"
  });
}
