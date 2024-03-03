import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/domain/entity/request_status/request_status.dart';

class RequestStatusApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  RequestStatusApi(this._dioClient, this._restClient);

  Future<RequestStatus> getRequestStatuses() async {
    try {
      final res = await _dioClient.dio.get(Endpoints.getRequestStatuses);
      return RequestStatus.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
