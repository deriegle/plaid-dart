## A Plaid library for Dart developers.
This package was inspired by [`plaid-node`](https://github.com/plaid/plaid-node).

***Warning this package is under development. Not safe for use in production***

This package is currently being developed using Futures and no callbacks.
I think the `async/await` form of development is easier than using callbacks.

I am modeling a lot of the code after the official `plaid-node` package mentioned above, but
I trying to make it more modular, easier to test and hopefully easier for other to contribute.

I am developing this to use this in my personal and professional projects and will release this as a package
once I am confident this package is working as intended.

## Usage

```dart
import 'package:plaid_dart/plaid_dart.dart';

main() async {
  var plaidClient = PlaidClient(
    environment: PlaidEnvironment.sandbox,
    clientId: '',
    publicKey: '',
    secret: '',
  );
  
  var publicToken = await plaidClient.getPublicToken('my_access_token');
  var item = await plaidClient.getItem('my_access_token');
}
```

**Common Links**
- [Plaid docs](https://plaid.com/docs/)
- [`plaid-node` package](https://github.com/plaid/plaid-node)
