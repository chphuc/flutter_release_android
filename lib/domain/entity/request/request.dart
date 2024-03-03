class Request {
  int id;
  String reqCode;
  String status;
  String reqTypeName;
  String customer;
  String progressName;
  String execTime;
  String requiredCompletionTime;
  bool displayPeriod;

  Request({
    required this.id,
    required this.reqCode,
    required this.status,
    required this.reqTypeName,
    required this.customer,
    required this.progressName,
    required this.execTime,
    required this.requiredCompletionTime,
    required this.displayPeriod,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['id'] ?? 0,
      reqCode: json['reqCode'] ?? '',
      status: json['statusName'] ?? '',
      reqTypeName: json['reqTypeName'] ?? '',
      customer: json['customer'] ?? '',
      progressName: json['progressName'] ?? '',
      execTime: json['execTime'] ?? '',
      requiredCompletionTime: json['requiredCompletionTime'] ?? '',
      displayPeriod: json['displayPeriod'] ?? false,
    );
  }
}
