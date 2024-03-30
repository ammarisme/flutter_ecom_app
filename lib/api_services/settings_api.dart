import 'dart:convert';
import 'package:ecommerce_int2/api_services/api_service.dart';
import 'package:ecommerce_int2/common/utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


class SettingsAPI {
  static final base_url = 'http://erp.thesellerstack.com:3001/extension-app';

  static Future<dynamic> getSettings() async {
    try {
      final Uri url = Uri.parse(base_url + '/settings/1');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        final storage = FlutterSecureStorage();
        await storage.write(key: 'settings', value: data.toString());
        ApiService.
        
        set_configurations(data);
        return data;
      } else {
        Utils.log('Failed to load info: ${url} : ${response.statusCode}');
        return null;
      }
    } catch (e, stackTrace) {
      Utils.log('Error fetching cart: $e');
      Utils.log('Stack trace: $stackTrace');
      return null;
    }
  }
}
