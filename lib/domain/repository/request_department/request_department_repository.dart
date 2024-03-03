import 'dart:async';

import 'package:boilerplate/domain/entity/request_department/request_department.dart';

abstract class RequestDepartmentRepository {
  Future<RequestDepartment> getRequestDepartments();
}
