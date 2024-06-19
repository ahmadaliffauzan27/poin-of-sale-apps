import '../../home/models/product_category.dart';

class TaxModel {
  final int? id;
  final int pajak;
  final ProductCategory category;

  TaxModel({
    required this.id,
    required this.pajak,
    required this.category,
  });
}
