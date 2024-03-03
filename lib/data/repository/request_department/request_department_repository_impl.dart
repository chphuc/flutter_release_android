import 'package:boilerplate/data/network/apis/request_department/request_department_api.dart';
import 'package:boilerplate/domain/entity/request_department/request_department.dart';
import 'package:boilerplate/domain/repository/request_department/request_department_repository.dart';

class RequestDepartmentRepositoryImpl extends RequestDepartmentRepository {
  final RequestDepartmentApi _requestDepartmentApi;

  RequestDepartmentRepositoryImpl(this._requestDepartmentApi);

  @override
  Future<RequestDepartment> getRequestDepartments() async {
    return await _requestDepartmentApi
        .getRequestDepartments()
        .then((requestDepartments) {
      return requestDepartments;
    }).catchError((error) => throw error);
  }
}
