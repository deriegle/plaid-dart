import 'package:plaid_dart/plaid_dart.dart';
import 'dart:convert';
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
