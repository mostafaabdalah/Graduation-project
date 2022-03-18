import 'package:http/http.dart' as http;
import 'dart:convert';

class FormService {
  void addProduct(product) {
    String url = 'https://hommey-b9aa6.firebaseio.com/products.json';
    http.post(url, body: json.encode(product));
  }
}
