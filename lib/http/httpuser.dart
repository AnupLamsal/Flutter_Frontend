import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class HttpConnectUser {
  static String baseurl = 'https://flutteranup.herokuapp.com/api/users';
  static String token = '';
  static String userId = '';

  //sending data to the server--- creating user
  static Future<bool> registerPost(User user) async {
    Map<String, dynamic> userMap = {
      "fullName": user.fullName,
      "email": user.email,
      "password": user.password,
    };

    final response = await post(Uri.parse(baseurl), body: userMap);
    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.statusCode);
      return false;
    }
  }

  //sending data to the server- login as user
  static Future loginPosts(String? email, String? password) async {
    Map<String, dynamic> loginStudent = {'email': email, 'password': password};

    try {
      final response = await post(
          Uri.parse(
            "https://flutteranup.herokuapp.com/api/auth",
          ),
          body: loginStudent);

      //json serializing inline
      final jsonData = jsonDecode(response.body) as Map;

      token = jsonData['token'];
      userId = jsonData['user']['_id'];

      return jsonData;
    } catch (e) {
      print('i am error');
      return null;
    }
  }
}
