class UserInformation {
  String userName;
  String name;
  String surname;
  String role;
  String department;
  String emailAddress;

  UserInformation({
    required this.userName,
    required this.name,
    required this.surname,
    required this.role,
    required this.department,
    required this.emailAddress,
  });

  factory UserInformation.fromJson(Map<String, dynamic> json) {
    return UserInformation(
      userName: json['result']['userName'] ?? '',
      name: json['result']['name'] ?? '',
      surname: json['result']['surname'] ?? '',
      role: json['result']['roles'][0]['roleName'] ?? '',
      department: json['result']['department'] ?? '',
      emailAddress: json['result']['emailAddress'] ?? '',
    );
  }
}
