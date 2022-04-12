class Pic {
  String firstName;
  String lastName;
  String department;
  String level;
  String avatar;
  String id;
  String code;
  String username;
  String email;
  String address;
  String jobTitle;
  String division;
  String lastLoggedIn;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String positionId;

  Pic({
    this.firstName,
    this.lastName,
    this.department,
    this.level,
    this.avatar,
    this.id,
    this.code,
    this.username,
    this.email,
    this.address,
    this.jobTitle,
    this.division,
    this.lastLoggedIn,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.positionId,
  });

  Pic.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    department = json['department'];
    level = json['level'].toString();
    avatar = json['avatar'];
    id = json['id'];
    code = json['code'];
    username = json['username'];
    email = json['email'];
    address = json['address'];
    jobTitle = json['job_title'];
    division = json['division'];
    lastLoggedIn = json['last_logged_in'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    positionId = json['position_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['department'] = this.department;
    data['level'] = this.level;
    data['avatar'] = this.avatar;
    data['id'] = this.id;
    data['code'] = this.code;
    data['username'] = this.username;
    data['email'] = this.email;
    data['address'] = this.address;
    data['job_title'] = this.jobTitle;
    data['division'] = this.division;
    data['last_logged_in'] = this.lastLoggedIn;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['position_id'] = this.positionId;
    return data;
  }
}
