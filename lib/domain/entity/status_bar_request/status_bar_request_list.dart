import 'dart:convert';

import 'package:boilerplate/domain/entity/status_bar_request/status_bar_request.dart';

class StatusBarRequestList {
  final List<StatusBarRequest> statusBarRequests;

  StatusBarRequestList({
    required this.statusBarRequests,
  });

  factory StatusBarRequestList.fromJson(dynamic json) {
    if (json is String) {
      // If the response is a string, try to decode it to a JSON object
      json = jsonDecode(json);
    }

    if (json is Map<String, dynamic>) {
      List<StatusBarRequest> statusBarRequests = (json['result'] as List)
          .map((item) => StatusBarRequest.fromJson(item))
          .toList();

      return StatusBarRequestList(statusBarRequests: statusBarRequests);
    } else {
      throw FormatException("Invalid response format");
    }
  }

  bool get isEmpty => statusBarRequests.isEmpty;

  int get length => statusBarRequests.length;

  StatusBarRequestList? add(StatusBarRequestList statusBarRequest) {}
}
