import 'dart:async';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/domain/entity/status_bar_request/status_bar_request_list.dart';

class StatusBarRequestApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  StatusBarRequestApi(this._dioClient, this._restClient);

  Future<StatusBarRequestList> getStatusBarRequests() async {
    try {
      final res = await _dioClient.dio.get(Endpoints.getStatusBarRequest);
      return StatusBarRequestList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
