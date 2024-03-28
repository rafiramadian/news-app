import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpService {
  static const String _apiKey = "c174e707dd834ad2859ebeedd14a0df4";
  static const String _baseUrl = "https://newsapi.org/v2/";

  // HTTP get method
  Future<Map<String, dynamic>> get(String path) async {
    try {
      final response =
          await http.get(Uri.parse('$_baseUrl$path&apiKey=$_apiKey'));

      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  // Handler for response
  Future<Map<String, dynamic>> _handleResponse(http.Response response) async {
    final Map<String, dynamic> responseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      if (responseBody['status'] == 'error') {
        // Handle error response
        throw Exception(
            'Server Error ${responseBody['code']}: ${responseBody['message']}');
      } else {
        // Successful response
        return responseBody;
      }
    } else {
      // Handle error response
      throw Exception(
          'HTTP ${response.statusCode}: ${responseBody['message']}');
    }
  }
}
