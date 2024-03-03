import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/domain/entity/request_information/request_information.dart';

class RequestInformationApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  RequestInformationApi(this._dioClient, this._restClient);

  Future<RequestInformation> getRequestInformation(int idRequest) async {
    try {
      final res = await _dioClient.dio.get(
        Endpoints.getRequestInformation,
        queryParameters: {'id': idRequest},
      );
      return RequestInformation.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
