import 'package:plaid_dart/src/models/item.dart';
import 'package:plaid_dart/src/api/configuration.dart';

class ItemsApi {
  static Future<Item> getItem(String accessToken, ApiRequestFunction request) async {
    final api = ApiConfiguration(
      path: '/item/get',
      request: request,
      body: {
        'access_token': accessToken,
      }
    );

    var response = await api.handle();

    return Item.fromJson(response['item']);
  }

  static Future<bool> removeItem(String accessToken, ApiRequestFunction request) async {
    final api = ApiConfiguration(
      path: '/item/remove',
      request: request,
      body: {
        'access_token': accessToken,
      }
    );

    var response = await api.handle();

    return response['removed'];
  }

  static Future<Item> updateItemWebhook(String accessToken, String newWebhook, ApiRequestFunction request) async {
    final api = ApiConfiguration(
      path: '/item/webhook/update',
      request: request,
      body: {
        'access_token': accessToken,
        'webhook': newWebhook
      }
    );

    var response = await api.handle();

    return Item.fromJson(response['item']);
  }
}