import 'dart:convert';

import 'package:boilerplate/domain/entity/request/request.dart';

class RequestList {
  final List<Request> requests;

  RequestList({
    required this.requests,
  });

  factory RequestList.fromJson(dynamic json) {
    if (json is String) {
      // If the response is a string, try to decode it to a JSON object
      json = jsonDecode(json);
    }

    if (json is Map<String, dynamic>) {
      List<Request> requests = (json['result']['items'] as List)
          .map((item) => Request.fromJson(item))
          .toList();

      return RequestList(requests: requests);
    } else {
      throw FormatException("Invalid response format");
    }
  }

  bool get isEmpty => requests.isEmpty;

  Object? get length => null;

  RequestList? addAll(RequestList requests) {}
}
