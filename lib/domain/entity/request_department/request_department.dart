class RequestDepartment {
  List<String> data;

  RequestDepartment({
    required this.data,
  });

  factory RequestDepartment.fromJson(Map<String, dynamic> json) {
    List<String> jsonData = List<String>.from(json['result'] ?? []);

    return RequestDepartment(data: jsonData);
  }
}
