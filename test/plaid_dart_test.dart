import 'package:plaid_dart/plaid_dart.dart';
import 'dart:convert';
import 'package:plaid_dart/src/models/item.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('PlaidClient', () {
    PlaidClient client;
    String clientId;
    PlaidEnvironment environment;
    String publicKey;
    String secret;
    MockHttpClient httpClient;

    setUp(() {
      clientId = '1234';
      publicKey = '12345';
      secret = '12346';
      httpClient = MockHttpClient();
    });

    group('sandbox environment', () {
      setUp(() {
        environment = PlaidEnvironment.sandbox;
        client = PlaidClient(
            clientId: clientId,
            environment: environment,
            publicKey: publicKey,
            secret: secret,
            httpClient: httpClient);
      });

      test('sets the url correctly', () {
        expect(client.url, 'https://sandbox.plaid.com');
      });

      test('sets a default http client', () {
        client = PlaidClient(
            clientId: clientId,
            environment: environment,
            publicKey: publicKey,
            secret: secret);

        expect(client.httpClient, isNotNull);
        expect(client.httpClient, isA<http.Client>());
      });

      test('lets you override the client when testing', () {
        expect(client.httpClient, isNotNull);
        expect(client.httpClient, isA<MockHttpClient>());
      });

      group('exchangePublicToken', () {
        test('calls api with the correct path and parameters', () async {
          final publicToken = 'my_public_token';
          when(httpClient
              .post('https://sandbox.plaid.com/item/public_token/exchange',
                  body: json.encode({
                    'public_token': publicToken,
                  }))).thenAnswer((_) => Future.value(http.Response(
              json.encode({'access_token': '12345678910'}), 200)));

          final accessToken = await client.exchangePublicToken(publicToken);

          expect(accessToken, '12345678910');
        });
      });

      group('createPublicToken', () {
        test('calls api with correct path and parameters', () async {
          final accessToken = 'my_access_token';
          when(httpClient.post(
                  'https://sandbox.plaid.com/item/public_token/create',
                  body: json.encode({'access_token': accessToken})))
              .thenAnswer((_) => Future.value(http.Response(
                  json.encode({'public_token': '12345678910'}), 200)));

          final publicToken = await client.createPublicToken(accessToken);

          expect(publicToken, '12345678910');
        });
      });

      group('updateItemWebhook', () {
        test('calls api with correct path and parameters', () async {
          final accessToken = 'my_access_token';
          final webhook = 'http://localhost:3000';
          when(httpClient.post('https://sandbox.plaid.com/item/webhook/update',
                  body: json.encode(
                      {'access_token': accessToken, 'webhook': webhook})))
              .thenAnswer((_) => Future.value(http.Response(
                  json.encode({
                    'item': {
                      'available_products': [],
                      'billed_products': [],
                      'institution_id': '9399393',
                      'item_id': '1993993',
                      'webhook': webhook,
                    }
                  }),
                  200)));

          final item = await client.updateItemWebhook(accessToken, webhook);

          expect(item, isA<Item>());
          expect(item.item_id, '1993993');
          expect(item.institution_id, '9399393');
        });
      });

      group('invalidateAccessToken', () {
        test('calls api with correct path and parameters', () async {
          final accessToken = 'my_access_token';
          when(httpClient.post(
                  'https://sandbox.plaid.com/item/access_token/invalidate',
                  body: json.encode({'access_token': accessToken})))
              .thenAnswer((_) => Future.value(http.Response(
                  json.encode({
                    'request_id': '1929395839',
                    'new_access_token': '9399933918939',
                  }),
                  200)));

          final newAccessToken =
              await client.invalidateAccessToken(accessToken);

          expect(newAccessToken, '9399933918939');
        });
      });

      group('removeItem', () {
        test('calls api with correct path and parameters', () async {
          final accessToken = 'my_access_token';
          when(httpClient.post('https://sandbox.plaid.com/item/remove',
                  body: json.encode({'access_token': accessToken})))
              .thenAnswer((_) => Future.value(http.Response(
                  json.encode({
                    'request_id': '1929395839',
                    'removed': true,
                  }),
                  200)));

          final removed = await client.removeItem(accessToken);

          expect(removed, isTrue);
        });
      });

      group('getItem', () {
        test('calls api with correct path and parameters', () async {
          final accessToken = 'my_access_token';
          when(httpClient.post('https://sandbox.plaid.com/item/get',
                  body: json.encode({'access_token': accessToken})))
              .thenAnswer((_) => Future.value(http.Response(
                  json.encode({
                    'request_id': '1929395839',
                    'item': {
                      'available_products': [],
                      'billed_products': [],
                      'institution_id': '9399393',
                      'item_id': '1993993',
                      'webhook': 'https://google.com',
                    }
                  }),
                  200)));

          final item = await client.getItem(accessToken);

          expect(item, isNotNull);
          expect(item.available_products, isEmpty);
          expect(item.billed_products, isEmpty);
          expect(item.institution_id, '9399393');
          expect(item.item_id, '1993993');
          expect(item.webhook, 'https://google.com');
        });
      });

      group('getAccounts', () {
        test('calls api with correct path and parameters', () async {
          final accessToken = 'my_access_token';
          when(httpClient.post('https://sandbox.plaid.com/accounts/get',
                  body: json.encode({'access_token': accessToken})))
              .thenAnswer((_) => Future.value(http.Response(
                  json.encode({
                    'request_id': '1929395839',
                    'item': {
                      'available_products': [],
                      'billed_products': [],
                      'institution_id': '9399393',
                      'item_id': '1993993',
                      'webhook': 'https://google.com',
                    },
                    'accounts': [
                      {
                        'account_id': '1234939',
                        'name': 'Chase Bank',
                        'official_name':
                            'J.P. Morgan & Chase Financial Institute',
                        'subtype': 'Checking Account',
                        'type': 'Checking',
                        'balances': {
                          'available': 1939.00,
                          'current': 2333.00,
                          'limit': 1500.00,
                          'iso_currency_code': '\$',
                          'unofficial_currency_code': 'USD',
                        }
                      },
                      {
                        'account_id': '1234939',
                        'name': 'Huntington Bank',
                        'official_name': 'Huntington Financial Institute',
                        'subtype': 'Checking Account',
                        'type': 'Checking',
                        'balances': {
                          'available': 3000.00,
                          'current': 3200.00,
                          'limit': 1500.00,
                          'iso_currency_code': '\$',
                          'unofficial_currency_code': 'USD',
                        }
                      },
                    ]
                  }),
                  200)));

          final response = await client.getAccounts(accessToken);

          expect(response.item, isNotNull);
          expect(response.accounts, hasLength(2));
          expect(response.accounts.first.name, 'Chase Bank');
          expect(response.accounts.first.balances.available, 1939.00);
          expect(response.accounts.last.name, 'Huntington Bank');
          expect(response.accounts.last.balances.available, 3000.00);
        });
      });

      group('getTransactions', () {
        test('calls api with the correct path and parameters', () async {
          final accessToken = 'my_access_token';
          final secret = 'my_custom_secret';
          final startDate = DateTime.parse('2019-01-01');
          final endDate = DateTime.parse('2019-02-10');

          when(httpClient.post('https://sandbox.plaid.com/transactions/get',
              body: json.encode({
                'access_token': accessToken,
                'secret': secret,
                'start_date': '2019-1-1',
                'end_date': '2019-2-10',
              }))).thenAnswer((_) => Future.value(http.Response(
              json.encode({
                'request_id': '1929395839',
                'item': {
                  'available_products': [],
                  'billed_products': [],
                  'institution_id': '9399393',
                  'item_id': '1993993',
                  'webhook': 'https://google.com',
                },
                'transactions': [
                  {
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
                    "payment_meta": {},
                    "pending": false,
                    "pending_transaction_id": null,
                    "account_owner": null,
                    "transaction_id": "lPNjeW1nR6CDn5okmGQ6hEpMo4lLNoSrzqDje",
                    "transaction_type": "place"
                  },
                  {
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
                    "payment_meta": {},
                    "pending": false,
                    "pending_transaction_id": null,
                    "account_owner": null,
                    "transaction_id": "lPNjeW1nR6CDn5okmGQ6hEpMo4lLNoSrzqDje",
                    "transaction_type": "place"
                  },
                ],
              }),
              200)));

          final result = await client.getTransactions(
              accessToken, secret, startDate, endDate);

          expect(result.transactions, hasLength(2));
        });
      });
    });

    group('development environment', () {
      setUp(() {
        environment = PlaidEnvironment.development;
        client = PlaidClient(
            clientId: clientId,
            environment: environment,
            publicKey: publicKey,
            secret: secret);
      });

      test('sets the url correctly', () {
        expect(client.url, 'https://development.plaid.com');
      });
    });

    group('production environment', () {
      setUp(() {
        environment = PlaidEnvironment.production;
        client = PlaidClient(
            clientId: clientId,
            environment: environment,
            publicKey: publicKey,
            secret: secret);
      });

      test('sets the url correctly', () {
        expect(client.url, 'https://production.plaid.com');
      });
    });
  });
}
