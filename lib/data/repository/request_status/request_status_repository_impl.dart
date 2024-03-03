import 'package:boilerplate/data/network/apis/request_status/request_status_api.dart';
import 'package:boilerplate/domain/entity/request_status/request_status.dart';
import 'package:boilerplate/domain/repository/request_status/request_status_repository.dart';

class RequestStatusRepositoryImpl extends RequestStatusRepository {
  final RequestStatusApi _requestStatusApi;

  RequestStatusRepositoryImpl(this._requestStatusApi);

  @override
  Future<RequestStatus> getRequestStatuses() async {
    return await _requestStatusApi
        .getRequestStatuses()
        .then((requestStatuses) {
      return requestStatuses;
    }).catchError((error) => throw error);
  }
}
