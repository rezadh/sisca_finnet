class Pic {
  String firstName;
  String lastName;
  String department;
  String level;
  String avatar;

  Pic(
      {
        this.firstName,
        this.lastName,
        this.department,
        this.level,
        this.avatar,
      });

  Pic.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    department = json['department'];
    level = json['level'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['department'] = this.department;
    data['level'] = this.level;
    data['avatar'] = this.avatar;
    return data;
  }
}