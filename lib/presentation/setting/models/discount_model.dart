import '../../home/models/product_category.dart';

class DiscountModel {
  final int? id;
  final String name;
  // final String code;
  final int discount;
  // final ProductCategory category;
  final String? description;

  DiscountModel({
    this.id,
    required this.name,
    // required this.code,
    required this.discount,
    // required this.category,
    required this.description,
  });
  factory DiscountModel.fromLocalMap(Map<String, dynamic> json) =>
      DiscountModel(
        id: json['id'],
        name: json['name'],
        // code: json['code'],
        discount: json['discount'],
        // category: ProductCategory.fromJson(json['category']),
        description: json['description'],
      );
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "discount": discount,
      "description": description,
    };
  }
}
