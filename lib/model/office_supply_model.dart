import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisca_finnet/util/const.dart';
import 'package:http/http.dart' as http;
class OfficeSupplyRequest {
  String status;
  Data data;

  OfficeSupplyRequest({this.status, this.data});

  OfficeSupplyRequest.fromJson(Map<String, dynamic> json) {
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

class DataBawahOfficeSupply {
  String id;
  String officeSupplyName;
  String officeSupplyDescription;
  String officeSupplyQuantity;
  String requestedBy;
  String reviewedTo;
  String requestedDescription;
  String respondedStatus;
  String respondedAt;
  String respondedDescription;
  String requestedPositionIdSnapshot;
  String requestedLevelSnapshot;
  String respondedPositionIdSnapshot;
  String respondedLevelSnapshot;
  String deletedAt;
  String createdAt;
  String updatedAt;
  String officeSupplyId;
  UserRequestedTo userRequestedTo;
  OfficeSupply officeSupply;
  Status status;

  DataBawahOfficeSupply(
      {this.id,
        this.officeSupplyName,
        this.officeSupplyDescription,
        this.officeSupplyQuantity,
        this.requestedBy,
        this.reviewedTo,
        this.requestedDescription,
        this.respondedStatus,
        this.respondedAt,
        this.respondedDescription,
        this.requestedPositionIdSnapshot,
        this.requestedLevelSnapshot,
        this.respondedPositionIdSnapshot,
        this.respondedLevelSnapshot,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.officeSupplyId,
        this.userRequestedTo,
        this.officeSupply});

  DataBawahOfficeSupply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    officeSupplyName = json['office_supply_name'];
    officeSupplyDescription = json['office_supply_description'];
    officeSupplyQuantity = json['office_supply_quantity'];
    requestedBy = json['requested_by'];
    reviewedTo = json['reviewed_to'];
    requestedDescription = json['requested_description'];
    respondedStatus = json['responded_status'];
    respondedAt = json['responded_at'];
    respondedDescription = json['responded_description'];
    requestedPositionIdSnapshot = json['requested_position_id_snapshot'];
    requestedLevelSnapshot = json['requested_level_snapshot'];
    respondedPositionIdSnapshot = json['responded_position_id_snapshot'];
    respondedLevelSnapshot = json['responded_level_snapshot'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    officeSupplyId = json['office_supply_id'].toString();
    status = json['status'] != null ? new Status.fromJson(json['status']) : null;
    userRequestedTo = json['user_requested_to'] != null
        ? new UserRequestedTo.fromJson(json['user_requested_to'])
        : null;
    officeSupply = json['office_supply'] != null
        ? new OfficeSupply.fromJson(json['office_supply'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['office_supply_name'] = this.officeSupplyName;
    data['office_supply_description'] = this.officeSupplyDescription;
    data['office_supply_quantity'] = this.officeSupplyQuantity;
    data['requested_by'] = this.requestedBy;
    data['reviewed_to'] = this.reviewedTo;
    data['requested_description'] = this.requestedDescription;
    data['responded_status'] = this.respondedStatus;
    data['responded_at'] = this.respondedAt;
    data['responded_description'] = this.respondedDescription;
    data['requested_position_id_snapshot'] = this.requestedPositionIdSnapshot;
    data['requested_level_snapshot'] = this.requestedLevelSnapshot;
    data['responded_position_id_snapshot'] = this.respondedPositionIdSnapshot;
    data['responded_level_snapshot'] = this.respondedLevelSnapshot;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['office_supply_id'] = this.officeSupplyId;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    if (this.userRequestedTo != null) {
      data['user_requested_to'] = this.userRequestedTo.toJson();
    }
    if (this.officeSupply != null) {
      data['office_supply'] = this.officeSupply.toJson();
    }
    return data;
  }
}

class UserRequestedTo {
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

  UserRequestedTo(
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

  UserRequestedTo.fromJson(Map<String, dynamic> json) {
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

class OfficeSupply {
  String id;
  String code;
  String name;
  String description;
  int active;
  String createdBy;
  String createdAt;
  String updatedAt;
  String deletedAt;

  OfficeSupply(
      {this.id,
        this.code,
        this.name,
        this.description,
        this.active,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  OfficeSupply.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    active = json['active'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['description'] = this.description;
    data['active'] = this.active;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class OfficeSupplyAsset {
  String id;
  String code;
  String name;
  String description;
  int active;
  String createdBy;
  String createdAt;
  String updatedAt;
  bool isEqual(OfficeSupplyAsset model) {
    return this?.name == model?.name;
  }
  OfficeSupplyAsset(
      {this.id,
        this.code,
        this.name,
        this.description,
        this.active,
        this.createdBy,
        this.createdAt,
        this.updatedAt});

  OfficeSupplyAsset.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    active = json['active'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['description'] = this.description;
    data['active'] = this.active;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class Status {
  String name;
  String color;
  UserCurrentProgress userCurrentProgress;

  Status({this.name, this.color, this.userCurrentProgress});

  Status.fromJson(Map<String, dynamic> json) {
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
  UserPositionStatus userPositionStatus;

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
        this.positionId,
        this.userPositionStatus});

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
    userPositionStatus = json['user_position'] != null
        ? new UserPositionStatus.fromJson(json['user_position'])
        : null;
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
    if (this.userPositionStatus != null) {
      data['user_position'] = this.userPositionStatus.toJson();
    }
    return data;
  }
}
class UserPositionStatus {
  String id;
  String code;
  String name;
  String divisionId;
  String deletedAt;
  String createdAt;
  String updatedAt;

  UserPositionStatus(
      {this.id,
        this.code,
        this.name,
        this.divisionId,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  UserPositionStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    divisionId = json['division_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['division_id'] = this.divisionId;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
Future<List<OfficeSupplyAsset>> getRequestAssetOfficeSupply() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String url = BASE_URL +
      'office-supplies?per_page=-1&name=&is_available=1';
  var token = prefs.getString('token');
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  var response = await http.get(Uri.parse(url), headers: h);
  if (response.statusCode == 200) {
    Map responseJson = json.decode(response.body)['data'];
    List data = responseJson['data'];
    List<OfficeSupplyAsset> daftar = data.map((e) => OfficeSupplyAsset.fromJson(e)).toList();
    return daftar;
  } else {
    print(response.body);
    return null;
  }
}
Future<List<DataBawahOfficeSupply>> getRequestOfficeSupply() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String url = BASE_URL +
      'office-supply-requests?page=1&per_page=500&is_requester=1&with[]=user_reviewed_to.user_position&with[]=office_supply';
  var token = prefs.getString('token');
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  var response = await http.get(Uri.parse(url), headers: h);
  if (response.statusCode == 200) {
    Map responseJson = json.decode(response.body)['data'];
    List data = responseJson['data'];
    List<DataBawahOfficeSupply> daftar = data.map((e) => DataBawahOfficeSupply.fromJson(e)).toList();
    return daftar;
  } else {
    print(response.body);
    return null;
  }
}
Future<OfficeSupplyRequest> postRequestOfficeSupply(Map body) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String url = BASE_URL + 'office-supply-requests';
  var token = prefs.getString('token');
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.headers.addAll(h);
  request.fields['office_supply_description'] = body['office_supply_description'].toString();
  request.fields['office_supply_quantity'] = body['office_supply_quantity'].toString();
  request.fields['office_supply_id'] = body['office_supply_id'].toString();

  if (body['reviewed_to'] != null) {
    request.fields['reviewed_to'] = body['reviewed_to'].toString();
  }
  var res = await request.send();
  var response = await http.Response.fromStream(res);
  if (response.statusCode == 200) {
    print(response.body);
    return OfficeSupplyRequest.fromJson(json.decode(response.body));
  } else {
    print(response.body);
    return null;
  }
}