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
  List<Maintenance> maintenance;

  DataBawah({this.currentPage, this.maintenance});

  DataBawah.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      maintenance = <Maintenance>[];
      json['data'].forEach((v) {
        maintenance.add(new Maintenance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.maintenance != null) {
      data['data'] = this.maintenance.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Maintenance {
  String id;
  int requestedAmount;
  UserRequestedBy userRequestedBy;
  Status status;
  MonitoringMaintenance monitoringMaintenance;

  Maintenance(
      {this.id,
      this.requestedAmount,
      this.userRequestedBy,
      this.status,
      this.monitoringMaintenance});

  Maintenance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestedAmount = json['requested_amount'];

    userRequestedBy = json['user_requested_by'] != null
        ? new UserRequestedBy.fromJson(json['user_requested_by'])
        : null;
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    monitoringMaintenance = json['monitoring'] != null
        ? new MonitoringMaintenance.fromJson(json['monitoring'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['requested_amount'] = this.requestedAmount;
    if (this.userRequestedBy != null) {
      data['user_requested_by'] = this.userRequestedBy.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    if (this.monitoringMaintenance != null) {
      data['monitoring'] = this.monitoringMaintenance.toJson();
    }
    return data;
  }
}

class UserRequestedBy {
  String username;

  UserRequestedBy.fromJson(Map<String, dynamic> json) {
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    return data;
  }
}

class MonitoringMaintenance {
  String name;
  String serialNumber;

  MonitoringMaintenance.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    serialNumber = json['serial_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['serial_number'] = this.serialNumber;
    return data;
  }
}

class Status {
  String name;

  Status.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

Future<List<Maintenance>> postRequestMaintenance() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String url = BASE_URL +
      'maintenances?page=1&per_page=50&is_requested=1&with[]=monitoring&with[]=user_requested_by&with[]=user_requested_by.user_position&with[]=user_requested_to&with[]=user_requested_to.user_position&with[]=monitoring.asset';
  var token = prefs.getString('token');
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  var response = await http.get(Uri.parse(url), headers: h);
  if (response.statusCode == 200) {
    Map responseJson = json.decode(response.body)['data'];
    List data = responseJson['data'];
    List<Maintenance> daftar =
        data.map((e) => Maintenance.fromJson(e)).toList();
    return daftar;
  } else {
    print(response.body);
    return null;
  }
}
