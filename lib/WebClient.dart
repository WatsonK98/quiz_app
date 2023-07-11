import 'package:http/http.dart' as http;
import 'dart:convert';

class WebClient{
  dynamic url;

  WebClient(this.url);

  Future validateLogin() async{
    var response = await http.get(Uri.parse(url));
    var decoded = json.decode(response.body);
    return Future.delayed(const Duration(milliseconds: 50), () => decoded);
  }
}