// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  final billing_info = BillingInfo(
      company: json["billing"]["company"],
      state: json["billing"]["state"],
      email: json["billing"]["email"],
      first_name: json["billing"]["first_name"],
      phone: json["billing"]["phone"],
      last_name: json["billing"]["last_name"],
      address_1: json["billing"]["address_1"],
      address_2: json["billing"]["address_2"],
      city: json["billing"]["city"],
      postcode: json["billing"]["postcode"],
      country: json["billing"]["country"]);

       final shipping_info = ShippingInfo(
      address_1: json["shipping"]["address_1"],
      address_2: json["shipping"]["address_2"],
   );


 

  User user = User(
      id: json["id"],
      email: json["email"],
      first_name: json["first_name"],
      last_name: json["last_name"],
      role: json["role"],
      username: json["username"],
      avatar_url: json["avatar_url"],
      billing_info: billing_info,
      shipping_info: shipping_info,
      phone_number: "");
  user.billing_info = billing_info;
  return user;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'first_name': instance.first_name,
      'phone_number': instance.phone_number,
      'email': instance.email,
      // 'phone': instance.phone,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      "username" : instance.phone_number,
      'shipping' : instance.shipping_info!= null ? {
        'address_1' : instance.shipping_info.address_1,
        'address_2' : instance.shipping_info.address_2,
        "city" : instance.shipping_info.city,
        "state" : instance.shipping_info.state,
      }: {
        'address_1' : "",
        'address_2' : ""
      },

      // 'address_1': instance.address_1,
      // 'address_2': instance.address_2,
      // 'city': instance.city,
      // 'postcode': instance.postcode,
      // 'country': instance.country,
      // 'state': instance.state
      'password':instance.password
    };
