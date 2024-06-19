import 'dart:convert';

class TaxResponsesModel {
  final String? status;
  final List<Tax>? data;

  TaxResponsesModel({
    this.status,
    this.data,
  });

  factory TaxResponsesModel.fromJson(String str) =>
      TaxResponsesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TaxResponsesModel.fromMap(Map<String, dynamic> json) =>
      TaxResponsesModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Tax>.from(json["data"]!.map((x) => Tax.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class Tax {
  final int? id;
  final String? value;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Tax({
    this.id,
    this.value,
    this.createdAt,
    this.updatedAt,
  });

  factory Tax.fromJson(String str) => Tax.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Tax.fromMap(Map<String, dynamic> json) => Tax(
        id: json["id"],
        value: json["value"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "value": value,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
