import 'package:boilerplate/data/network/apis/request/request_api.dart';
import 'package:boilerplate/domain/entity/request/request_list.dart';
import 'package:boilerplate/domain/repository/request/request_repository.dart';

class RequestRepositoryImpl extends RequestRepository {
  final RequestApi _requestApi;

  RequestRepositoryImpl(this._requestApi);

  @override
  Future<RequestList> getRequests(RequestListParams params) async {
    return await _requestApi.getRequests(params).then((requests) {
      return requests;
    }).catchError((error) => throw error);
  }
}
