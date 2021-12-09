import 'dart:async';
import 'package:http/http.dart' as http;

class NumberApi {
  static Future getNumbers() {
    return http.get(Uri.parse("https://csrng.net/csrng/csrng.php?min=1&max=100"));
  }
}