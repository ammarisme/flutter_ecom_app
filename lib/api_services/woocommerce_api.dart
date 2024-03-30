import 'package:ecommerce_int2/api_services/api_service.dart';
import 'package:flutter_wp_woocommerce/woocommerce.dart';

class WoocommerceAPI {
  static final String WRITE_API_KEY = 'ck_b7e55e17cce8d13b050c82e7b85fdef8935a3ac7';
  static final String WRITE_API_SECRET = "cs_94fcd8419be83fe3afc0cee2f8dc610ee0a535f2";
  static final String BASE_URL = ApiService.base_url;
  
  static WooCommerce woocommerce = WooCommerce(
    baseUrl: BASE_URL,
    consumerKey: WRITE_API_KEY,
    consumerSecret: WRITE_API_SECRET);

  
}
