import 'package:plaid_dart/src/models/account.dart';
import 'package:plaid_dart/src/models/item.dart';
import 'package:plaid_dart/src/api/configuration.dart';

class GetAccountsResponse {
  Item item;
  List<Account> accounts;

  GetAccountsResponse({this.item, this.accounts});
}

class AccountsApi {
  static Future<GetAccountsResponse> getAccounts(
      String accessToken, ApiRequestFunction request) async {
    final api =
        ApiConfiguration(path: '/accounts/get', request: request, body: {
      'access_token': accessToken,
    });

    var response = await api.handle();

    return GetAccountsResponse(
        item: Item.fromJson(response['item']),
        accounts: accountsFromJson(response));
  }

  static List<Account> accountsFromJson(json) {
    List<Account> accounts = [];

    if (json['accounts'] is List) {
      List<Map<String, dynamic>> jsonAccounts = List.from(json['accounts']);

      for (var jsonAccount in jsonAccounts) {
        accounts.add(Account.fromJson(jsonAccount));
      }
    }

    return accounts;
  }
}
