import 'dart:convert';
import 'package:api_app/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static var client = http.Client();

  //! Getting users
  static Future<User?> getUsers() async {
    var getUrl = Uri.https("reqres.in", "api/users");
    var response = await client.get(getUrl);
    var data = jsonDecode(response.body);
    

    if (response.statusCode == 200) {
      return User.fromJson(data);
    } else {
      return null;
    }
  }
}

void main(List<String> args) async {
  var users = await ApiService.getUsers();

  for (var person in users!.data!) {
    print(person.avatar);
  }
}
