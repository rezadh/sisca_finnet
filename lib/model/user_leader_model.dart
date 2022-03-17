import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisca_finnet/util/const.dart';
import 'package:http/http.dart' as http;

class Data {
  DataBawah data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DataBawah.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class DataBawah {
  int currentPage;
  List<UserLeader> userLeader;

  DataBawah({this.userLeader});

  DataBawah.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      userLeader = <UserLeader>[];
      json['data'].forEach((v) {
        userLeader.add(new UserLeader.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.userLeader != null) {
      data['data'] = this.userLeader.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserLeader {
  String id;
  String username;
  String firstName;
  String lastName;
  int level;
  String avatar;
  UserPosition userPosition;

  bool isEqual(UserLeader model) {
    return this?.username == model?.username;
  }

  UserLeader(
      {this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.level,
      this.avatar,
      this.userPosition});

  UserLeader.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    level = json['level'];
    avatar = json['avatar'];
    userPosition = json['user_position'] != null
        ? new UserPosition.fromJson(json['user_position'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['level'] = this.level;
    data['avatar'] = this.avatar;
    if (this.userPosition != null) {
      data['user_position'] = this.userPosition.toJson();
    }
    return data;
  }
}

class UserPosition {
  String name;

  UserPosition({this.name});

  UserPosition.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

Future<List<UserLeader>> postRequestUserLeader() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String url = BASE_URL +
      'user?per_page=-1&is_leaders=1&is_logistic=0&with[]=user_position';
  var token = prefs.getString('token');
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  var response = await http.get(Uri.parse(url), headers: h);
  if (response.statusCode == 200) {
    Map responseJson = json.decode(response.body)['data'];
    List data = responseJson['data'];
    List<UserLeader> daftar = data.map((e) => UserLeader.fromJson(e)).toList();
    return daftar;
  } else {
    print(response.body);
    return null;
  }
}
