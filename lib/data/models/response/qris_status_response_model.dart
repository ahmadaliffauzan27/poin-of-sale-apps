import 'dart:convert';

class QrisStatusResponseModel {
    final String? maskedCard;
    final String? approvalCode;
    final String? bank;
    final String? eci;
    final String? channelResponseCode;
    final String? channelResponseMessage;
    final DateTime? transactionTime;
    final String? grossAmount;
    final String? currency;
    final String? orderId;
    final String? paymentType;
    final String? signatureKey;
    final String? statusCode;
    final String? transactionId;
    final String? transactionStatus;
    final String? fraudStatus;
    final DateTime? settlementTime;
    final String? statusMessage;
    final String? merchantId;
    final String? cardType;
    final String? threeDsVersion;
    final bool? challengeCompletion;

    QrisStatusResponseModel({
        this.maskedCard,
        this.approvalCode,
        this.bank,
        this.eci,
        this.channelResponseCode,
        this.channelResponseMessage,
        this.transactionTime,
        this.grossAmount,
        this.currency,
        this.orderId,
        this.paymentType,
        this.signatureKey,
        this.statusCode,
        this.transactionId,
        this.transactionStatus,
        this.fraudStatus,
        this.settlementTime,
        this.statusMessage,
        this.merchantId,
        this.cardType,
        this.threeDsVersion,
        this.challengeCompletion,
    });

    factory QrisStatusResponseModel.fromJson(String str) => QrisStatusResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory QrisStatusResponseModel.fromMap(Map<String, dynamic> json) => QrisStatusResponseModel(
        maskedCard: json["masked_card"],
        approvalCode: json["approval_code"],
        bank: json["bank"],
        eci: json["eci"],
        channelResponseCode: json["channel_response_code"],
        channelResponseMessage: json["channel_response_message"],
        transactionTime: json["transaction_time"] == null ? null : DateTime.parse(json["transaction_time"]),
        grossAmount: json["gross_amount"],
        currency: json["currency"],
        orderId: json["order_id"],
        paymentType: json["payment_type"],
        signatureKey: json["signature_key"],
        statusCode: json["status_code"],
        transactionId: json["transaction_id"],
        transactionStatus: json["transaction_status"],
        fraudStatus: json["fraud_status"],
        settlementTime: json["settlement_time"] == null ? null : DateTime.parse(json["settlement_time"]),
        statusMessage: json["status_message"],
        merchantId: json["merchant_id"],
        cardType: json["card_type"],
        threeDsVersion: json["three_ds_version"],
        challengeCompletion: json["challenge_completion"],
    );

    Map<String, dynamic> toMap() => {
        "masked_card": maskedCard,
        "approval_code": approvalCode,
        "bank": bank,
        "eci": eci,
        "channel_response_code": channelResponseCode,
        "channel_response_message": channelResponseMessage,
        "transaction_time": transactionTime?.toIso8601String(),
        "gross_amount": grossAmount,
        "currency": currency,
        "order_id": orderId,
        "payment_type": paymentType,
        "signature_key": signatureKey,
        "status_code": statusCode,
        "transaction_id": transactionId,
        "transaction_status": transactionStatus,
        "fraud_status": fraudStatus,
        "settlement_time": settlementTime?.toIso8601String(),
        "status_message": statusMessage,
        "merchant_id": merchantId,
        "card_type": cardType,
        "three_ds_version": threeDsVersion,
        "challenge_completion": challengeCompletion,
    };
}
