import '../../home/models/product_category.dart';

class DiscountModel {
  final int? id;
  final String name;
  final String code;
  final int discount;
  final ProductCategory category;
  final String? description;

  DiscountModel({
    this.id,
    required this.name,
    required this.code,
    required this.discount,
    required this.category,
    required this.description,
  });
}
