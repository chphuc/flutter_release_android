import 'package:boilerplate/data/network/apis/status_bar_request/request_status_api.dart';
import 'package:boilerplate/domain/entity/status_bar_request/status_bar_request_list.dart';
import 'package:boilerplate/domain/repository/status_bar_request/request_status_repository.dart';

class StatusBarRequestRepositoryImpl extends StatusBarRequestRepository {
  final StatusBarRequestApi _statusBarRequestApi;

  StatusBarRequestRepositoryImpl(this._statusBarRequestApi);

  @override
  Future<StatusBarRequestList> getStatusBarRequests() async {
    return await _statusBarRequestApi.getStatusBarRequests().then((statusBarRequest) {
      return statusBarRequest;
    }).catchError((error) => throw error);
  }
}
