import 'package:plaid_dart/src/models/transaction.dart';
import 'package:plaid_dart/src/models/item.dart';
import 'package:plaid_dart/src/api/configuration.dart';

class GetTransactionsResponse {
  Item item;
  List<Transaction> transactions;

  GetTransactionsResponse({this.item, this.transactions});
}

class TransactionsApi {
  static Future<GetTransactionsResponse> getTransactions(
      String accessToken, ApiRequestFunction request) async {
    final api =
        ApiConfiguration(path: '/transactions/get', request: request, body: {
      'access_token': accessToken,
    });

    var response = await api.handle();

    return GetTransactionsResponse(
        item: Item.fromJson(response['item']),
        transactions: transactionsFromJson(response));
  }

  static List<Transaction> transactionsFromJson(Map<String, dynamic> json) {
    List<Transaction> transactions = [];

    if (json['transactions'] is List) {
      List<Map<String, dynamic>> jsonTransactions =
          List.from(json['transactions']);

      for (var jsonTransaction in jsonTransactions) {
        transactions.add(Transaction.fromJson(jsonTransaction));
      }
    }

    return transactions;
  }
}
