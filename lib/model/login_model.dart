import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisca_finnet/util/const.dart';
import 'package:http/http.dart' as http;
class Login {
  User user;
  String accessToken;
  String tokenType;
  String expiresAt;
  List<Roles> roles;
  List<Permissions> permissions;
  Settings settings;

  Login(
      {this.user,
        this.accessToken,
        this.tokenType,
        this.expiresAt,
        this.roles,
        this.permissions,
        this.settings});

  Login.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresAt = json['expires_at'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles.add(new Roles.fromJson(v));
      });
    }
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions.add(new Permissions.fromJson(v));
      });
    }
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_at'] = this.expiresAt;
    if (this.roles != null) {
      data['roles'] = this.roles.map((v) => v.toJson()).toList();
    }
    if (this.permissions != null) {
      data['permissions'] = this.permissions.map((v) => v.toJson()).toList();
    }
    if (this.settings != null) {
      data['settings'] = this.settings.toJson();
    }
    return data;
  }
}

class User {
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
  List<Roles> roles;
  UserPosition userPosition;

  User(
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
        this.roles,
        this.userPosition});

  User.fromJson(Map<String, dynamic> json) {
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
    level = json['level'].toString();
    avatar = json['avatar'];
    lastLoggedIn = json['last_logged_in'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    positionId = json['position_id'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles.add(new Roles.fromJson(v));
      });
    }

    userPosition = json['user_position'] != null
        ? new UserPosition.fromJson(json['user_position'])
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
    if (this.roles != null) {
      data['roles'] = this.roles.map((v) => v.toJson()).toList();
    }
    if (this.userPosition != null) {
      data['user_position'] = this.userPosition.toJson();
    }
    return data;
  }
}

class Roles {
  int id;
  String name;
  String guardName;
  String description;
  String createdAt;
  String updatedAt;
  int isAssetHolder;
  Pivot pivot;
  List<Permissions> permissions;

  Roles(
      {this.id,
        this.name,
        this.guardName,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.isAssetHolder,
        this.pivot,
        this.permissions});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    guardName = json['guard_name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isAssetHolder = json['is_asset_holder'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions.add(new Permissions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['guard_name'] = this.guardName;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_asset_holder'] = this.isAssetHolder;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    if (this.permissions != null) {
      data['permissions'] = this.permissions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pivot {
  int modelId;
  int roleId;
  String modelType;

  Pivot({this.modelId, this.roleId, this.modelType});

  Pivot.fromJson(Map<String, dynamic> json) {
    modelId = json['model_id'];
    roleId = json['role_id'];
    modelType = json['model_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model_id'] = this.modelId;
    data['role_id'] = this.roleId;
    data['model_type'] = this.modelType;
    return data;
  }
}

class Permissions {
  int id;
  String name;
  String guardName;
  String createdAt;
  String updatedAt;
  Pivot pivot;

  Permissions(
      {this.id,
        this.name,
        this.guardName,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  Permissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    guardName = json['guard_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['guard_name'] = this.guardName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}


class UserPosition {
  String id;
  String code;
  String name;
  String divisionId;
  String deletedAt;
  String createdAt;
  String updatedAt;
  UserDivision userDivision;

  UserPosition(
      {this.id,
        this.code,
        this.name,
        this.divisionId,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.userDivision});

  UserPosition.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    divisionId = json['division_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userDivision = json['user_division'] != null
        ? new UserDivision.fromJson(json['user_division'])
        : null;
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
    if (this.userDivision != null) {
      data['user_division'] = this.userDivision.toJson();
    }
    return data;
  }
}

class UserDivision {
  String id;
  String code;
  String name;
  String directorateId;
  String deletedAt;
  String createdAt;
  String updatedAt;
  UserDirectorate userDirectorate;

  UserDivision(
      {this.id,
        this.code,
        this.name,
        this.directorateId,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.userDirectorate});

  UserDivision.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    directorateId = json['directorate_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userDirectorate = json['user_directorate'] != null
        ? new UserDirectorate.fromJson(json['user_directorate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['directorate_id'] = this.directorateId;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.userDirectorate != null) {
      data['user_directorate'] = this.userDirectorate.toJson();
    }
    return data;
  }
}

class UserDirectorate {
  String id;
  String code;
  String name;
  String deletedAt;
  String createdAt;
  String updatedAt;

  UserDirectorate(
      {this.id,
        this.code,
        this.name,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  UserDirectorate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}


class Settings {
  General general;

  Settings({this.general});

  Settings.fromJson(Map<String, dynamic> json) {
    general =
    json['general'] != null ? new General.fromJson(json['general']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.general != null) {
      data['general'] = this.general.toJson();
    }
    return data;
  }
}

class General {
  String logo;
  String currency;
  DateFormat dateFormat;

  General({this.logo, this.currency, this.dateFormat});

  General.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    currency = json['currency'];
    dateFormat = json['date-format'] != null
        ? new DateFormat.fromJson(json['date-format'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logo'] = this.logo;
    data['currency'] = this.currency;
    if (this.dateFormat != null) {
      data['date-format'] = this.dateFormat.toJson();
    }
    return data;
  }
}

class DateFormat {
  String primary;
  String secondary;

  DateFormat({this.primary, this.secondary});

  DateFormat.fromJson(Map<String, dynamic> json) {
    primary = json['primary'];
    secondary = json['secondary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['primary'] = this.primary;
    data['secondary'] = this.secondary;
    return data;
  }
}
Future<Login> postRequestLogin(String method, String username, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String url = BASE_URL + 'login';
  Map<String, String> h = {
    'Content-Type': 'application/json',
  };
  Map body = {'method': method, 'username': username, 'password': password};
  print(body);
  var response = await http.post(Uri.parse(url), headers: h, body: json.encode(body));
  if(response.statusCode == 200){
    var token = json.decode(response.body)['access_token'];
    prefs.setString('token', token);
    return Login.fromJson(json.decode(response.body));
  } else {
    print(response.body);
    return null;
  }
}