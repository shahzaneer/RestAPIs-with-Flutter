import 'dart:convert';

import 'package:http/http.dart' as http;

class PostService {
  static var client = http.Client();

  static Future<Map<String, dynamic>> postData() async {
    var url = Uri.https("reqres.in", "/api/users");
    Map<String, String> requestHeaders = {"Content-Type": "application/json"};
    Map<String, dynamic> payloadToBeSent = {
      "name": "Shahzaneer",
      "job": "leader"
    };
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(payloadToBeSent),
    );
    var payload = jsonDecode(response.body);
    var kiaHua = response.reasonPhrase;
    var joHuaUskaStatusNumber = response.statusCode;
    print(kiaHua);
    print(joHuaUskaStatusNumber);

    return payload; // post main payload ki koi zarurat nhi hai as it is used for getting the data jbke hamara main maqsad hai k post hua k nhi!

    // generally post method will return boolean showing k post hua kay nhi hua!
  }
}

void main(List<String> args) async {
  Map<String, dynamic> payload = await PostService.postData();
  print(payload);
}



// !POST Request ->  client se server per data ko post krne k liay use hoti hai
// server resource body k against khud se ID assign krdeta hai hamain nhi krni perti