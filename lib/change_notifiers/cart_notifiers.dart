// Define a ProductNotifier class that extends ChangeNotifier
import 'dart:convert';

import 'package:ecommerce_int2/api_services/cart_apis.dart';
import 'package:ecommerce_int2/api_services/order_apis.dart';
import 'package:ecommerce_int2/api_services/shipping.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/cart.dart';

//This class acts as the notifier to all api calls we do for the main page.
class CartNotifier extends ChangeNotifier {
  late Cart? cart = null;
  Shipping shipping_cal = Shipping();

  //line items and discounts
  double totalLineDiscounts = 0;
  double totalBeforeDiscounts = 0;
  double bill_amount = 0;
  double discountOnTotal = 0;
  double total = 0;

  //payment related
  late String payment_method_title = "";
  int selected_payment_method = 0;
  late String payment_method = "";
  Map<String, double> payment_method_discounts = {
    'cash': 3,
    'card': 0,
    'card_on_delivery': 0,
    'bt': 0,
  };
  double payment_method_discount_amount = 0;
  double payment_method_discount_percentage = 0;
  bool paid = false;

  //shipping related
  late Address? billing_address = null;
  late Address? shipping_address = null;
 
  double shipping_charges = 0;
  String shipping_method_id = "";
  String shipping_method_title = "";

  double calculateTotalWeight() {
    double totalWeight = this.cart!.line_items.fold(
        0.0,
        (sum, lineItem) =>
            sum + (double.parse(lineItem.product!.weight) * lineItem.quantity));
    totalWeight = double.parse(totalWeight.toStringAsFixed(0));
    return totalWeight;
  }
  //Calculates all order related numbers
  void calculateOrderInfo(user) {
    OrderAPIs.calculateOrderInfo(this.cart).then((result) {
      if (result.status) {
        this.totalLineDiscounts = double.tryParse(result.result["response"]["response"]["totalLineDiscounts"]) as double;
        this.totalBeforeDiscounts = double.tryParse(result.result["response"]["response"]["totalBeforeDiscounts"])  as double;
        this.discountOnTotal = double.tryParse(result.result["response"]["response"]["discountOnTotal"]) as double;
        this.shipping_charges = double.tryParse(result.result["response"]["response"]["shipping_charges"]) as double;
        this.total = double.tryParse(result.result["response"]["response"]["total"]) as double;
        this.bill_amount = double.tryParse(result.result["response"]["response"]["billAmount"]) as double;
        notifyListeners();
      }
    });
    

    // // Calculate total line discounts and total before discounts
    // for (var item in cart!.line_items) {
    //   double lineTotal = item.quantity * item.salePrice;
    //   print(item.quantity);
    //   totalBeforeDiscounts += lineTotal;

    //   double discountAmount = (item.linediscount / 100) * lineTotal;
    //   totalLineDiscounts += discountAmount;
    // }


    // // payment method discounts
    // this.discountOnTotal = (totalBeforeDiscounts - totalLineDiscounts) *
    //     (payment_method_discount_percentage / 100);

    // if(this.shipping_method_id!="sp"){
    // double totalWeight = this.cart!.line_items.fold(
    //     0.0,
    //     (sum, lineItem) =>
    //         sum + (double.parse(lineItem.product!.weight) * lineItem.quantity));
    // totalWeight = double.parse(totalWeight.toStringAsFixed(0));
    //   this.shipping_charges = shipping_cal.getShippingCost(user!.shipping_info.city,
    //       user!.shipping_info.state, totalWeight);
    //   this.total =
    //       (totalBeforeDiscounts - totalLineDiscounts) - discountOnTotal;
    //   this.total += this.shipping_charges;
    // }else{
    //    this.shipping_charges = 0;
    //   this.total =
    //       (totalBeforeDiscounts - totalLineDiscounts) - discountOnTotal;
    //   this.total += this.shipping_charges;

    // }
    

    
  }

 
                                                              
  double getTotalBeforeDiscount() {
    double total = 0;
    if(this.cart==null){
      return 0;
    }
    for (var item in this.cart!.line_items) {
      total += item.quantity*item.salePrice; 
    }
    notifyListeners();
    return total;
  }
  Future<Cart?> getCart() async {
    print("cart fetched");
    this.shipping_cal.loadJson();
    var cart =await CartAPIs.getCart();
    return cart;
  }

  Future<void> addItem(Product product, quantity) async {
    CartAPIs cartAPIs = CartAPIs();
    CartItem cart_item = CartItem(key: product.id.toString(), product_id: product.id, quantity: quantity, name: product.name,
    regularPrice: product.regular_price =="" ? 0.0: double.parse(product.regular_price),
    salePrice: product.sale_price =="" ? 0.0: double.parse(product.sale_price),
    currencyCode: "LKR", currencySymbol: "LKR", lineTotalTax: "0", currencyMinorUnit: 0, currencyPrefix: "Rs.", linetotal:(product.sale_price =="" ? 0.0: double.parse(product.sale_price))*quantity,
    linediscount: 0, variations: []);
    readCartNonce().then((nonce)  async {
        if(nonce != null){ //Online cart
          cartAPIs.addItem(cart_item);
        } else{ //Local cart
          final storage = FlutterSecureStorage();
          var value_cart = await storage.read(key: 'local_cart');
        if (value_cart == null) {
          //create a cart
         var empty_cart_json = json.decode(
              '{"coupons":[],"shipping_rates":[],"shipping_address":{"first_name":"","last_name":"","company":"","address_1":"","address_2":"","city":"","state":"","postcode":"","country":"","phone":""},"billing_address":{"first_name":"","last_name":"","company":"","address_1":"","address_2":"","city":"","state":"","postcode":"","country":"","email":"","phone":""},"items":[],"items_count":0,"items_weight":0,"cross_sells":[],"needs_payment":false,"needs_shipping":false,"has_calculated_shipping":false,"fees":[],"totals":{"total_items":"0","total_items_tax":"0","total_fees":"0","total_fees_tax":"0","total_discount":"0","total_discount_tax":"0","total_shipping":null,"total_shipping_tax":null,"total_price":"0","total_tax":"0","tax_lines":[],"currency_code":"LKR","currency_symbol":"Rs. ","currency_minor_unit":2,"currency_decimal_separator":".","currency_thousand_separator":",","currency_prefix":"Rs. ","currency_suffix":""},"errors":[],"payment_requirements":["products"],"extensions":{}}');
         Cart cart = Cart.fromJson(empty_cart_json);
         //if cart item already exist, add the quantity.
         //else, add item to cart.
         cart.addItem(cart_item);
        await storage.write(key: 'local_cart',value: json.encode(cart.toJson()));
        return true;
        }else{
          //load the cart and add the item
          var cart_json = json.decode(value_cart);
          Cart cart = Cart.fromJson(cart_json);
         // ignore: unnecessary_null_comparison, unnecessary_null_comparison
         if (cart.line_items.where((element) => element.product_id == cart_item.product_id).length == 0){
          cart.addItem(cart_item);
        } else {
          cart = cart.updateItem(cart, cart_item);
        }

 await storage.write(
      key: 'local_cart', value: json.encode(cart.toJson()));

        }
        return true;
      }
        notifyListeners();
    });
  }

  Future<String?> readCartNonce() async {
      final storage = FlutterSecureStorage();
      return await storage.read(key: 'cart_nonce');
  }

  

  addOrUpdateAddress1(String address1) {
    if (this.cart?.shipping == null) {
      this.cart?.shipping = Address(
          firstName: "",
          lastName: "",
          company: "",
          address1: address1,
          address2: "",
          city: "",
          state: "",
          postcode: "",
          country: "",
          email: "",
          phone: "");
    } else {
      this.cart?.shipping.address1 = address1;
    }
  }

  void addOrUpdateAddress2(String address2) {
    if (this.cart?.shipping == null) {
      this.cart?.shipping = Address(
          firstName: "",
          lastName: "",
          company: "",
          address1: "",
          address2: address2,
          city: "",
          state: "",
          postcode: "",
          country: "",
          email: "",
          phone: "");
    } else {
      this.cart?.shipping.address2 = address2;
    }
  }

  void addOrUpdateFirstName(String value) {
    if (this.cart?.shipping == null) {
      this.cart?.shipping = Address(
          firstName: value,
          lastName: "",
          company: "",
          address1: "",
          address2: "",
          city: "",
          state: "",
          postcode: "",
          country: "",
          email: "",
          phone: "");
    } else {
      this.cart?.shipping.firstName = value;
    }
  }

  void addOrUpdateLastName(String value) {
    if (this.cart?.shipping == null) {
      this.cart?.shipping = Address(
          firstName: "",
          lastName: value,
          company: "",
          address1: "",
          address2: "",
          city: "",
          state: "",
          postcode: "",
          country: "",
          email: "",
          phone: "");
    } else {
      this.cart?.shipping.lastName = value;
    }
  }

  void addOrUpdateCity(String city) {
    if (this.cart?.shipping == null) {
      this.cart?.shipping = Address(
          firstName: "",
          lastName: "",
          company: "",
          address1: "",
          address2: "",
          city: city,
          state: "",
          postcode: "",
          country: "",
          email: "",
          phone: "");
    } else {
      this.cart?.shipping.city = city;
    }
  }

  void addOrUpdateStateOrProvince(String value) {
    if (this.cart?.shipping == null) {
      this.cart?.shipping = Address(
          firstName: "",
          lastName: "",
          company: "",
          address1: "",
          address2: "",
          city: "",
          state: value,
          postcode: "",
          country: "",
          email: "",
          phone: "");
    } else {
      this.cart?.shipping.state = value;
    }
  }

  Future<bool> createOrder() async {
    CartAPIs cartAPIs = CartAPIs();
    bool created = await cartAPIs.createOrder(this.cart);
    return created;
  }

  void updatePayentMethod(user,payment_method, payment_method_title) {
    this.payment_method = payment_method;
    this.payment_method_title = payment_method_title;
    this.payment_method_discount_percentage =
        this.payment_method_discounts[payment_method]!;

    this.calculateOrderInfo(user);
    notifyListeners();
  }

  void updateShippingMethod(user, shipping_method) {
    this.cart!.user = user;
    this.shipping_method_id = shipping_method;
    this.calculateOrderInfo(user);
    return;
  }

  void copyShippingInfoToBilling() {
    cart?.billing = Address(
        firstName: cart!.shipping.firstName,
        lastName: cart!.shipping.lastName,
        company: "",
        address1: cart!.shipping.address1,
        address2: cart!.shipping.address2,
        city: cart!.shipping.city,
        state: cart!.shipping.state,
        postcode: cart!.shipping.postcode,
        country: cart!.shipping.country,
        email: "",
        phone: "");
  }

  void loadProduct(Cart _cart) {
    this.cart = _cart;
  }

  void updateLineItemQuantity(int id,int quantity) {
    int? index = this.cart?.line_items.indexWhere((cart_item) => cart_item.product_id == id);
    this.cart?.line_items[index as int].quantity = quantity;
  }

  void addCustomer(User? user) {
    this.cart?.user = user;
  }

  void updateBillingInfo(User? user) {
    this.cart?.billing = Address(firstName: user!.first_name,
    lastName: user!.last_name, company: "", address1: user.shipping_info.address_1, address2: user.shipping_info.address_2,
    city: user.shipping_info.city, state: user.shipping_info.state, postcode: user.shipping_info.postcode, country:user.shipping_info.country,
    email: user.email, phone: user.phone_number);
  }

  void updateShippingInfo(User? user) {
    this.cart?.shipping = Address(firstName: user!.first_name,
    lastName: user!.last_name, company: "", address1: user.shipping_info.address_1, address2: user.shipping_info.address_2,
    city: user.shipping_info.city, state: user.shipping_info.state, postcode: user.shipping_info.postcode, country:user.shipping_info.country,
    email: user.email, phone: user.phone_number);
  }
}
