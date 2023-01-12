import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisca_finnet/util/const.dart';
import 'package:http/http.dart' as http;

class TripVehicle {
  String status;
  DataAtasTripVehicle data;

  TripVehicle({this.status, this.data});

  TripVehicle.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new DataAtasTripVehicle.fromJson(json['data']) : null;
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

class DataAtasTripVehicle {
  int currentPage;
  List<DataBawahTripVehicle> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to;
  int total;

  DataAtasTripVehicle(
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

  DataAtasTripVehicle.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DataBawahTripVehicle>[];
      json['data'].forEach((v) {
        data.add(new DataBawahTripVehicle.fromJson(v));
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

class DataBawahTripVehicle {
  String id;
  String vehicleCode;
  String vehicleType;
  String vehicleName;
  String vehicleDescription;
  int active;
  String createdAt;
  String updatedAt;
  String deletedAt;
  bool isEqual(DataBawahTripVehicle model) {
    return this?.vehicleName == model?.vehicleName;
  }
  DataBawahTripVehicle(
      {this.id,
        this.vehicleCode,
        this.vehicleType,
        this.vehicleName,
        this.vehicleDescription,
        this.active,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  DataBawahTripVehicle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleCode = json['vehicle_code'];
    vehicleType = json['vehicle_type'];
    vehicleName = json['vehicle_name'];
    vehicleDescription = json['vehicle_description'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vehicle_code'] = this.vehicleCode;
    data['vehicle_type'] = this.vehicleType;
    data['vehicle_name'] = this.vehicleName;
    data['vehicle_description'] = this.vehicleDescription;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
Future<List<DataBawahTripVehicle>> getRequestTripVehicle() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String url = BASE_URL + 'trips?per_page=-1';
  var token = prefs.getString('token');
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  var response = await http.get(Uri.parse(url), headers: h);
  if (response.statusCode == 200) {
    Map responseJson = json.decode(response.body)['data'];
    List data = responseJson['data'];
    List<DataBawahTripVehicle> daftar = data.map((e) => DataBawahTripVehicle.fromJson(e)).toList();
    print(data);
    return daftar;
  } else {
    print(response.body);
    return null;
  }
}