import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisca_finnet/model/pic_model.dart';
import 'package:sisca_finnet/util/const.dart';
import 'package:http/http.dart' as http;

class Data {
  DataBawah data;
  String id;
  String assetId;
  String name;
  String serialNumber;
  int amount;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String picId;
  String brandOrType;
  String startDate;
  int usefulLife;
  String evidence;
  String description;
  String employeeId;
  String qrCode;
  Pic pic;

  Data(
      {this.data,
      this.id,
      this.assetId,
      this.name,
      this.serialNumber,
      this.amount,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.picId,
      this.brandOrType,
      this.startDate,
      this.usefulLife,
      this.evidence,
      this.description,
      this.employeeId,
      this.qrCode,
      this.pic});

  Data.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DataBawah.fromJson(json['data']) : null;
    id = json['id'];
    assetId = json['asset_id'];
    name = json['name'];
    serialNumber = json['serial_number'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    picId = json['pic_id'];
    brandOrType = json['brand_or_type'];
    startDate = json['start_date'];
    usefulLife = json['useful_life'];
    evidence = json['evidence'];
    description = json['description'];
    employeeId = json['employee_id'];
    qrCode = json['qr_code'];
    pic = json['pic'] != null ? new Pic.fromJson(json['pic']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['id'] = this.id;
    data['asset_id'] = this.assetId;
    data['name'] = this.name;
    data['serial_number'] = this.serialNumber;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['pic_id'] = this.picId;
    data['brand_or_type'] = this.brandOrType;
    data['start_date'] = this.startDate;
    data['useful_life'] = this.usefulLife;
    data['evidence'] = this.evidence;
    data['description'] = this.description;
    data['employee_id'] = this.employeeId;
    data['qr_code'] = this.qrCode;
    if (this.pic != null) {
      data['pic'] = this.pic.toJson();
    }
    return data;
  }
}

class DataBawah {
  int currentPage;
  List<Asset> asset;
  List<Monitoring> monitoring;

  DataBawah({
    this.asset,
    this.monitoring,
  });

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
  String id;
  String name;
  String serialNumber;
  int currentBudget;
  int amount;

  Monitoring({this.id, this.name, this.serialNumber, this.currentBudget, this.amount});

  Monitoring.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    serialNumber = json['serial_number'];
    currentBudget = json['current_budget'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['serial_number'] = this.serialNumber;
    data['current_budget'] = this.currentBudget;
    data['amount'] = this.amount;
    return data;
  }

  bool isEqual(Monitoring model) {
    return this?.serialNumber == model?.serialNumber;
  }
}

class Asset {
  String name;
  String id;
  String procurement;
  String code;
  int amount;
  Pic pic;
  Data data;

  Asset({this.name,this.id, this.amount, this.procurement, this.code, this.pic, this.data});

  Asset.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    amount = json['amount'];
    procurement = json['procurement'];
    code = json['code'];
    pic = json['pic'] != null ? new Pic.fromJson(json['pic']) : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['procurement'] = this.procurement;
    data['code'] = this.code;
    if (this.pic != null) {
      data['pic'] = this.pic.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

Future<List<Asset>> getRequestAsset() async {
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

Future<List<Monitoring>> getRequestAssetMonitoring() async {
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

Future<List<Monitoring>> getRequestSearchAssetMonitoring(String search) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String url = BASE_URL + 'monitoring?per_page=-1&q=$search&appends[]=current_budget';
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
    print(responseJson);
    return daftar;
  } else {
    print(response.body);
    return null;
  }
}

Future<Asset> getRequestAssetDetail(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String url = BASE_URL + 'monitoring/$id?with[]=pic';
  var token = prefs.getString('token');
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  var response = await http.get(Uri.parse(url), headers: h);
  if (response.statusCode == 200) {
    print(response.body);
    // Map responseJson = json.decode(response.body)['data'];
    prefs.setInt('status_asset', response.statusCode);
    return Asset.fromJson(json.decode(response.body));
  } else {
    prefs.setInt('status_asset', response.statusCode);
    print(response.body);
    return null;
  }
}
