import 'dart:async';

import 'package:boilerplate/domain/entity/request_status/request_status.dart';

abstract class RequestStatusRepository {
  Future<RequestStatus> getRequestStatuses();
}
