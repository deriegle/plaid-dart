import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:plaid_dart/src/models/item.dart';
import 'package:plaid_dart/src/models/account.dart';
import 'package:http/http.dart' as http;

enum PlaidEnvironment { development, production, sandbox }

class Plaid {}

class PlaidClient {
  http.Client httpClient;
  String secret;
  String clientId;
  String publicKey;
  PlaidEnvironment environment;
  Map<String, dynamic> options = {};

  PlaidClient({
    @required this.clientId,
    @required this.environment,
    @required this.publicKey,
    @required this.secret,
    this.httpClient,
    this.options,
  }) {
    if (this.httpClient == null) {
      this.httpClient = http.Client();
    }
  }

  String get url {
    final environment = this.environment.toString().split('.').last;

    return 'https://${environment}.plaid.com';
  }

  Future<String> createPublicToken(String accessToken) async {
    final response = await _sendRequest('/item/public_token/create', {
      'access_token': accessToken,
    });

    return response['public_token'];
  }

  Future<String> exchangePublicToken(String publicToken) async {
    final response = await _sendRequest('/item/public_token/exchange', {
      'public_token': publicToken,
    });

    return response['access_token'];
  }

  Future<Item> updateItemWebhook(
      String accessToken, String updatedWebhook) async {
    final response = await _sendRequest('/item/webhook/update',
        {'access_token': accessToken, 'webhook': updatedWebhook});

    return Item.fromJson(response['item']);
  }

  Future<String> invalidateAccessToken(String accessToken) async {
    final response = await _sendRequest(
        '/item/access_token/invalidate', {'access_token': accessToken});

    return response['new_access_token'];
  }

  Future<bool> removeItem(String accessToken) async {
    final response =
        await _sendRequest('/item/remove', {'access_token': accessToken});

    return response['removed'];
  }

  Future<Item> getItem(String accessToken) async {
    final response =
        await _sendRequest('/item/get', {'access_token': accessToken});

    return Item.fromJson(response['item']);
  }

  Future<GetAccountsResponse> getAccounts(String accessToken) async {
    final response =
        await _sendRequest('/accounts/get', {'access_token': accessToken});
    List<Account> accounts = [];

    if (response['accounts'] is List) {
      var parsedJsonAccounts =
          List<Map<String, dynamic>>.from(response['accounts']);

      accounts =
          parsedJsonAccounts.map((json) => Account.fromJson(json)).toList();
    }

    return GetAccountsResponse(
        item: Item.fromJson(response['item']), accounts: accounts);
  }

  Future<Map<String, dynamic>> _sendRequest(
      String request_url, Map<String, dynamic> body) async {
    final response =
        await httpClient.post('$url$request_url', body: _encodeBody(body));

    return json.decode(response.body);
  }

  String _encodeBody(dynamic body) {
    return json.encode(body);
  }
}

class GetAccountsResponse {
  Item item;
  List<Account> accounts;

  GetAccountsResponse({this.item, this.accounts});
}
