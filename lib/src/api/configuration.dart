import 'package:meta/meta.dart';

typedef ApiRequestFunction = Function(String path, Map<String, dynamic> body);

class ApiConfiguration {
  ApiRequestFunction request;
  String path;
  Map<String, dynamic> body;

  ApiConfiguration({@required this.path, this.body, @required this.request});

  dynamic handle() async => await this.request(path, body);
}
