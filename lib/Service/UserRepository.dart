import 'dart:convert';

import 'AuthRepository.dart';
import "package:http/http.dart" as http;

class User {
  String username;
  String bio;

  User({this.username, this.bio});

  factory User.fromJson(Map<String, dynamic> json) => User(
      username : json['username'],
      bio :json['bio']
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['bio'] = this.bio;
    return data;
  }
  User copyWith({
    String username,
    String bio,
  }) {
    return User(
      username: username ?? this.username,
      bio: bio  ?? this.bio,
    );
  }
}

class UserRepository {
  static final String mainUrl = "10.0.2.2:5000";

  Future<User> getUserDetails() async {
    String token = await AuthService.getToken();
    http.Response response = await http.get(
      Uri.http(mainUrl, "/api/userdetails"),
      headers: {
        "Accept": "application/json",
        "x-access-token": token,
      },
    );
    Map<String, dynamic> responseJson = jsonDecode(response.body);
    print(responseJson);
    User user;
    if (response.statusCode == 200) {
       user = User.fromJson(responseJson);
    }
    return user;
  }

  void updateUserBio(String newBio) async {
    print("RECEIVED NEW BIO: " + newBio);
    String token = await AuthService.getToken();
    http.Response response = await http.post(
        Uri.http(mainUrl, "/api/userdetails"),
        headers: {
          "Accept": "application/json",
          "x-access-token": token,
        },
        body: jsonEncode({"bio": newBio}),
    );
    print(response.statusCode);
  }

}
