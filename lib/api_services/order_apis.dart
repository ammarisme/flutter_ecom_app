import 'dart:convert';
import 'package:ecommerce_int2/api_services/api_service.dart';
import 'package:ecommerce_int2/models/api_response.dart';
import 'package:ecommerce_int2/models/order.dart';
import 'package:ecommerce_int2/settings.dart';
import 'package:http/http.dart' as http;

class OrderAPIs {
  static Future<APIResponse> getCustomerOrders(String customerId) async {
    try {
      final response = await http.get(
        Uri.parse(ApiService.base_url + '/wp-json/wc/v3'+
            '/orders?customer=${customerId}'), // Replace with your authentication endpoint
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Basic " + Settings.TOKEN,
        },
      );

      if (response.statusCode == 200) {
        APIResponse payload = APIResponse();
        List<dynamic> responseBody = json.decode(response.body);
        List<Order> orders = [];
        responseBody.forEach((item) {
          final Order order = Order.fromJson(item);
          orders.add(order);
        });
        payload.result = orders;
        payload.status = true;

        // TODO: If you want to save the data in local storageSaving data
        // final storage = FlutterSecureStorage();
        // await storage.write(key: '//change this', value: response.body);

        return payload;
      } else {
        // Handle error cases here
        APIResponse apiResponse = APIResponse();
        apiResponse.error_message =
            'Error : ${json.decode(response.body)["message"]}';
        apiResponse.status = false;
        return apiResponse;
      }
    } catch (ex) {
      print(ex);
      APIResponse apiResponse = APIResponse();
      apiResponse.error_message = 'Error : ${ex}';
      apiResponse.status = false;
      return apiResponse;
    }
  }


static Future<APIResponse> calculateOrderInfo(data) async {
    try {

    final response = await http.post(
      Uri.parse('http://erp.thesellerstack.com:3001/test'), // Replace with your authentication endpoint
      // body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
      },
      body:json.encode(data)
    );
    print(json.encode(data));
  
  
      if (response.statusCode == 201) {
        APIResponse payload = APIResponse();
        payload.result = json.decode(response.body);;
        payload.status = true;

        return payload;
      } else {
        // Handle error cases here
        APIResponse apiResponse = APIResponse();
        apiResponse.error_message =
            'Error : ${json.decode(response.body)}';
        apiResponse.status = false;
        return apiResponse;
      }
    } catch (ex) {
      print(ex);
      APIResponse apiResponse = APIResponse();
      apiResponse.error_message = 'Error : ${ex}';
      apiResponse.status = false;
      return apiResponse;
    }
}
}