import 'package:boilerplate/core/widgets/droplistdown_widget.dart';

class RequestStatus {
  List<String> data;

  RequestStatus({
    required this.data,
  });

  factory RequestStatus.fromJson(Map<String, dynamic> json) {
    List<String> jsonData = List<String>.from(json['result'] ?? []);

    return RequestStatus(data: jsonData);
  }

  map(DropdownItem Function(dynamic item) param0) {}
}
