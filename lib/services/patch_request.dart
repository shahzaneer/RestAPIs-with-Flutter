import 'dart:convert';

import 'package:http/http.dart' as http;

class PatchService {
  static var client = http.Client();

  static Future<void> patchRequest() async {
    var url = Uri.https("reqres.in", "/api/users/2");
    Map<String, String> requestHeaders = {"Content-Type": "application/json"};
    var responseSpecificPartToBeUpdated = {
      "name": "morpheus",
      "job": "pesident"
    };
    var response = await client.patch(url,
        headers: requestHeaders,
        body: jsonEncode(responseSpecificPartToBeUpdated));

    print(response.statusCode);
    print(response.reasonPhrase);
    print(response.body);
  }
}

void main(List<String> args) {
  PatchService.patchRequest();
}


// !Patch Request -> it is used to update some of the parts of the resource not the complete resource
// ! Patch vs Put -> put pure resource ko change krdeta hai , patch resource k kisi hissay ko
// put is idempotent (aik request karen ya zyada same effect)
// patch may or may not be idempotent ✔