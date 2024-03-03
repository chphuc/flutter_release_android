class StatusBarRequest {
  String statusRack;
  int count;

  StatusBarRequest({
    required this.statusRack,
    required this.count,
  });

  factory StatusBarRequest.fromJson(Map<String, dynamic> json) {
    return StatusBarRequest(
      statusRack: json['statusRack'] ?? '',
      count: json['count'] ?? 0,
    );
  }
}
