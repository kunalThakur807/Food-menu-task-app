import 'package:http/http.dart' as http;

class HttpService {
  static Future<bool> isImageAvailable(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> get({required String path}) async {
    try {
      final url = Uri.parse(path);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
}
