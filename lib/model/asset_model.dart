import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisca_finnet/model/pic_model.dart';
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
  List<Asset> asset;
  List<Monitoring> monitoring;

  DataBawah({this.asset, this.monitoring});

  DataBawah.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      asset = <Asset>[];
      json['data'].forEach((v) {
        asset.add(new Asset.fromJson(v));
      });
    }
    if (json['data'] != null) {
      monitoring = <Monitoring>[];
      json['data'].forEach((v) {
        monitoring.add(new Monitoring.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.asset != null) {
      data['data'] = this.asset.map((v) => v.toJson()).toList();
    }
    if (this.monitoring != null) {
      data['data'] = this.monitoring.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Monitoring {
  String name;
  String serialNumber;
  int currentBudget;

  Monitoring({this.name, this.serialNumber, this.currentBudget});
  Monitoring.fromJson(Map<String, dynamic> json){
    name = json['name'];
    serialNumber = json['serial_number'];
    currentBudget = json['current_budget'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['serial_number'] = this.serialNumber;
    data['current_budget'] = this.currentBudget;
    return data;
  }
  bool isEqual(Monitoring model) {
    return this?.serialNumber == model?.serialNumber;
  }
}

class Asset {
  String name;
  String procurement;
  String code;
  int amount;
  Pic pic;

  Asset({this.name, this.amount, this.procurement, this.code, this.pic});

  Asset.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount = json['amount'];
    procurement = json['procurement'];
    code = json['code'];
    pic = json['pic'] != null ? new Pic.fromJson(json['pic']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['procurement'] = this.procurement;
    data['code'] = this.code;
    if (this.pic != null) {
      data['pic'] = this.pic.toJson();
    }
    return data;
  }
}

Future<List<Asset>> postRequestAsset() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String url = BASE_URL +
      'asset?page=1&per_page=500&with[]=latest_approval&with[]=pic&with[]=pic.user_position&with[]=latest_mutation.new_pic&appends[]=has_approval&is_project=0';
  var token = prefs.getString('token');
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  var response = await http.get(Uri.parse(url), headers: h);
  if (response.statusCode == 200) {
    print(response.reasonPhrase);
    Map responseJson = json.decode(response.body)['data'];
    List data = responseJson['data'];
    List<Asset> daftar = data.map((e) => Asset.fromJson(e)).toList();
    return daftar;
  } else {
    print(response.body);
    return null;
  }
}

Future<List<Monitoring>> postRequestAssetMonitoring() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String url = BASE_URL + 'monitoring?per_page=-1&appends[]=current_budget';
  var token = prefs.getString('token');
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  var response = await http.get(Uri.parse(url), headers: h);
  if (response.statusCode == 200) {
    print(response.reasonPhrase);
    Map responseJson = json.decode(response.body)['data'];
    List data = responseJson['data'];
    List<Monitoring> daftar = data.map((e) => Monitoring.fromJson(e)).toList();
    return daftar;
  } else {
    print(response.body);
    return null;
  }
}
