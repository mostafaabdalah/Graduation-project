import 'package:http/http.dart' as http;
import 'dart:convert';

class SignIn {
  void addNewUser(data) {
    String url = 'https://hommey-b9aa6.firebaseio.com/user.json';
    http.post(url, body: json.encode(data));
  }

  void addLoginUser(login) {
    String url = 'https://hommey-b9aa6.firebaseio.com/Login.json';
    http.post(url, body: json.encode(login));
  }
}

