import 'dart:convert';

class OrderResponsesModel {
  final String? status;
  final List<ItemOrder>? data;

  OrderResponsesModel({
    this.status,
    this.data,
  });

  factory OrderResponsesModel.fromJson(String str) =>
      OrderResponsesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderResponsesModel.fromMap(Map<String, dynamic> json) =>
      OrderResponsesModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<ItemOrder>.from(
                json["data"]!.map((x) => ItemOrder.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}

class ItemOrder {
  final int? id;
  final int? paymentAmount;
  final int? subTotal;
  final int? tax;
  final int? discount;
  final int? serviceCharge;
  final int? total;
  final String? paymentMethod;
  final int? totalItem;
  final int? idKasir;
  final String? namaKasir;
  final String? transactionTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ItemOrder({
    this.id,
    this.paymentAmount,
    this.subTotal,
    this.tax,
    this.discount,
    this.serviceCharge,
    this.total,
    this.paymentMethod,
    this.totalItem,
    this.idKasir,
    this.namaKasir,
    this.transactionTime,
    this.createdAt,
    this.updatedAt,
  });

  factory ItemOrder.fromJson(String str) => ItemOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemOrder.fromMap(Map<String, dynamic> json) => ItemOrder(
        id: json["id"],
        paymentAmount: json["payment_amount"],
        subTotal: json["sub_total"],
        tax: json["tax"],
        discount: json["discount"],
        serviceCharge: json["service_charge"],
        total: json["total"],
        paymentMethod: json["payment_method"],
        totalItem: json["total_item"],
        idKasir: json["id_kasir"],
        namaKasir: json["nama_kasir"],
        transactionTime: json["transaction_time"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "payment_amount": paymentAmount,
        "sub_total": subTotal,
        "tax": tax,
        "discount": discount,
        "service_charge": serviceCharge,
        "total": total,
        "payment_method": paymentMethod,
        "total_item": totalItem,
        "id_kasir": idKasir,
        "nama_kasir": namaKasir,
        "transaction_time": transactionTime,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
