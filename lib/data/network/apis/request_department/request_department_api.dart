import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/domain/entity/request_department/request_department.dart';

class RequestDepartmentApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  RequestDepartmentApi(this._dioClient, this._restClient);

  Future<RequestDepartment> getRequestDepartments() async {
    try {
      final res = await _dioClient.dio.get(Endpoints.getRequestDepartments);
      return RequestDepartment.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
