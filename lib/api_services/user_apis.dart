import 'dart:convert';
import 'package:ecommerce_int2/api_services/api_service.dart';
import 'package:ecommerce_int2/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../settings.dart';

class UserAPIs{

  static Future<User?> getUser(String id) async {
    print('fetching user........');
    try {
      final Uri url = Uri.parse(Variables.base_url + '/customers/${id}');

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization" : "Basic "+Settings.TOKEN
        },
      );

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        User user =  User.fromJson(data);

        final storage = FlutterSecureStorage();
        await storage.write(key: 'user', value: response.body);
        await storage.write(key: "last_logged_in_user", value: user.first_name);

        return user;
      } else {
        print('Failed to fetch user info: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

}
