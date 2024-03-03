import 'dart:async';

import 'package:boilerplate/domain/entity/request_type/request_type.dart';


abstract class RequestTypeRepository {
  Future<RequestType> getRequestTypes();
}
