
class Pay {
  Pay({
    required this.status,
    required this.locale,
    required this.systemTime,
    required this.price,
    required this.paidPrice,
    required this.installment,
    required this.paymentId,
    required this.fraudStatus,
    required this.merchantCommissionRate,
    required this.merchantCommissionRateAmount,
    required this.iyziCommissionRateAmount,
    required this.iyziCommissionFee,
    required this.cardType,
    required this.cardAssociation,
    required this.cardFamily,
    required this.binNumber,
    required this.lastFourDigits,
    required this.currency,
    required this.itemTransactions,
    required this.authCode,
    required this.phase,
    required this.hostReference,
  });

  final String status;
  final String locale;
  final int systemTime;
  final int price;
  final int paidPrice;
  final int installment;
  final String paymentId;
  final int fraudStatus;
  final int merchantCommissionRate;
  final int merchantCommissionRateAmount;
  final double iyziCommissionRateAmount;
  final double iyziCommissionFee;
  final String cardType;
  final String cardAssociation;
  final String cardFamily;
  final String binNumber;
  final String lastFourDigits;
  final String currency;
  final List<ItemTransaction> itemTransactions;
  final String authCode;
  final String phase;
  final String hostReference;

  factory Pay.fromJson(Map<String, dynamic> json) => Pay(
    status: json["status"],
    locale: json["locale"],
    systemTime: json["systemTime"],
    price: json["price"],
    paidPrice: json["paidPrice"],
    installment: json["installment"],
    paymentId: json["paymentId"],
    fraudStatus: json["fraudStatus"],
    merchantCommissionRate: json["merchantCommissionRate"],
    merchantCommissionRateAmount: json["merchantCommissionRateAmount"],
    iyziCommissionRateAmount: json["iyziCommissionRateAmount"].toDouble(),
    iyziCommissionFee: json["iyziCommissionFee"].toDouble(),
    cardType: json["cardType"],
    cardAssociation: json["cardAssociation"],
    cardFamily: json["cardFamily"],
    binNumber: json["binNumber"],
    lastFourDigits: json["lastFourDigits"],
    currency: json["currency"],
    itemTransactions: List<ItemTransaction>.from(json["itemTransactions"].map((x) => ItemTransaction.fromJson(x))),
    authCode: json["authCode"],
    phase: json["phase"],
    hostReference: json["hostReference"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "locale": locale,
    "systemTime": systemTime,
    "price": price,
    "paidPrice": paidPrice,
    "installment": installment,
    "paymentId": paymentId,
    "fraudStatus": fraudStatus,
    "merchantCommissionRate": merchantCommissionRate,
    "merchantCommissionRateAmount": merchantCommissionRateAmount,
    "iyziCommissionRateAmount": iyziCommissionRateAmount,
    "iyziCommissionFee": iyziCommissionFee,
    "cardType": cardType,
    "cardAssociation": cardAssociation,
    "cardFamily": cardFamily,
    "binNumber": binNumber,
    "lastFourDigits": lastFourDigits,
    "currency": currency,
    "itemTransactions": List<dynamic>.from(itemTransactions.map((x) => x.toJson())),
    "authCode": authCode,
    "phase": phase,
    "hostReference": hostReference,
  };
}

class ItemTransaction {
  ItemTransaction({
    required this.itemId,
    required this.paymentTransactionId,
    required this.transactionStatus,
    required this.price,
    required this.paidPrice,
    required this.merchantCommissionRate,
    required this.merchantCommissionRateAmount,
    required this.iyziCommissionRateAmount,
    required this.iyziCommissionFee,
    required this.blockageRate,
    required this.blockageRateAmountMerchant,
    required this.blockageRateAmountSubMerchant,
    required this.blockageResolvedDate,
    required this.subMerchantPrice,
    required this.subMerchantPayoutRate,
    required this.subMerchantPayoutAmount,
    required this.merchantPayoutAmount,
    required this.convertedPayout,
  });

  final String itemId;
  final String paymentTransactionId;
  final int transactionStatus;
  final int price;
  final int paidPrice;
  final int merchantCommissionRate;
  final int merchantCommissionRateAmount;
  final double iyziCommissionRateAmount;
  final double iyziCommissionFee;
  final int blockageRate;
  final int blockageRateAmountMerchant;
  final int blockageRateAmountSubMerchant;
  final DateTime blockageResolvedDate;
  final int subMerchantPrice;
  final int subMerchantPayoutRate;
  final int subMerchantPayoutAmount;
  final double merchantPayoutAmount;
  final ConvertedPayout convertedPayout;

  factory ItemTransaction.fromJson(Map<String, dynamic> json) => ItemTransaction(
    itemId: json["itemId"],
    paymentTransactionId: json["paymentTransactionId"],
    transactionStatus: json["transactionStatus"],
    price: json["price"],
    paidPrice: json["paidPrice"],
    merchantCommissionRate: json["merchantCommissionRate"],
    merchantCommissionRateAmount: json["merchantCommissionRateAmount"],
    iyziCommissionRateAmount: json["iyziCommissionRateAmount"].toDouble(),
    iyziCommissionFee: json["iyziCommissionFee"].toDouble(),
    blockageRate: json["blockageRate"],
    blockageRateAmountMerchant: json["blockageRateAmountMerchant"],
    blockageRateAmountSubMerchant: json["blockageRateAmountSubMerchant"],
    blockageResolvedDate: DateTime.parse(json["blockageResolvedDate"]),
    subMerchantPrice: json["subMerchantPrice"],
    subMerchantPayoutRate: json["subMerchantPayoutRate"],
    subMerchantPayoutAmount: json["subMerchantPayoutAmount"],
    merchantPayoutAmount: json["merchantPayoutAmount"].toDouble(),
    convertedPayout: ConvertedPayout.fromJson(json["convertedPayout"]),
  );

  Map<String, dynamic> toJson() => {
    "itemId": itemId,
    "paymentTransactionId": paymentTransactionId,
    "transactionStatus": transactionStatus,
    "price": price,
    "paidPrice": paidPrice,
    "merchantCommissionRate": merchantCommissionRate,
    "merchantCommissionRateAmount": merchantCommissionRateAmount,
    "iyziCommissionRateAmount": iyziCommissionRateAmount,
    "iyziCommissionFee": iyziCommissionFee,
    "blockageRate": blockageRate,
    "blockageRateAmountMerchant": blockageRateAmountMerchant,
    "blockageRateAmountSubMerchant": blockageRateAmountSubMerchant,
    "blockageResolvedDate": blockageResolvedDate.toIso8601String(),
    "subMerchantPrice": subMerchantPrice,
    "subMerchantPayoutRate": subMerchantPayoutRate,
    "subMerchantPayoutAmount": subMerchantPayoutAmount,
    "merchantPayoutAmount": merchantPayoutAmount,
    "convertedPayout": convertedPayout.toJson(),
  };
}

class ConvertedPayout {
  ConvertedPayout({
    required this.paidPrice,
    required this.iyziCommissionRateAmount,
    required this.iyziCommissionFee,
    required this.blockageRateAmountMerchant,
    required this.blockageRateAmountSubMerchant,
    required this.subMerchantPayoutAmount,
    required this.merchantPayoutAmount,
    required this.iyziConversionRate,
    required this.iyziConversionRateAmount,
    required this.currency,
  });

  final int paidPrice;
  final double iyziCommissionRateAmount;
  final double iyziCommissionFee;
  final int blockageRateAmountMerchant;
  final int blockageRateAmountSubMerchant;
  final int subMerchantPayoutAmount;
  final double merchantPayoutAmount;
  final int iyziConversionRate;
  final int iyziConversionRateAmount;
  final String currency;

  factory ConvertedPayout.fromJson(Map<String, dynamic> json) => ConvertedPayout(
    paidPrice: json["paidPrice"],
    iyziCommissionRateAmount: json["iyziCommissionRateAmount"].toDouble(),
    iyziCommissionFee: json["iyziCommissionFee"].toDouble(),
    blockageRateAmountMerchant: json["blockageRateAmountMerchant"],
    blockageRateAmountSubMerchant: json["blockageRateAmountSubMerchant"],
    subMerchantPayoutAmount: json["subMerchantPayoutAmount"],
    merchantPayoutAmount: json["merchantPayoutAmount"].toDouble(),
    iyziConversionRate: json["iyziConversionRate"],
    iyziConversionRateAmount: json["iyziConversionRateAmount"],
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "paidPrice": paidPrice,
    "iyziCommissionRateAmount": iyziCommissionRateAmount,
    "iyziCommissionFee": iyziCommissionFee,
    "blockageRateAmountMerchant": blockageRateAmountMerchant,
    "blockageRateAmountSubMerchant": blockageRateAmountSubMerchant,
    "subMerchantPayoutAmount": subMerchantPayoutAmount,
    "merchantPayoutAmount": merchantPayoutAmount,
    "iyziConversionRate": iyziConversionRate,
    "iyziConversionRateAmount": iyziConversionRateAmount,
    "currency": currency,
  };
}
