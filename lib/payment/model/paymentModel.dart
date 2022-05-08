class PaymentModel {
  String id;
  String intent;
  String state;
  String cart;
  Payer payer;
  List<Transactions> transactions;
  List<FailedTransactions> failedTransactions;
  String createTime;
  String updateTime;
  List<Links> links;

  PaymentModel(
      {this.id,
        this.intent,
        this.state,
        this.cart,
        this.payer,
        this.transactions,
        this.failedTransactions,
        this.createTime,
        this.updateTime,
        this.links});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    intent = json['intent'];
    state = json['state'];
    cart = json['cart'];
    payer = json['payer'] != null ? new Payer.fromJson(json['payer']) : null;
    if (json['transactions'] != null) {
      transactions = new List<Transactions>();
      json['transactions'].forEach((v) {
        transactions.add(new Transactions.fromJson(v));
      });
    }
    if (json['failed_transactions'] != null) {
      failedTransactions = new List<FailedTransactions>();
      json['failed_transactions'].forEach((v) {
        failedTransactions.add(new FailedTransactions.fromJson(v));
      });
    }
    createTime = json['create_time'];
    updateTime = json['update_time'];
    if (json['links'] != null) {
      links = new List<Links>();
      json['links'].forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['intent'] = this.intent;
    data['state'] = this.state;
    data['cart'] = this.cart;
    if (this.payer != null) {
      data['payer'] = this.payer.toJson();
    }
    if (this.transactions != null) {
      data['transactions'] = this.transactions.map((v) => v.toJson()).toList();
    }
    if (this.failedTransactions != null) {
      data['failed_transactions'] =
          this.failedTransactions.map((v) => v.toJson()).toList();
    }
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payer {
  String paymentMethod;
  String status;
  PayerInfo payerInfo;

  Payer({this.paymentMethod, this.status, this.payerInfo});

  Payer.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['payment_method'];
    status = json['status'];
    payerInfo = json['payer_info'] != null
        ? new PayerInfo.fromJson(json['payer_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_method'] = this.paymentMethod;
    data['status'] = this.status;
    if (this.payerInfo != null) {
      data['payer_info'] = this.payerInfo.toJson();
    }
    return data;
  }
}

class PayerInfo {
  String email;
  String firstName;
  String lastName;
  String payerId;
  ShippingAddress shippingAddress;
  String countryCode;

  PayerInfo(
      {this.email,
        this.firstName,
        this.lastName,
        this.payerId,
        this.shippingAddress,
        this.countryCode});

  PayerInfo.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    payerId = json['payer_id'];
    shippingAddress = json['shipping_address'] != null
        ? new ShippingAddress.fromJson(json['shipping_address'])
        : null;
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['payer_id'] = this.payerId;
    if (this.shippingAddress != null) {
      data['shipping_address'] = this.shippingAddress.toJson();
    }
    data['country_code'] = this.countryCode;
    return data;
  }
}

class ShippingAddress {
  String recipientName;
  String line1;
  String city;
  String state;
  String postalCode;
  String countryCode;

  ShippingAddress(
      {this.recipientName,
        this.line1,
        this.city,
        this.state,
        this.postalCode,
        this.countryCode});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    recipientName = json['recipient_name'];
    line1 = json['line1'];
    city = json['city'];
    state = json['state'];
    postalCode = json['postal_code'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recipient_name'] = this.recipientName;
    data['line1'] = this.line1;
    data['city'] = this.city;
    data['state'] = this.state;
    data['postal_code'] = this.postalCode;
    data['country_code'] = this.countryCode;
    return data;
  }
}

class Transactions {
  Amount amount;
  Payee payee;
  String description;
  String softDescriptor;
  ItemList itemList;
  List<RelatedResources> relatedResources;

  Transactions(
      {this.amount,
        this.payee,
        this.description,
        this.softDescriptor,
        this.itemList,
        this.relatedResources});

  Transactions.fromJson(Map<String, dynamic> json) {
    amount =
    json['amount'] != null ? new Amount.fromJson(json['amount']) : null;
    payee = json['payee'] != null ? new Payee.fromJson(json['payee']) : null;
    description = json['description'];
    softDescriptor = json['soft_descriptor'];
    itemList = json['item_list'] != null
        ? new ItemList.fromJson(json['item_list'])
        : null;
    if (json['related_resources'] != null) {
      relatedResources = new List<RelatedResources>();
      json['related_resources'].forEach((v) {
        relatedResources.add(new RelatedResources.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.amount != null) {
      data['amount'] = this.amount.toJson();
    }
    if (this.payee != null) {
      data['payee'] = this.payee.toJson();
    }
    data['description'] = this.description;
    data['soft_descriptor'] = this.softDescriptor;
    if (this.itemList != null) {
      data['item_list'] = this.itemList.toJson();
    }
    if (this.relatedResources != null) {
      data['related_resources'] =
          this.relatedResources.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Amount {
  String total;
  String currency;
  Details details;

  Amount({this.total, this.currency, this.details});

  Amount.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    currency = json['currency'];
    details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['currency'] = this.currency;
    if (this.details != null) {
      data['details'] = this.details.toJson();
    }
    return data;
  }
}

class Details {
  String subtotal;
  String shipping;
  String insurance;
  String handlingFee;
  String shippingDiscount;
  String discount;

  Details(
      {this.subtotal,
        this.shipping,
        this.insurance,
        this.handlingFee,
        this.shippingDiscount,
        this.discount});

  Details.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal'];
    shipping = json['shipping'];
    insurance = json['insurance'];
    handlingFee = json['handling_fee'];
    shippingDiscount = json['shipping_discount'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtotal'] = this.subtotal;
    data['shipping'] = this.shipping;
    data['insurance'] = this.insurance;
    data['handling_fee'] = this.handlingFee;
    data['shipping_discount'] = this.shippingDiscount;
    data['discount'] = this.discount;
    return data;
  }
}

class Payee {
  String merchantId;
  String email;

  Payee({this.merchantId, this.email});

  Payee.fromJson(Map<String, dynamic> json) {
    merchantId = json['merchant_id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merchant_id'] = this.merchantId;
    data['email'] = this.email;
    return data;
  }
}

class ItemList {
  List<Items> items;
  ShippingAddress shippingAddress;

  ItemList({this.items, this.shippingAddress});

  ItemList.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    shippingAddress = json['shipping_address'] != null
        ? new ShippingAddress.fromJson(json['shipping_address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    if (this.shippingAddress != null) {
      data['shipping_address'] = this.shippingAddress.toJson();
    }
    return data;
  }
}

class Items {
  String name;
  String price;
  String currency;
  String tax;
  int quantity;

  Items({this.name, this.price, this.currency, this.tax, this.quantity});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    currency = json['currency'];
    tax = json['tax'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['currency'] = this.currency;
    data['tax'] = this.tax;
    data['quantity'] = this.quantity;
    return data;
  }
}

class RelatedResources {
  Sale sale;

  RelatedResources({this.sale});

  RelatedResources.fromJson(Map<String, dynamic> json) {
    sale = json['sale'] != null ? new Sale.fromJson(json['sale']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sale != null) {
      data['sale'] = this.sale.toJson();
    }
    return data;
  }
}

class Sale {
  String id;
  String state;
  Amount amount;
  String paymentMode;
  String reasonCode;
  String protectionEligibility;
  String receiptId;
  String parentPayment;
  String createTime;
  String updateTime;
  List<Links> links;
  String softDescriptor;

  Sale(
      {this.id,
        this.state,
        this.amount,
        this.paymentMode,
        this.reasonCode,
        this.protectionEligibility,
        this.receiptId,
        this.parentPayment,
        this.createTime,
        this.updateTime,
        this.links,
        this.softDescriptor});

  Sale.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    state = json['state'];
    amount =
    json['amount'] != null ? new Amount.fromJson(json['amount']) : null;
    paymentMode = json['payment_mode'];
    reasonCode = json['reason_code'];
    protectionEligibility = json['protection_eligibility'];
    receiptId = json['receipt_id'];
    parentPayment = json['parent_payment'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    if (json['links'] != null) {
      links = new List<Links>();
      json['links'].forEach((v) {
        links.add(new Links.fromJson(v));
      });
    }
    softDescriptor = json['soft_descriptor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state'] = this.state;
    if (this.amount != null) {
      data['amount'] = this.amount.toJson();
    }
    data['payment_mode'] = this.paymentMode;
    data['reason_code'] = this.reasonCode;
    data['protection_eligibility'] = this.protectionEligibility;
    data['receipt_id'] = this.receiptId;
    data['parent_payment'] = this.parentPayment;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    if (this.links != null) {
      data['links'] = this.links.map((v) => v.toJson()).toList();
    }
    data['soft_descriptor'] = this.softDescriptor;
    return data;
  }
}

class Links {
  String href;
  String rel;
  String method;

  Links({this.href, this.rel, this.method});

  Links.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    rel = json['rel'];
    method = json['method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    data['rel'] = this.rel;
    data['method'] = this.method;
    return data;
  }
}

class FailedTransactions {
  String dummy;

  FailedTransactions({this.dummy});

  FailedTransactions.fromJson(Map<String, dynamic> json) {
    dummy = json['dummy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dummy'] = this.dummy;
    return data;
  }
}
