import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/models/user.dart';

class Cart {
  //for json output
  Address billing;
  Address shipping;
  bool set_paid;
  String payment_method;
  String payment_method_title;
  List<CartItem> line_items;
  List<ShippingLine> shipping_lines;
  double shipping_charges;
  double total = 0;

  double discount_total = 0;
  double shipping_total= 0;
  List<FeeLine> fee_lines = [];

  //for internal use
  String nonce;
  User? user;

  Cart({
    //for json out
    required this.payment_method,
    required this.payment_method_title,
    required this.set_paid,
    required this.billing,
    required this.shipping,
    required this.line_items,
    required this.shipping_lines,

    //json input
    itemsCount,
    itemsWeight,
    crossSells,
    needsPayment,
    needsShipping,
    hasCalculatedShipping,
    fees,
    totals,
    errors,
    required this.nonce,
    required List<dynamic> coupons,
    shippingRates,
    required List<String> paymentRequirements,
    required Map<String, dynamic> extensions,
    required this.shipping_charges
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    List<CartItem> items = [];
    try {
      items = json['items'] != null
          ? (json['items'] as List<dynamic>)
              .map((item) => CartItem.fromJson(item))
              .toList()
          : [];
      if(items.length ==0){
items =  json['line_items'] != null
          ? (json['line_items'] as List<dynamic>)
              .map((item) => CartItem.fromJson(item))
              .toList()
          : [];
      }
      
    } catch (ex) {
      print(ex);
    }

    Map<String, dynamic> extension = {};
    try {
      extension = json["extensions"] != null ? json["extensions"] : [];
    } catch (ex) {
      extension = {};
    }
    return Cart(
        //for json out
        payment_method: 'cash',
        payment_method_title: 'Cash',
        set_paid: false,
        shipping_lines: [],
        shipping: Address.fromJson(json['shipping_address'] ?? {}),
        billing: Address.fromJson(json['billing_address'] ?? {}),
        line_items: items ?? [],

        //json in
        coupons: json['coupons'] ?? [],
        shippingRates: json['shipping_rates'] ?? [],
        itemsCount: json['items_count'] ?? 0,
        itemsWeight: json['items_weight'] ?? 0.0,
        crossSells: json['cross_sells'] ?? [],
        needsPayment: json['needs_payment'] ?? false,
        needsShipping: json['needs_shipping'] ?? false,
        hasCalculatedShipping: json['has_calculated_shipping'] ?? false,
        fees: json['fees'] ?? [],
        totals: Totals.fromJson(json['totals'] ?? {}),
        errors: json['errors'] ?? [],
        paymentRequirements:
            List<String>.from(json['payment_requirements'] ?? []),
        nonce: "", //to update the cart
        extensions: extension,
        shipping_charges: json['shipping_charges'] ?? 0.0,
        // extensions: json['extensions'] ?? {},
        );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> lineItemsJson =
        line_items.map((item) => item.toJson()).toList();
    List<Map<String, dynamic>> shipping_lines_json =
    shipping_lines.map((item) => item.toJson()).toList();
    List<Map<String, dynamic>> fee_lines_json =
    fee_lines.map((item) => item.toJson()).toList();

    return {
      'payment_method': this.payment_method,
      'payment_method_title': this.payment_method_title,
      'set_paid': this.set_paid,
      'billing': this.billing.toJson(),
      'shipping': this.shipping.toJson(),
      "shipping_lines" : shipping_lines_json,
      'line_items': lineItemsJson,
      'customer_id': this.user != null ? this.user!.id : "",
      "shipping_total" : this.shipping_total,
      "discount_total" : this.discount_total,
      "total" : this.total,
      "fee_lines" : fee_lines_json
    };
  }

  addItem(carItem) {
    this.line_items.add(carItem);
  }

   updateItem(Cart cart, CartItem cart_item) {
 if (cart.line_items.where((element) => element.product_id == cart_item.product_id).length == 1){  
  CartItem update_item = cart.line_items.where((element) => element.product_id == cart_item.product_id).first;
  int update_index = cart.line_items.indexOf(update_item);
  update_item.quantity =update_item.quantity +  cart_item.quantity;
  cart.line_items.setAll(update_index, [update_item]);

  return cart;
} else {
  print("No matching items in cart");
}  }
}


class FeeLine
{ 
String name;
String tax_status = 'taxable';
String tax_class = "";
double total;
double total_tax =0;
List<dynamic> taxes =  [];
List<dynamic> meta_data =  [];

FeeLine({required this.name,required this.total });

 Map<String, dynamic> toJson() {
return {
  'name': this.name,
  'tax_status': this.tax_status,
  'tax_class': this.tax_class,
  "total" : this.total.toString(),
  "total_tax" : this.total_tax.toString(),
  "taxes" : [],
  "meta_data" : []
};
}
}


class ShippingLine {
  final String method_id;
  final String method_title;
  final double total;

  ShippingLine(
      {required this.method_id,
      required this.method_title,
      required this.total});

    Map<String, dynamic> toJson() {
return {
  'method_id': this.method_id,
  'method_title': this.method_title,
  'total': this.total.toString(),
};
}
}

class Address {
  String firstName;
  String lastName;
  String company;
  String address_1;
  String address_2;
  String city;
  String state;
  String postcode;
  String country;
  String email;
  String phone;

  Address({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.address_1,
    required this.address_2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    required this.email,
    required this.phone,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      company: json['company'] ?? '',
      address_1: json['address_1'] ?? '',
      address_2: json['address_2'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      postcode: json['postcode'] ?? '',
      country: json['country'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': this.firstName,
      'last_name': this.lastName,
      'company': this.company,
      'address_1': this.address_1,
      'address_2': this.address_2,
      'city': this.city,
      'state': this.state,
      'postcode': this.postcode,
      'country': this.country,
      'email': this.email,
      'phone': this.phone,
    };
  }
}

class Totals {
  String totalItems;
  String totalItemsTax;
  String totalFees;
  String totalFeesTax;
  String totalDiscount;
  String totalDiscountTax;
  dynamic totalShipping;
  dynamic totalShippingTax;
  String totalPrice;
  String totalTax;
  List<dynamic> taxLines;
  String currencyCode;
  String currencySymbol;
  int currencyMinorUnit;
  String currencyDecimalSeparator;
  String currencyThousandSeparator;
  String currencyPrefix;
  String currencySuffix;

  Totals({
    required this.totalItems,
    required this.totalItemsTax,
    required this.totalFees,
    required this.totalFeesTax,
    required this.totalDiscount,
    required this.totalDiscountTax,
    required this.totalShipping,
    required this.totalShippingTax,
    required this.totalPrice,
    required this.totalTax,
    required this.taxLines,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyMinorUnit,
    required this.currencyDecimalSeparator,
    required this.currencyThousandSeparator,
    required this.currencyPrefix,
    required this.currencySuffix,
  });

  factory Totals.fromJson(Map<String, dynamic> json) {
    return Totals(
      totalItems: json['total_items'] ?? '0',
      totalItemsTax: json['total_items_tax'] ?? '0',
      totalFees: json['total_fees'] ?? '0',
      totalFeesTax: json['total_fees_tax'] ?? '0',
      totalDiscount: json['total_discount'] ?? '0',
      totalDiscountTax: json['total_discount_tax'] ?? '0',
      totalShipping: json['total_shipping'],
      totalShippingTax: json['total_shipping_tax'],
      totalPrice: json['total_price'] ?? '0',
      totalTax: json['total_tax'] ?? '0',
      taxLines: json['tax_lines'] ?? [],
      currencyCode: json['currency_code'] ?? '',
      currencySymbol: json['currency_symbol'] ?? '',
      currencyMinorUnit: json['currency_minor_unit'] ?? 2,
      currencyDecimalSeparator: json['currency_decimal_separator'] ?? '.',
      currencyThousandSeparator: json['currency_thousand_separator'] ?? ',',
      currencyPrefix: json['currency_prefix'] ?? '',
      currencySuffix: json['currency_suffix'] ?? '',
    );
  }
}

class CartItem {
  final String key;
  final int product_id;
  late int quantity;
  final String name;
  late final double regularPrice;
  late final double salePrice;
  final String currencyCode;
  final String currencySymbol;
  final String lineTotalTax;
  final int currencyMinorUnit;
  final String currencyPrefix;
  final double linetotal;
  final double linediscount;
  final List<dynamic> variations;
  Product? product = null;

  CartItem(
      {required this.key,
      required this.product_id,
      required this.quantity,
      required this.name,
      // this.lowStockRemaining,
      required this.regularPrice,
      required this.salePrice,
      required this.currencyCode,
      required this.currencySymbol,
      required this.lineTotalTax,
      required this.currencyMinorUnit,
      required this.currencyPrefix,
      required this.linetotal,
      required this.linediscount,
      required this.variations});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    double regular_price = 0;
    if (json["regularPrice"] != null && json["regularPrice"] != "") {
      regular_price = json['regularPrice'];
    } else {
      regular_price =
          double.tryParse(json['prices']['regular_price'])! / 100 ?? 0.00;
    }

    double sale_price = 0;
    if (json["salePrice"] != null && json["salePrice"] != "") {
      sale_price = json['salePrice'];
    } else {
      sale_price =
          double.tryParse(json['prices']['sale_price'])! / 100 ?? 0.00;
    }
    
    if(sale_price==0){
      sale_price = regular_price;
    }


    return CartItem(
        key: json['key'] ?? '',
        product_id: json['product_id']!="" && json['product_id']!=null ? (json["product_id"] is int ?json['product_id'] : int.parse(json['product_id'])) : (json['id'] ?? 0),
        quantity: json['quantity'] ?? 0,
        name: json['name'] ?? '',
        // lowStockRemaining: json['low_stock_remaining'],
        regularPrice: regular_price,
        salePrice: sale_price,
        currencyCode: json['currencyCode'] != null && json['currencyCode'] != ""
            ? json['currencyCode']
            : (json['totals']['currency_code'] ?? ''),
        lineTotalTax: json['lineTotalTax'] != null && json['lineTotalTax'] != ""
            ? json['lineTotalTax']
            : (json['totals']['line_total_tax'] ?? ''),
        currencyMinorUnit: json['currencyMinorUnit'] != null && json['currencyMinorUnit'] != ""
            ? json['currencyMinorUnit']
            : (json['totals']['currency_minor_unit'] ?? ''),
        currencyPrefix: json['currencyPrefix'] != null && json['currencyPrefix'] != ""
            ? json['currencyPrefix']
            : (json['totals']['currency_prefix'] ?? ''),
        currencySymbol: json['currencySymbol'] != null && json['currencySymbol'] != ""
            ? json['currencySymbol']
            : (json['totals']['currency_symbol'] ?? ''),
        linetotal: 0,
        linediscount: 0,
        variations: json['variations'] != null ? json['variations'] : []);
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'product_id': product_id ==0 ? key : product_id,
      'quantity': quantity,
      'name': name,
      // 'lowStockRemaining': lowStockRemaining,
      'regularPrice': regularPrice,
      'salePrice': salePrice,
      'currencyCode': currencyCode,
      'currencySymbol': currencySymbol,
      'lineTotalTax': lineTotalTax,
      'currencyMinorUnit': currencyMinorUnit,
      'currencyPrefix': currencyPrefix,
      'linetotal': salePrice*quantity,
      'linediscount': linediscount,
      'product':product!=null? product!.toJson() : "0"
    };
  }
}

class BillingInfo extends Info {
  late String company;
  late String email;
  late String phone;
}

class ShippingInfo {}

class Info {
  late String first_name;
  late String last_name;
  late String postcode;
  late String country;
  late String state;

//below fields get updated through UIs
  late String address_1;
  late String address_2;
  late String city;
}

