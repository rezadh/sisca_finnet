import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisca_finnet/util/const.dart';
import 'package:http/http.dart' as http;

class Opname {
  String status;
  Data data;

  Opname({this.status, this.data});

  Opname.fromJson(Map<String, dynamic> json) {
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
  int currentPage;
  List<Data> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  String perPage;
  String prevPageUrl;
  int to;
  int total;

  Data(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class DataBawahOpname {
  String id;
  String checkedBy;
  String conditionId;
  String description;
  String deletedAt;
  String createdAt;
  String updatedAt;
  String monitoringId;
  MonitoringOpname monitoring;
  Condition condition;

  DataBawahOpname(
      {this.id,
      this.checkedBy,
      this.conditionId,
      this.description,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.monitoringId,
      this.monitoring,
      this.condition});

  DataBawahOpname.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checkedBy = json['checked_by'];
    conditionId = json['condition_id'];
    description = json['description'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    monitoringId = json['monitoring_id'];
    monitoring = json['monitoring'] != null
        ? new MonitoringOpname.fromJson(json['monitoring'])
        : null;
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['checked_by'] = this.checkedBy;
    data['condition_id'] = this.conditionId;
    data['description'] = this.description;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['monitoring_id'] = this.monitoringId;
    if (this.monitoring != null) {
      data['monitoring'] = this.monitoring.toJson();
    }
    if (this.condition != null) {
      data['condition'] = this.condition.toJson();
    }
    return data;
  }
}

class MonitoringOpname {
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

  MonitoringOpname(
      {this.id,
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
      this.employeeId});

  MonitoringOpname.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    return data;
  }
}

class Condition {
  String id;
  String code;
  String name;
  String description;
  String color;
  String createdBy;
  String deletedAt;
  String createdAt;
  String updatedAt;

  Condition(
      {this.id,
      this.code,
      this.name,
      this.description,
      this.color,
      this.createdBy,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Condition.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    color = json['color'];
    createdBy = json['created_by'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  bool isEqual(Condition model) {
    return this?.id == model?.id;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['description'] = this.description;
    data['color'] = this.color;
    data['created_by'] = this.createdBy;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

Future<List<DataBawahOpname>> getRequestOpname() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String url = BASE_URL +
      'opname?page=1&per_page=500&opname=&with[]=monitoring&with[]=condition';
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
    List<DataBawahOpname> daftar =
        data.map((e) => DataBawahOpname.fromJson(e)).toList();
    return daftar;
  } else {
    print(response.body);
    return null;
  }
}

Future<List<Condition>> getRequestCondition() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String url = BASE_URL + 'condition';
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
    List<Condition> daftar = data.map((e) => Condition.fromJson(e)).toList();
    return daftar;
  } else {
    print(response.body);
    return null;
  }
}

Future<Condition> postRequestOpname(Map body) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String url = BASE_URL + 'opname';
  var token = prefs.getString('token');
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.headers.addAll(h);
  request.fields['monitoring_id'] = body['monitoring_id'].toString();
  request.fields['condition_id'] = body['condition_id'].toString();
  request.fields['description'] = body['description'].toString();
  var res = await request.send();
  var response = await http.Response.fromStream(res);
  if (response.statusCode == 200) {
    print(response.body);
    return Condition.fromJson(json.decode(response.body));
  } else {
    print(response.body);
    return null;
  }
}
