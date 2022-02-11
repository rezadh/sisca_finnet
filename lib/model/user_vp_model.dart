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
  List<UserVp> userVp;

  DataBawah({this.userVp});

  DataBawah.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      userVp = <UserVp>[];
      json['data'].forEach((v) {
        userVp.add(new UserVp.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.userVp != null) {
      data['data'] = this.userVp.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserVp {
  String username;
  String firstName;
  String lastName;
  String level;
  String avatar;
  UserPosition userPosition;

  bool isEqual(UserVp model) {
    return this?.username == model?.username;
  }

  UserVp(
      {this.username,
        this.firstName,
        this.lastName,
        this.level,
        this.avatar,
        this.userPosition});

  UserVp.fromJson(Map<String, dynamic> json) {
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

Future<List<UserVp>> postRequestUserVp() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String url = BASE_URL +
      'user?per_page=-1&is_vps=1&is_logistic=0&with[]=user_position';
  var token = prefs.getString('token');
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  var response = await http.get(Uri.parse(url), headers: h);
  if (response.statusCode == 200) {
    Map responseJson = json.decode(response.body)['data'];
    List data = responseJson['data'];
    List<UserVp> daftar = data.map((e) => UserVp.fromJson(e)).toList();
    return daftar;
  } else {
    print(response.body);
    return null;
  }
}
