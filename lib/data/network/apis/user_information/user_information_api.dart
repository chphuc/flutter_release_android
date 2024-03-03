import 'dart:async';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/domain/entity/user_information/user_information.dart';

class UserInformationApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  UserInformationApi(this._dioClient, this._restClient);

  Future<UserInformation> getUserInformation() async {
    try {
      // final res = await _dioClient.dio.get(Endpoints.getUserInformation);
      final res = await _dioClient.dio.get(Endpoints.getUserInformation);
      return UserInformation.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
