import 'dart:async';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/domain/entity/processing_step/processing_step.dart';

class ProcessingStepApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  ProcessingStepApi(this._dioClient, this._restClient);

  Future<ProcessingStep> getProcessingSteps() async {
    try {
      final res = await _dioClient.dio.get(Endpoints.getProcessingSteps);
      return ProcessingStep.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
