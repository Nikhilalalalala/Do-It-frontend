import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static String mainUrl = "10.0.2.2:5000";
  var loginUrl = '$mainUrl/api/auth';

  static final FlutterSecureStorage storage = new FlutterSecureStorage();

  Future<bool> hasToken() async {
    String value = await storage.read(key: 'token');
    print("in Has token");
    print(value);
    print(value.length);
    if (value != null || value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<void> persistToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    storage.delete(key: 'token');
    storage.deleteAll();
  }

  Future<String> login(String username, String password) async {
    http.Response response = await http.post(
      Uri.http(mainUrl, "/api/auth"),
      headers: {"Accept": "application/json"},
      body: jsonEncode(<String,String>
        {
          "username": username,
          "password": password
        }),
    );
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    print("Token upon login: " + responseJson.toString());
    return responseJson['token'];
    // return "token";
  }
}

