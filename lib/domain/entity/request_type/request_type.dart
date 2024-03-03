class RequestType {
  List<String> data;

  RequestType({
    required this.data,
  });

  factory RequestType.fromJson(Map<String, dynamic> json) {
    List<String> jsonData = List<String>.from(json['result'] ?? []);

    return RequestType(data: jsonData);
  }
}
