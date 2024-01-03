import 'package:flutter/material.dart';

part 'user.g.dart';

class User {
  int id;
  String email;
  String first_name;
  String last_name;
  String role;
  String username;
  BillingInfo billing_info;
  ShippingInfo shipping_info;
  String avatar_url; //default "https://secure.gravatar.com/avatar/6e03d506a025da41a09b785c3f6fb70c?s=96&d=mm&r=g",
  String phone_number;

  User({
    required this.id,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.role,
    required this.username,
    required this.billing_info,
    required this.shipping_info,
    required this.avatar_url,
    required this.phone_number
  });

//   // "meta_data": [
//   // {
//   // "id": 30841,
//   // "key": "phone_number",
//   // "value": "94716060123"
//   // }
// }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

class BillingInfo extends Info {
  String company;
  String email;
  String phone;
  String first_name; 
  String last_name;
  String address_1;
  String address_2;
  String city;
  String postcode;
  String country;
  String state;

  BillingInfo({
    required this.company,
    required this.email,
    required this.phone,
    required this.first_name,
    required this.last_name,
    required this.address_1,
    required this.address_2,
    required this.city,
    required this.postcode,
    required this.country,
    required this.state,
  });
}

class ShippingInfo {
  get address_1 => null;

}

class Info{
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