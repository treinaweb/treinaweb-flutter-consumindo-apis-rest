
import 'dart:convert';
import 'package:http/http.dart' as http;

class RestUtil {
  static String urlBase = 'http://10.0.2.2:5000/';

  static Future<http.Response> addData(String uri, Map<String, Object> data) async {
    final response = await http.post(
    Uri.http(urlBase, uri),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8'
        },
      body: jsonEncode(data),
    );
    return response;
  }

}