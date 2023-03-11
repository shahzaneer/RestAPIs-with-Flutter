import 'package:http/http.dart' as http;

// HTTP ->

class ApiService {
  static var client = http
      .Client(); // !http k through client ka access point banaya hai aur static isliay banaya hai takay without object creation access kia jasakay!

  static Future<dynamic> getUsers() async {
    Map<String, String> requestHeaders = {"Content-Type": "application/json"};
    // var url = Uri.http(authority)
    var url = Uri.https("reqres.in", "/api/users");

    // var response = await client.get(url, headers: requestHeaders);
        var response = await client.get(url);


    if (response.statusCode == 200) {
      // print(response.body.runtimeType);
      // print(response.runtimeType); // response ki type response hai
      // print(response);

      // print("The response Header ->  ${response.headers} AND THE TYPE /n ${response.headers.runtimeType}");
      // print(
      // "The response body ->  ${response.body} AND THE TYPE /n ${response.body.runtimeType}");
      // print("The response bodyBytes ->  ${response.bodyBytes} AND THE TYPE /n ${response.bodyBytes.runtimeType}");
      //   print(
      // "The response content Length  ->  ${response.contentLength} AND THE TYPE /n ${response.contentLength.runtimeType}");
      // print(response.reasonPhrase!); // status code ka reason phrase like 200 k against tou `OK` hota hai
      // print(response.persistentConnection);
      print(response.statusCode);
    } else {
      return null;
    }
  }


  
}


void main(List<String> args) {
  ApiService.getUsers();
}
