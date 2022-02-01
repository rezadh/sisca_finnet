import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisca_finnet/util/const.dart';
import 'package:http/http.dart' as http;
class Login {
  String username;
  String email;
  String firstName;
  String lastName;
  String accessToken;
  Login({this.username, this.email, this.firstName, this.lastName, this.accessToken});

  Login.fromJson(Map<String, dynamic> object){
    username = object['user']['username'];
    email = object['user']['email'];
    firstName = object['user']['first_name'];
    lastName = object['user']['last_name'];
    accessToken = object['access_token'];
  }
}
Future<Login> postRequestLogin(String method, String username, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String url = BASE_URL + 'login';
  Map<String, String> h = {
    'Content-Type': 'application/json',
  };
  Map body = {'method': method, 'username': username, 'password': password};
  print(body);
  var response = await http.post(Uri.parse(url), headers: h, body: json.encode(body));
  if(response.statusCode == 200){
    var token = json.decode(response.body)['access_token'];
    prefs.setString('token', token);
    return Login.fromJson(json.decode(response.body));
  } else {
    print(response.body);
    return null;
  }
}