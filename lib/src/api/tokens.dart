import 'package:plaid_dart/src/api/configuration.dart';

class TokensApi {
  static Future<String> exchangePublicToken(
      String publicToken, ApiRequestFunction request) async {
    final api = ApiConfiguration(
        path: '/item/public_token/exchange',
        request: request,
        body: {
          'public_token': publicToken,
        });

    var response = await api.handle();

    return response['access_token'];
  }

  static Future<String> createPublicToken(
      String accessToken, ApiRequestFunction request) async {
    var api = ApiConfiguration(
        path: '/item/public_token/create',
        request: request,
        body: {
          'access_token': accessToken,
        });

    var response = await api.handle();

    return response['public_token'] as String;
  }

  static Future<String> invalidateAccessToken(
      String accessToken, ApiRequestFunction request) async {
    var api = ApiConfiguration(
        path: '/item/access_token/invalidate',
        request: request,
        body: {
          'access_token': accessToken,
        });

    var response = await api.handle();

    return response['new_access_token'] as String;
  }
}
