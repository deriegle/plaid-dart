import 'package:plaid_dart/plaid_dart.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:http/testing.dart';

main() async {
  var plaidClient = PlaidClient(
    clientId: 'my_client_id',
    environment: PlaidEnvironment.sandbox,
    publicKey: 'my_public_key',
    secret: 'my_secret',
    httpClient: MockClient(
      (req) async => Response(
        json.encode({'public_token': 'my_fake_public_token'}),
        200,
      ),
    ),
  );

  print('My environment is ${plaidClient.environment}');

  var publicToken = await plaidClient.createPublicToken('123456');
  print('Here is your public token ${publicToken}');

  var accessToken = await plaidClient.exchangePublicToken(publicToken);

  var startDate = DateTime.parse("2019-1-1");
  var endDate = DateTime.parse("2019-2-1");
  var result = await plaidClient.getTransactions(
    accessToken,
    startDate,
    endDate,
  );

  print('Here are the transactions');

  for (final transaction in result.transactions) {
    print('Transaction : ${transaction.name}');
  }
}
