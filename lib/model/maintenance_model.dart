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
  String description;
  int requestedAmount;
  String requestEvidence;
  UserRequestedBy userRequestedBy;
  UserReviewedTo userReviewedTo;
  UserRequestedTo userRequestedTo;
  Status status;
  MonitoringMaintenance monitoringMaintenance;

  Maintenance(
      {this.id,
        this.description,
      this.requestedAmount,
      this.userRequestedBy,
        this.userReviewedTo,
        this.userRequestedTo,
      this.status,
      this.monitoringMaintenance, this.requestEvidence});

  Maintenance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['requested_description'];
    requestedAmount = json['requested_amount'];
    requestEvidence = json['requested_evidence'];
    userRequestedBy = json['user_requested_by'] != null
        ? new UserRequestedBy.fromJson(json['user_requested_by'])
        : null;
    userReviewedTo = json['user_reviewed_to'] != null
        ? new UserReviewedTo.fromJson(json['user_reviewed_to'])
        : null;
    userRequestedTo = json['user_requested_to'] != null
        ? new UserRequestedTo.fromJson(json['user_requested_to'])
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
    data['requested_description'] = this.description;
    data['requested_amount'] = this.requestedAmount;
    if (this.userRequestedBy != null) {
      data['user_requested_by'] = this.userRequestedBy.toJson();
    }
    if (this.userReviewedTo != null) {
      data['user_reviewed_to'] = this.userReviewedTo.toJson();
    }
    if (this.userReviewedTo != null) {
      data['user_requested_to'] = this.userReviewedTo.toJson();
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
class UserRequestedTo {
  String username;
  String avatar;
  String firstname;
  String lastname;
  String level;
  UserPosition userPosition;
  UserRequestedTo({this.username, this.avatar, this.firstname, this.lastname, this.level, this.userPosition});
  UserRequestedTo.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    avatar = json['avatar'];
    firstname = json['first_name'];
    lastname = json['last_name'];
    level = json['level'];
    userPosition = json['user_position'] != null
        ? new UserPosition.fromJson(json['user_position'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['first_name'] = this.firstname;
    data['last_name'] = this.lastname;
    data['level'] = this.level;
    return data;
  }
}
class UserReviewedTo {
  String username;
  String avatar;
  String firstname;
  String lastname;
  String level;
  UserPosition userPosition;
  UserReviewedTo({this.username, this.avatar, this.firstname, this.lastname, this.level, this.userPosition});
  UserReviewedTo.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    avatar = json['avatar'];
    firstname = json['first_name'];
    lastname = json['last_name'];
    level = json['level'];
    userPosition = json['user_position'] != null
        ? new UserPosition.fromJson(json['user_position'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['first_name'] = this.firstname;
    data['last_name'] = this.lastname;
    data['level'] = this.level;
    return data;
  }
}

class UserRequestedBy {
  String username;
  String avatar;
  String firstname;
  String lastname;
  String level;
  UserPosition userPosition;
  UserRequestedBy({this.username, this.avatar, this.firstname, this.lastname, this.level, this.userPosition});
  UserRequestedBy.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    avatar = json['avatar'];
    firstname = json['first_name'];
    lastname = json['last_name'];
    level = json['level'];
    userPosition = json['user_position'] != null
        ? new UserPosition.fromJson(json['user_position'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['first_name'] = this.firstname;
    data['last_name'] = this.lastname;
    data['level'] = this.level;
    return data;
  }
}
class UserPosition {
  String name;
  UserPosition({this.name});
  UserPosition.fromJson(Map<String, dynamic> json){
    name = json['name'];
  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
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
  String color;

  Status.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['color'] = this.color;
    return data;
  }
}

class PostMaintenance {
  String status;
  DataMaintenance data;

  PostMaintenance({this.status, this.data});

  PostMaintenance.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new DataMaintenance.fromJson(json['data']) : null;
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

class DataMaintenance {
  String monitoringId;
  String maintenanceOption;
  String requestedBy;
  String requestedAmount;
  String requestedDescription;
  String requestedLevelSnapshot;
  String requestedPositionIdSnapshot;
  String requestedEvidence;
  String reviewedTo;
  String requestedTo;
  String reviewedLevelSnapshot;
  String reviewedPositionIdSnapshot;
  String respondedLevelSnapshot;
  String respondedPositionIdSnapshot;
  String id;
  String updatedAt;
  String createdAt;
  StatusMaintenance status;
  UserCurrentProgress userRequestedBy;
  UserCurrentProgress userReviewedTo;

  DataMaintenance(
      {this.monitoringId,
        this.maintenanceOption,
        this.requestedBy,
        this.requestedAmount,
        this.requestedDescription,
        this.requestedLevelSnapshot,
        this.requestedPositionIdSnapshot,
        this.requestedEvidence,
        this.reviewedTo,
        this.requestedTo,
        this.reviewedLevelSnapshot,
        this.reviewedPositionIdSnapshot,
        this.respondedLevelSnapshot,
        this.respondedPositionIdSnapshot,
        this.id,
        this.updatedAt,
        this.createdAt,
        this.status,
        this.userRequestedBy,
        this.userReviewedTo});

  DataMaintenance.fromJson(Map<String, dynamic> json) {
    monitoringId = json['monitoring_id'];
    maintenanceOption = json['maintenance_option'];
    requestedBy = json['requested_by'];
    requestedAmount = json['requested_amount'];
    requestedDescription = json['requested_description'];
    requestedLevelSnapshot = json['requested_level_snapshot'];
    requestedPositionIdSnapshot = json['requested_position_id_snapshot'];
    requestedEvidence = json['requested_evidence'];
    reviewedTo = json['reviewed_to'];
    requestedTo = json['requested_to'];
    reviewedLevelSnapshot = json['reviewed_level_snapshot'];
    reviewedPositionIdSnapshot = json['reviewed_position_id_snapshot'];
    respondedLevelSnapshot = json['responded_level_snapshot'];
    respondedPositionIdSnapshot = json['responded_position_id_snapshot'];
    id = json['id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    status =
    json['status'] != null ? new StatusMaintenance.fromJson(json['status']) : null;
    userRequestedBy = json['user_requested_by'] != null
        ? new UserCurrentProgress.fromJson(json['user_requested_by'])
        : null;
    userReviewedTo = json['user_reviewed_to'] != null
        ? new UserCurrentProgress.fromJson(json['user_reviewed_to'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['monitoring_id'] = this.monitoringId;
    data['maintenance_option'] = this.maintenanceOption;
    data['requested_by'] = this.requestedBy;
    data['requested_amount'] = this.requestedAmount;
    data['requested_description'] = this.requestedDescription;
    data['requested_level_snapshot'] = this.requestedLevelSnapshot;
    data['requested_position_id_snapshot'] = this.requestedPositionIdSnapshot;
    data['requested_evidence'] = this.requestedEvidence;
    data['reviewed_to'] = this.reviewedTo;
    data['requested_to'] = this.requestedTo;
    data['reviewed_level_snapshot'] = this.reviewedLevelSnapshot;
    data['reviewed_position_id_snapshot'] = this.reviewedPositionIdSnapshot;
    data['responded_level_snapshot'] = this.respondedLevelSnapshot;
    data['responded_position_id_snapshot'] = this.respondedPositionIdSnapshot;
    data['id'] = this.id;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    if (this.userRequestedBy != null) {
      data['user_requested_by'] = this.userRequestedBy.toJson();
    }
    if (this.userReviewedTo != null) {
      data['user_reviewed_to'] = this.userReviewedTo.toJson();
    }
    return data;
  }
}

class StatusMaintenance {
  String name;
  String color;
  UserCurrentProgress userCurrentProgress;

  StatusMaintenance({this.name, this.color, this.userCurrentProgress});

  StatusMaintenance.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
    userCurrentProgress = json['user_current_progress'] != null
        ? new UserCurrentProgress.fromJson(json['user_current_progress'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['color'] = this.color;
    if (this.userCurrentProgress != null) {
      data['user_current_progress'] = this.userCurrentProgress.toJson();
    }
    return data;
  }
}

class UserCurrentProgress {
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

  UserCurrentProgress(
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

  UserCurrentProgress.fromJson(Map<String, dynamic> json) {
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
Future<List<Maintenance>> postRequestMaintenance() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String url = BASE_URL +
      'maintenances?page=1&per_page=50&is_requested=1&with[]=monitoring&with[]=user_requested_by.user_position&with[]=user_reviewed_to.user_position&with[]=user_requested_to&with[]=user_requested_to.user_position&with[]=monitoring.asset';
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

Future<PostMaintenance> postStoreMaintenance(Map body) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String url = BASE_URL + 'maintenances';
  var token = prefs.getString('token');
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.headers.addAll(h);
  request.fields['monitoring_id'] = body['monitoring_id'].toString();
  request.fields['requested_amount'] = body['requested_amount'].toString();
  request.fields['requested_description'] = body['requested_description'].toString();
  request.fields['maintenance_option'] = body['maintenance_option'].toString();
  request.fields['requested_to'] = body['requested_to'].toString();
  request.fields['reviewed_to'] = body['reviewed_to'].toString();
  request.files.add(
      await http.MultipartFile.fromPath('requested_evidence', body['requested_evidence']));
  var res = await request.send();
  var response = await http.Response.fromStream(res);
  if(response.statusCode == 200){
    print(response.body);
    return PostMaintenance.fromJson(json.decode(response.body));
  }else{
    print(response.body);
    return null;
  }
}
