import 'dart:async';

import 'package:boilerplate/domain/entity/request/request_list.dart';

abstract class RequestRepository {
  Future<RequestList> getRequests(RequestListParams params);
}

class RequestListParams {
  final String? ReqTypeName;
  final String? ReqCode;
  final String? StatusRack;
  final String? ProgressName;
  final String? Customer;
  final String? ReqUnitName;
  final String? ReceivingTimeMin;
  final String? ReceivingTimeMax;
  final String? ExecTimeMin;
  final String? ExecTimeMax;
  final int? SkipCount;
  final int MaxResultCount;
  final String? Sorting;

  RequestListParams({
    this.ReqTypeName,
    this.ReqCode,
    this.StatusRack,
    this.ProgressName,
    this.Customer,
    this.ReqUnitName,
    this.ReceivingTimeMin,
    this.ReceivingTimeMax,
    this.ExecTimeMin,
    this.ExecTimeMax,
    this.SkipCount,
    required this.MaxResultCount,
    this.Sorting,
  });

  Map<String, dynamic> toMap() {
    return {
      'ReqTypeName': ReqTypeName,
      'ReqCode': ReqCode,
      'StatusRack': StatusRack,
      'ProgressName': ProgressName,
      'Customer': Customer,
      'ReqUnitName': ReqUnitName,
      'ReceivingTimeMin': ReceivingTimeMin,
      'ReceivingTimeMax': ReceivingTimeMax,
      'ExecTimeMin': ExecTimeMin,
      'ExecTimeMax': ExecTimeMax,
      'SkipCount': SkipCount,
      'MaxResultCount': MaxResultCount,
      'Sorting': Sorting,
    }..removeWhere((key, value) => value == null);
  }
}
