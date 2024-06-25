import 'package:http/http.dart' as http;
import 'export.dart';

class CallApi {

  setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  getDataNoToken(apiUrl) async {
    try {
      String fullUrl = Environment.apiUrl + apiUrl;
      return await http.get(Uri.parse(fullUrl),headers: setHeaders(),).timeout(const Duration(seconds : 30));
    } catch (e) {
      return false;
    }
  }

  postData(data, apiUrl) async {
    try {
      var fullUrl = Environment.apiUrl + apiUrl;
      return await http.post(Uri.parse(fullUrl),body: jsonEncode(data),headers: setHeaders()).timeout(const Duration(seconds : 30));
    } catch (e) {
      return false;
    }
  }

  putData(data, apiUrl) async {
    try {
      var fullUrl = Environment.apiUrl + apiUrl;
      return await http.put(Uri.parse(fullUrl),body: jsonEncode(data),headers: setHeaders()).timeout(const Duration(seconds : 30));
    } catch (e) {
      return false;
    }
  }
}