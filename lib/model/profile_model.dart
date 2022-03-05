import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisca_finnet/util/const.dart';
import 'package:http/http.dart' as http;

class Profile {
  String status;
  Data data;

  Profile({this.status, this.data});

  Profile.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String id;
  String code;
  String username;
  String email;
  String firstName;
  String lastName;
  String address;
  String jobTitle;
  String department;
  String division;
  String level;
  String avatar;
  String lastLoggedIn;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String positionId;

  Data(
      {this.id,
        this.code,
        this.username,
        this.email,
        this.firstName,
        this.lastName,
        this.address,
        this.jobTitle,
        this.department,
        this.division,
        this.level,
        this.avatar,
        this.lastLoggedIn,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.positionId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    username = json['username'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    address = json['address'];
    jobTitle = json['job_title'];
    department = json['department'];
    division = json['division'];
    level = json['level'];
    avatar = json['avatar'];
    lastLoggedIn = json['last_logged_in'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    positionId = json['position_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['username'] = this.username;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['address'] = this.address;
    data['job_title'] = this.jobTitle;
    data['department'] = this.department;
    data['division'] = this.division;
    data['level'] = this.level;
    data['avatar'] = this.avatar;
    data['last_logged_in'] = this.lastLoggedIn;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['position_id'] = this.positionId;
    return data;
  }
}
Future<Profile> getRequestProfile() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String url = BASE_URL + 'profile';
  var token = prefs.getString('token');
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  var response = await http.get(Uri.parse(url), headers: h);
  if (response.statusCode == 200) {
    print(response.body);
    return Profile.fromJson(json.decode(response.body));
  } else {
    print(response.body);
    return null;
  }
}
Future<Profile> postRequestProfile(Map body) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String url = BASE_URL + 'profile';
  var token = prefs.getString('token');
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.headers.addAll(h);
  request.fields['username'] = body['username'].toString();
  request.fields['code'] = body['code'].toString();
  request.fields['email'] = body['email'].toString();
  request.fields['first_name'] = body['first_name'].toString();
  request.fields['last_name'] = body['last_name'].toString();
  request.fields['address'] = body['address'].toString();
  print('ini ${body['avatar']}');
  if(body['avatar'] != null){
    request.files.add(
        await http.MultipartFile.fromPath('avatar', body['avatar']));
  }
  var res = await request.send();
  var response = await http.Response.fromStream(res);
  if(response.statusCode == 200){
    print(response.body);
    return Profile.fromJson(json.decode(response.body));
  }else{
    print(response.body);
    return null;
  }
}