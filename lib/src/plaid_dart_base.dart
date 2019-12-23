import 'package:meta/meta.dart';
import 'package:plaid_dart/src/api/accounts.dart';
import 'package:plaid_dart/src/api/items.dart';
import 'package:plaid_dart/src/api/tokens.dart';
import 'package:plaid_dart/src/api/transactions.dart';
import 'dart:convert';
import 'package:plaid_dart/src/models/item.dart';
import 'package:http/http.dart' as http;

enum PlaidEnvironment { development, production, sandbox }

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
    this.httpClient = this.httpClient ?? http.Client();
  }

  String get url {
    final environment = this.environment.toString().split('.').last;

    return 'https://${environment}.plaid.com';
  }

  Future<String> createPublicToken(String accessToken) {
    return TokensApi.createPublicToken(accessToken, _sendRequest);
  }

  Future<String> exchangePublicToken(String publicToken) {
    return TokensApi.exchangePublicToken(publicToken, _sendRequest);
  }

  Future<String> invalidateAccessToken(String accessToken) async {
    return TokensApi.invalidateAccessToken(accessToken, _sendRequest);
  }

  Future<Item> updateItemWebhook(
      String accessToken, String updatedWebhook) async {
    return await ItemsApi.updateItemWebhook(
        accessToken, updatedWebhook, _sendRequest);
  }

  Future<bool> removeItem(String accessToken) async {
    return ItemsApi.removeItem(accessToken, _sendRequest);
  }

  Future<Item> getItem(String accessToken) async {
    return await ItemsApi.getItem(accessToken, _sendRequest);
  }

  Future<GetAccountsResponse> getAccounts(String accessToken) async {
    return AccountsApi.getAccounts(accessToken, _sendRequest);
  }

  Future<GetTransactionsResponse> getTransactions(
    String accessToken,
    DateTime startDate,
    DateTime endDate, {
    GetTransactionOptions options,
  }) async {
    return TransactionsApi.getTransactions(
      accessToken,
      this.secret,
      startDate,
      endDate,
      _sendRequest,
      options: options,
    );
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
