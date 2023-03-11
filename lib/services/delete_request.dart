import 'package:http/http.dart' as http;

class DeleteService {
  static Future<void> deleteRequest() async {
    var url = Uri.https("reqres.in", "/api/users/2");
    var requestHeaders = {"Content-Type": "application/json"};
    var response = await http.delete(url, headers: requestHeaders);

    print(response.body);
    print(response.headers);
    print(response.reasonPhrase);
    print(response.request);
  }
}

void main(List<String> args) {
  DeleteService.deleteRequest();
}
