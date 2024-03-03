import 'dart:async';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/domain/entity/request/request_list.dart';
import 'package:boilerplate/domain/repository/request/request_repository.dart';

class RequestApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  RequestApi(this._dioClient, this._restClient);

  Future<RequestList> getRequests(RequestListParams params) async {
    try {
      final res = await _dioClient.dio.get(
        Endpoints.getRequests,
        queryParameters: params.toMap(),
      );
      return RequestList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
