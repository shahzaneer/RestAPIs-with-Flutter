import 'dart:convert';

import 'package:http/http.dart' as http;

class PutService {
  static var client = http.Client();

  static Future<void> putRequest() async {
    var url = Uri.https("reqres.in", "/api/users/2");
    Map<String, String> requestHeaders = {"Content-Type": "application/json"};
    Map<String, dynamic> resourceToBeUpdated = {
      "name": "Shahzaneer Ahmed",
      "job": "President"
    };
    var response = await client.put(url,
        headers: requestHeaders, body: jsonEncode(resourceToBeUpdated));

    print(response.statusCode);
    print(response.body);
  }
}

void main(List<String> args) {
  PutService.putRequest();
}


// ! Put Request -> yeh aik resource ko update krdeti hai 
// it is idempotent yani aik baar request kren ya multiple baar aik hi resource k against changes hongi
