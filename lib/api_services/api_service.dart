import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../models/user.dart';
import '../settings.dart';



//API service
class ApiService {
  // class Variables
  static String base_url = '';
  static String store_url = '';
  static String smsservice_url = "";
  static String sms_sender_id = "";
  static String sms_api_key = '';
  static String sms_user_id = '' ;
  static String main_carousal_category = "";
  static String main_carousal_title = "";

  static set_configurations(settings) async {
    base_url = '${settings["app_data"]["website_url"]}';
    store_url = '${settings["app_data"]["store_url"]}';
    smsservice_url = '${settings["app_data"]["smsservice_url"]}';
    sms_sender_id = '${settings["app_data"]["sms_sender_id"]}';
    sms_api_key = '${settings["app_data"]["sms_api_key"]}';
    sms_user_id = '${settings["app_data"]["sms_user_id"]}';
    main_carousal_category = '${settings["app_data"]["main_carousal_category"]}';
    main_carousal_title = '${settings["app_data"]["main_carousal_title"]}';
  }

  static Future<List<Product>> getProducts(dynamic categoryId) async {
    print('fetching products........');
    try {
      final Uri url = Uri.parse(base_url + '/products?category=$categoryId');

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Basic "+ Settings.TOKEN
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Product> products =
            data.map((item) => Product.fromJson(item)).toList();
        return products;
      } else {
        print('Failed to load products: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  static Future<List<User>> getUsers({int nrUsers = 1}) async {
    try {
      final response = await http.get(
          //TODO flutter 2 migration
          Uri(
            path: ApiService.base_url+ '/wp-json/wc/v3'+ '/customers',
          ),
          headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        Map data = json.decode(response.body);
        Iterable list = data["results"];
        List<User> users = list.map((l) => User.fromJson(l)).toList();
        return users;
      } else {
        // print(response.body);
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
