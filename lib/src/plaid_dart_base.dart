import 'package:meta/meta.dart';
import 'dart:convert';
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

  Future<Map<String, dynamic>> _sendRequest(
      String request_url, Map<String, dynamic> body) async {
    final response =
        await httpClient.post('$url/$request_url', body: _encodeBody(body));

    return json.decode(response.body);
  }

  String _encodeBody(dynamic body) {
    return json.encode(body);
  }
}
