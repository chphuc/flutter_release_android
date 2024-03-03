import 'dart:async';

import 'package:boilerplate/domain/entity/status_bar_request/status_bar_request_list.dart';

abstract class StatusBarRequestRepository {
  Future<StatusBarRequestList> getStatusBarRequests();
}
