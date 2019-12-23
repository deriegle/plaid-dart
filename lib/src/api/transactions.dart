import 'package:plaid_dart/plaid_dart.dart';
import 'package:plaid_dart/src/models/transaction.dart';
import 'package:plaid_dart/src/models/item.dart';
import 'package:plaid_dart/src/api/configuration.dart';

class GetTransactionsResponse {
  Item item;
  List<Transaction> transactions;

  GetTransactionsResponse({this.item, this.transactions});
}

class GetTransactionOptions {
  List<String> accountIds;
  int count;
  int offset;

  GetTransactionOptions({
    this.accountIds,
    this.count,
    this.offset,
  });
}

class TransactionsApi {
  static Future<GetTransactionsResponse> getTransactions(
      String accessToken,
      String secret,
      DateTime startDate,
      DateTime endDate,
      ApiRequestFunction request,
      {GetTransactionOptions options}) async {
    Map<String, dynamic> body = {
      'access_token': accessToken,
      'secret': secret,
      'start_date': formatForServer(startDate),
      'end_date': formatForServer(endDate),
    };

    if (options != null) {
      body['options'] = {};

      if (options.count != null) {
        body['options']['count'] = options.count;
      }

      if (options.offset != null) {
        body['options']['offset'] = options.offset;
      }

      if (options.accountIds != null && options.accountIds.isNotEmpty) {
        body['options']['account_ids'] = options.accountIds;
      }
    }

    final api = ApiConfiguration(
      path: '/transactions/get',
      request: request,
      body: body,
    );

    var response = await api.handle();

    return GetTransactionsResponse(
      item: Item.fromJson(response['item']),
      transactions: transactionsFromJson(response),
    );
  }

  static List<Transaction> transactionsFromJson(Map<String, dynamic> json) {
    List<Transaction> transactions = [];

    if (json['transactions'] is List) {
      List<Map<String, dynamic>> jsonTransactions = List.from(
        json['transactions'],
      );

      for (var jsonTransaction in jsonTransactions) {
        transactions.add(Transaction.fromJson(jsonTransaction));
      }
    }

    return transactions;
  }

  static String formatForServer(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }
}
