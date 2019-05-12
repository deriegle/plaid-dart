import 'package:meta/meta.dart';

class Item {
  List<dynamic> available_products;
  List<dynamic> billed_products;
  String institution_id;
  String item_id;
  String webhook;

  Item(
      {this.available_products,
      this.billed_products,
      @required this.institution_id,
      @required this.item_id,
      @required this.webhook}) {
    if (this.available_products == null) {
      this.available_products = List();
    }

    if (this.billed_products == null) {
      this.billed_products = List();
    }
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      available_products: json['available_products'],
      billed_products: json['billed_products'],
      institution_id: json['institution_id'],
      item_id: json['item_id'],
      webhook: json['webhook'],
    );
  }
}
