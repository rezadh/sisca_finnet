import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisca_finnet/util/const.dart';
import 'package:http/http.dart' as http;

class Voucher {
  String status;
  Data data;

  Voucher({this.status, this.data});

  Voucher.fromJson(Map<String, dynamic> json) {
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
  int nextPageUrl;
  String path;
  String perPage;
  int prevPageUrl;
  int to;
  int total;
  String requestedBy;
  String requestedDescription;
  int requestedLevelSnapshot;
  String requestedPositionIdSnapshot;
  String reviewedTo;
  int reviewedLevelSnapshot;
  String reviewedPositionIdSnapshot;
  String requestedTo;
  String reviewedStatus;
  String reviewedAt;
  int respondedLevelSnapshot;
  String respondedPositionIdSnapshot;
  String id;
  String updatedAt;
  String createdAt;
  Status status;
  UserCurrentProgress userReviewedTo;
  UserCurrentProgress userRequestedTo;

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
      this.total,
      this.requestedBy,
      this.requestedDescription,
      this.requestedLevelSnapshot,
      this.requestedPositionIdSnapshot,
      this.reviewedTo,
      this.reviewedLevelSnapshot,
      this.reviewedPositionIdSnapshot,
      this.requestedTo,
      this.reviewedStatus,
      this.reviewedAt,
      this.respondedLevelSnapshot,
      this.respondedPositionIdSnapshot,
      this.id,
      this.updatedAt,
      this.createdAt,
      this.status,
      this.userReviewedTo,
      this.userRequestedTo});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    requestedBy = json['requested_by'];
    requestedDescription = json['requested_description'];
    requestedLevelSnapshot = json['requested_level_snapshot'];
    requestedPositionIdSnapshot = json['requested_position_id_snapshot'];
    reviewedTo = json['reviewed_to'];
    reviewedLevelSnapshot = json['reviewed_level_snapshot'];
    reviewedPositionIdSnapshot = json['reviewed_position_id_snapshot'];
    requestedTo = json['requested_to'];
    reviewedStatus = json['reviewed_status'];
    reviewedAt = json['reviewed_at'];
    respondedLevelSnapshot = json['responded_level_snapshot'];
    respondedPositionIdSnapshot = json['responded_position_id_snapshot'];
    id = json['id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    userReviewedTo = json['user_reviewed_to'] != null
        ? new UserCurrentProgress.fromJson(json['user_reviewed_to'])
        : null;
    userRequestedTo = json['user_requested_to'] != null
        ? new UserCurrentProgress.fromJson(json['user_requested_to'])
        : null;
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
    data['requested_by'] = this.requestedBy;
    data['requested_description'] = this.requestedDescription;
    data['requested_level_snapshot'] = this.requestedLevelSnapshot;
    data['requested_position_id_snapshot'] = this.requestedPositionIdSnapshot;
    data['reviewed_to'] = this.reviewedTo;
    data['reviewed_level_snapshot'] = this.reviewedLevelSnapshot;
    data['reviewed_position_id_snapshot'] = this.reviewedPositionIdSnapshot;
    data['requested_to'] = this.requestedTo;
    data['reviewed_status'] = this.reviewedStatus;
    data['reviewed_at'] = this.reviewedAt;
    data['responded_level_snapshot'] = this.respondedLevelSnapshot;
    data['responded_position_id_snapshot'] = this.respondedPositionIdSnapshot;
    data['id'] = this.id;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    if (this.userReviewedTo != null) {
      data['user_reviewed_to'] = this.userReviewedTo.toJson();
    }
    if (this.userRequestedTo != null) {
      data['user_requested_to'] = this.userRequestedTo.toJson();
    }
    return data;
  }
}

class DataBawahVoucher {
  String id;
  String voucherId;
  String requestedBy;
  String requestedTo;
  String requestedDescription;
  String reviewedTo;
  String reviewedStatus;
  String reviewedAt;
  String reviewedDescription;
  String respondedStatus;
  String respondedAt;
  String respondedDescription;
  String requestedPositionIdSnapshot;
  String requestedLevelSnapshot;
  String respondedPositionIdSnapshot;
  String respondedLevelSnapshot;
  String reviewedPositionIdSnapshot;
  String reviewedLevelSnapshot;
  String deletedAt;
  String createdAt;
  String updatedAt;
  Status status;
  VoucherData voucher;
  UserCurrentProgress userRequestedTo;
  UserCurrentProgress userRequestedBy;
  UserCurrentProgress userReviewedTo;

  DataBawahVoucher(
      {this.id,
      this.voucherId,
      this.requestedBy,
      this.requestedTo,
      this.requestedDescription,
      this.reviewedTo,
      this.reviewedStatus,
      this.reviewedAt,
      this.reviewedDescription,
      this.respondedStatus,
      this.respondedAt,
      this.respondedDescription,
      this.requestedPositionIdSnapshot,
      this.requestedLevelSnapshot,
      this.respondedPositionIdSnapshot,
      this.respondedLevelSnapshot,
      this.reviewedPositionIdSnapshot,
      this.reviewedLevelSnapshot,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.voucher,
      this.userRequestedTo,
      this.userRequestedBy,
      this.userReviewedTo});

  DataBawahVoucher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    voucherId = json['voucher_id'];
    requestedBy = json['requested_by'];
    requestedTo = json['requested_to'];
    requestedDescription = json['requested_description'];
    reviewedTo = json['reviewed_to'];
    reviewedStatus = json['reviewed_status'];
    reviewedAt = json['reviewed_at'];
    reviewedDescription = json['reviewed_description'];
    respondedStatus = json['responded_status'];
    respondedAt = json['responded_at'];
    respondedDescription = json['responded_description'];
    requestedPositionIdSnapshot = json['requested_position_id_snapshot'];
    requestedLevelSnapshot = json['requested_level_snapshot'];
    respondedPositionIdSnapshot = json['responded_position_id_snapshot'];
    respondedLevelSnapshot = json['responded_level_snapshot'];
    reviewedPositionIdSnapshot = json['reviewed_position_id_snapshot'];
    reviewedLevelSnapshot = json['reviewed_level_snapshot'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    voucher = json['voucher'] != null
        ? new VoucherData.fromJson(json['voucher'])
        : null;
    userRequestedTo = json['user_requested_to'] != null
        ? new UserCurrentProgress.fromJson(json['user_requested_to'])
        : null;
    userRequestedBy = json['user_requested_by'] != null
        ? new UserCurrentProgress.fromJson(json['user_requested_by'])
        : null;
    userReviewedTo = json['user_reviewed_to'] != null
        ? new UserCurrentProgress.fromJson(json['user_reviewed_to'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['voucher_id'] = this.voucherId;
    data['requested_by'] = this.requestedBy;
    data['requested_to'] = this.requestedTo;
    data['requested_description'] = this.requestedDescription;
    data['reviewed_to'] = this.reviewedTo;
    data['reviewed_status'] = this.reviewedStatus;
    data['reviewed_at'] = this.reviewedAt;
    data['reviewed_description'] = this.reviewedDescription;
    data['responded_status'] = this.respondedStatus;
    data['responded_at'] = this.respondedAt;
    data['responded_description'] = this.respondedDescription;
    data['requested_position_id_snapshot'] = this.requestedPositionIdSnapshot;
    data['requested_level_snapshot'] = this.requestedLevelSnapshot;
    data['responded_position_id_snapshot'] = this.respondedPositionIdSnapshot;
    data['responded_level_snapshot'] = this.respondedLevelSnapshot;
    data['reviewed_position_id_snapshot'] = this.reviewedPositionIdSnapshot;
    data['reviewed_level_snapshot'] = this.reviewedLevelSnapshot;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    if (this.voucher != null) {
      data['voucher'] = this.voucher.toJson();
    }
    if (this.userRequestedTo != null) {
      data['user_requested_to'] = this.userRequestedTo.toJson();
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

class Status {
  String name;
  String color;
  UserCurrentProgress userCurrentProgress;
  String currentResponse;

  Status(
      {this.name, this.color, this.userCurrentProgress, this.currentResponse});

  Status.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
    userCurrentProgress = json['user_current_progress'] != null
        ? new UserCurrentProgress.fromJson(json['user_current_progress'])
        : null;
    currentResponse = json['current_response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['color'] = this.color;
    if (this.userCurrentProgress != null) {
      data['user_current_progress'] = this.userCurrentProgress.toJson();
    }
    data['current_response'] = this.currentResponse;
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
  String avatar;
  String lastLoggedIn;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String positionId;
  int level;

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
      this.avatar,
      this.lastLoggedIn,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.positionId,
      this.level});

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
    avatar = json['avatar'];
    lastLoggedIn = json['last_logged_in'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    positionId = json['position_id'];
    level = json['level'];
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
    data['avatar'] = this.avatar;
    data['last_logged_in'] = this.lastLoggedIn;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['position_id'] = this.positionId;
    data['level'] = this.level;
    return data;
  }
}

class VoucherData {
  String id;
  String voucherCode;
  String voucherType;
  String description;
  int active;
  String createdBy;
  String createdAt;
  String updatedAt;
  String deletedAt;

  VoucherData(
      {this.id,
      this.voucherCode,
      this.voucherType,
      this.description,
      this.active,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  VoucherData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    voucherCode = json['voucher_code'];
    voucherType = json['voucher_type'];
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
    data['voucher_code'] = this.voucherCode;
    data['voucher_type'] = this.voucherType;
    data['description'] = this.description;
    data['active'] = this.active;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

Future<List<DataBawahVoucher>> getRequestVoucher() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String url = BASE_URL +
      'voucher-requests?page=1&per_page=500&q=&is_requester=1&with[]=voucher&with[]=user_requested_to&with[]=user_requested_by';
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
    List<DataBawahVoucher> daftar = data.map((e) => DataBawahVoucher.fromJson(e)).toList();
    return daftar;
  } else {
    print(response.body);
    return null;
  }
}

Future<Voucher> postRequestStoreVoucher(Map body) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String url = BASE_URL + 'voucher-requests';
  var token = prefs.getString('token');
  Map<String, String> h = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };
  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.headers.addAll(h);
  request.fields['requested_description'] = body['requested_description'].toString();
  if (body['requested_to'] != null) {
    request.fields['requested_to'] = body['requested_to'].toString();
  }
  if (body['reviewed_to'] != null) {
    request.fields['reviewed_to'] = body['reviewed_to'].toString();
  }
  var res = await request.send();
  var response = await http.Response.fromStream(res);
  if (response.statusCode == 200) {
    print(response.body);
    return Voucher.fromJson(json.decode(response.body));
  } else {
    print(response.body);
    return null;
  }
}
