import 'dart:convert';
import 'package:http/http.dart' as http;

class APIService {
  static var client = http.Client();

  static Future<bool> login(String email, String password) async {
    Map<String, String> requestHeaders = {"Content-Type": "application/json"};
    var url = Uri.https("reqres.in", "/api/login");

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {"email": email, "password": password},
      ),
    );

    if (response.statusCode == 200) {
      print(response.body);

      return true;
    } else {
      return false;
    }
  }
}

void main(List<String> args) {
  APIService.login("eve.holt@reqres.in", "password").then((value) {
    print(value);
  });
}
