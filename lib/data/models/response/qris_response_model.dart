import 'dart:convert';

class QrisResponseModel {
    final String? statusCode;
    final String? statusMessage;
    final String? transactionId;
    final String? orderId;
    final String? merchantId;
    final String? grossAmount;
    final String? currency;
    final String? paymentType;
    final DateTime? transactionTime;
    final String? transactionStatus;
    final String? fraudStatus;
    final List<Action>? actions;
    final DateTime? expiryTime;

    QrisResponseModel({
        this.statusCode,
        this.statusMessage,
        this.transactionId,
        this.orderId,
        this.merchantId,
        this.grossAmount,
        this.currency,
        this.paymentType,
        this.transactionTime,
        this.transactionStatus,
        this.fraudStatus,
        this.actions,
        this.expiryTime,
    });

    factory QrisResponseModel.fromJson(String str) => QrisResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory QrisResponseModel.fromMap(Map<String, dynamic> json) => QrisResponseModel(
        statusCode: json["status_code"],
        statusMessage: json["status_message"],
        transactionId: json["transaction_id"],
        orderId: json["order_id"],
        merchantId: json["merchant_id"],
        grossAmount: json["gross_amount"],
        currency: json["currency"],
        paymentType: json["payment_type"],
        transactionTime: json["transaction_time"] == null ? null : DateTime.parse(json["transaction_time"]),
        transactionStatus: json["transaction_status"],
        fraudStatus: json["fraud_status"],
        actions: json["actions"] == null ? [] : List<Action>.from(json["actions"]!.map((x) => Action.fromMap(x))),
        expiryTime: json["expiry_time"] == null ? null : DateTime.parse(json["expiry_time"]),
    );

    Map<String, dynamic> toMap() => {
        "status_code": statusCode,
        "status_message": statusMessage,
        "transaction_id": transactionId,
        "order_id": orderId,
        "merchant_id": merchantId,
        "gross_amount": grossAmount,
        "currency": currency,
        "payment_type": paymentType,
        "transaction_time": transactionTime?.toIso8601String(),
        "transaction_status": transactionStatus,
        "fraud_status": fraudStatus,
        "actions": actions == null ? [] : List<dynamic>.from(actions!.map((x) => x.toMap())),
        "expiry_time": expiryTime?.toIso8601String(),
    };
}

class Action {
    final String? name;
    final String? method;
    final String? url;

    Action({
        this.name,
        this.method,
        this.url,
    });

    factory Action.fromJson(String str) => Action.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Action.fromMap(Map<String, dynamic> json) => Action(
        name: json["name"],
        method: json["method"],
        url: json["url"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "method": method,
        "url": url,
    };
}
