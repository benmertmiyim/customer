class PayResult {
  String? status;
  String? locale;
  double? systemTime;
  double? price;
  double? paidPrice;
  double? installment;
  String? paymentId;
  double? fraudStatus;
  double? merchantCommissionRate;
  double? merchantCommissionRateAmount;
  double? iyziCommissionRateAmount;
  double? iyziCommissionFee;
  String? cardType;
  String? cardAssociation;
  String? cardFamily;
  String? binNumber;
  String? lastFourDigits;
  String? currency;
  List<ItemTransactions>? itemTransactions;
  String? authCode;
  String? phase;
  String? hostReference;

  PayResult(
      {this.status,
        this.locale,
        this.systemTime,
        this.price,
        this.paidPrice,
        this.installment,
        this.paymentId,
        this.fraudStatus,
        this.merchantCommissionRate,
        this.merchantCommissionRateAmount,
        this.iyziCommissionRateAmount,
        this.iyziCommissionFee,
        this.cardType,
        this.cardAssociation,
        this.cardFamily,
        this.binNumber,
        this.lastFourDigits,
        this.currency,
        this.itemTransactions,
        this.authCode,
        this.phase,
        this.hostReference});

  PayResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    locale = json['locale'];
    systemTime = json['systemTime'].toDouble();
    price = json['price'].toDouble();
    paidPrice = json['paidPrice'].toDouble();
    installment = json['installment'].toDouble();
    paymentId = json['paymentId'];
    fraudStatus = json['fraudStatus'].toDouble();
    merchantCommissionRate = json['merchantCommissionRate'].toDouble();
    merchantCommissionRateAmount = json['merchantCommissionRateAmount'].toDouble();
    iyziCommissionRateAmount = json['iyziCommissionRateAmount'].toDouble();
    iyziCommissionFee = json['iyziCommissionFee'].toDouble();
    cardType = json['cardType'];
    cardAssociation = json['cardAssociation'];
    cardFamily = json['cardFamily'];
    binNumber = json['binNumber'];
    lastFourDigits = json['lastFourDigits'];
    currency = json['currency'];
    if (json['itemTransactions'] != null) {
      itemTransactions = <ItemTransactions>[];
      json['itemTransactions'].forEach((v) {
        itemTransactions!.add(new ItemTransactions.fromJson(v));
      });
    }
    authCode = json['authCode'];
    phase = json['phase'];
    hostReference = json['hostReference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['locale'] = this.locale;
    data['systemTime'] = this.systemTime;
    data['price'] = this.price;
    data['paidPrice'] = this.paidPrice;
    data['installment'] = this.installment;
    data['paymentId'] = this.paymentId;
    data['fraudStatus'] = this.fraudStatus;
    data['merchantCommissionRate'] = this.merchantCommissionRate;
    data['merchantCommissionRateAmount'] = this.merchantCommissionRateAmount;
    data['iyziCommissionRateAmount'] = this.iyziCommissionRateAmount;
    data['iyziCommissionFee'] = this.iyziCommissionFee;
    data['cardType'] = this.cardType;
    data['cardAssociation'] = this.cardAssociation;
    data['cardFamily'] = this.cardFamily;
    data['binNumber'] = this.binNumber;
    data['lastFourDigits'] = this.lastFourDigits;
    data['currency'] = this.currency;
    if (this.itemTransactions != null) {
      data['itemTransactions'] =
          this.itemTransactions!.map((v) => v.toJson()).toList();
    }
    data['authCode'] = this.authCode;
    data['phase'] = this.phase;
    data['hostReference'] = this.hostReference;
    return data;
  }
}

class ItemTransactions {
  String? itemId;
  String? paymentTransactionId;
  double? transactionStatus;
  double? price;
  double? paidPrice;
  double? merchantCommissionRate;
  double? merchantCommissionRateAmount;
  double? iyziCommissionRateAmount;
  double? iyziCommissionFee;
  double? blockageRate;
  double? blockageRateAmountMerchant;
  double? blockageRateAmountSubMerchant;
  String? blockageResolvedDate;
  double? subMerchantPrice;
  double? subMerchantPayoutRate;
  double? subMerchantPayoutAmount;
  double? merchantPayoutAmount;
  ConvertedPayout? convertedPayout;

  ItemTransactions(
      {this.itemId,
        this.paymentTransactionId,
        this.transactionStatus,
        this.price,
        this.paidPrice,
        this.merchantCommissionRate,
        this.merchantCommissionRateAmount,
        this.iyziCommissionRateAmount,
        this.iyziCommissionFee,
        this.blockageRate,
        this.blockageRateAmountMerchant,
        this.blockageRateAmountSubMerchant,
        this.blockageResolvedDate,
        this.subMerchantPrice,
        this.subMerchantPayoutRate,
        this.subMerchantPayoutAmount,
        this.merchantPayoutAmount,
        this.convertedPayout});

  ItemTransactions.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    paymentTransactionId = json['paymentTransactionId'];
    transactionStatus = json['transactionStatus'].toDouble();
    price = json['price'].toDouble();
    paidPrice = json['paidPrice'].toDouble();
    merchantCommissionRate = json['merchantCommissionRate'].toDouble();
    merchantCommissionRateAmount = json['merchantCommissionRateAmount'].toDouble();
    iyziCommissionRateAmount = json['iyziCommissionRateAmount'].toDouble();
    iyziCommissionFee = json['iyziCommissionFee'].toDouble();
    blockageRate = json['blockageRate'].toDouble();
    blockageRateAmountMerchant = json['blockageRateAmountMerchant'].toDouble();
    blockageRateAmountSubMerchant = json['blockageRateAmountSubMerchant'].toDouble();
    blockageResolvedDate = json['blockageResolvedDate'];
    subMerchantPrice = json['subMerchantPrice'].toDouble();
    subMerchantPayoutRate = json['subMerchantPayoutRate'].toDouble();
    subMerchantPayoutAmount = json['subMerchantPayoutAmount'].toDouble();
    merchantPayoutAmount = json['merchantPayoutAmount'].toDouble();
    convertedPayout = json['convertedPayout'] != null
        ? new ConvertedPayout.fromJson(json['convertedPayout'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['paymentTransactionId'] = this.paymentTransactionId;
    data['transactionStatus'] = this.transactionStatus;
    data['price'] = this.price;
    data['paidPrice'] = this.paidPrice;
    data['merchantCommissionRate'] = this.merchantCommissionRate;
    data['merchantCommissionRateAmount'] = this.merchantCommissionRateAmount;
    data['iyziCommissionRateAmount'] = this.iyziCommissionRateAmount;
    data['iyziCommissionFee'] = this.iyziCommissionFee;
    data['blockageRate'] = this.blockageRate;
    data['blockageRateAmountMerchant'] = this.blockageRateAmountMerchant;
    data['blockageRateAmountSubMerchant'] = this.blockageRateAmountSubMerchant;
    data['blockageResolvedDate'] = this.blockageResolvedDate;
    data['subMerchantPrice'] = this.subMerchantPrice;
    data['subMerchantPayoutRate'] = this.subMerchantPayoutRate;
    data['subMerchantPayoutAmount'] = this.subMerchantPayoutAmount;
    data['merchantPayoutAmount'] = this.merchantPayoutAmount;
    if (this.convertedPayout != null) {
      data['convertedPayout'] = this.convertedPayout!.toJson();
    }
    return data;
  }
}

class ConvertedPayout {
  double? paidPrice;
  double? iyziCommissionRateAmount;
  double? iyziCommissionFee;
  double? blockageRateAmountMerchant;
  double? blockageRateAmountSubMerchant;
  double? subMerchantPayoutAmount;
  double? merchantPayoutAmount;
  double? iyziConversionRate;
  double? iyziConversionRateAmount;
  String? currency;

  ConvertedPayout(
      {this.paidPrice,
        this.iyziCommissionRateAmount,
        this.iyziCommissionFee,
        this.blockageRateAmountMerchant,
        this.blockageRateAmountSubMerchant,
        this.subMerchantPayoutAmount,
        this.merchantPayoutAmount,
        this.iyziConversionRate,
        this.iyziConversionRateAmount,
        this.currency});

  ConvertedPayout.fromJson(Map<String, dynamic> json) {
    paidPrice = json['paidPrice'].toDouble();
    iyziCommissionRateAmount = json['iyziCommissionRateAmount'].toDouble();
    iyziCommissionFee = json['iyziCommissionFee'].toDouble();
    blockageRateAmountMerchant = json['blockageRateAmountMerchant'].toDouble();
    blockageRateAmountSubMerchant = json['blockageRateAmountSubMerchant'].toDouble();
    subMerchantPayoutAmount = json['subMerchantPayoutAmount'].toDouble();
    merchantPayoutAmount = json['merchantPayoutAmount'].toDouble();
    iyziConversionRate = json['iyziConversionRate'].toDouble();
    iyziConversionRateAmount = json['iyziConversionRateAmount'].toDouble();
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paidPrice'] = this.paidPrice;
    data['iyziCommissionRateAmount'] = this.iyziCommissionRateAmount;
    data['iyziCommissionFee'] = this.iyziCommissionFee;
    data['blockageRateAmountMerchant'] = this.blockageRateAmountMerchant;
    data['blockageRateAmountSubMerchant'] = this.blockageRateAmountSubMerchant;
    data['subMerchantPayoutAmount'] = this.subMerchantPayoutAmount;
    data['merchantPayoutAmount'] = this.merchantPayoutAmount;
    data['iyziConversionRate'] = this.iyziConversionRate;
    data['iyziConversionRateAmount'] = this.iyziConversionRateAmount;
    data['currency'] = this.currency;
    return data;
  }
}
