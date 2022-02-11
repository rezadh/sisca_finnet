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
  List<Roles> roles;
  Login({this.username, this.email, this.firstName, this.lastName, this.accessToken, this.roles});

  Login.fromJson(Map<String, dynamic> object){
    username = object['user']['username'];
    email = object['user']['email'];
    firstName = object['user']['first_name'];
    lastName = object['user']['last_name'];
    accessToken = object['access_token'];
    if (object['roles'] != null) {
      roles = <Roles>[];
      object['roles'].forEach((v) {
        roles.add(new Roles.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user']['username'] = this.username;
    data['user']['email'] = this.email;
    data['user']['first_name'] = this.firstName;
    data['user']['last_name'] = this.lastName;
    data['access_token'] = this.accessToken;
    if (this.roles != null) {
      data['roles'] = this.roles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Roles {
  int isAssetHolder;
  Roles({this.isAssetHolder});

  Roles.fromJson(Map<String, dynamic> object){
    isAssetHolder = object['is_asset_holder'];

  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_asset_holder'] = this.isAssetHolder;
    return data;
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