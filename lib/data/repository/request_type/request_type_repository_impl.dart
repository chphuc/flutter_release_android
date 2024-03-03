import 'package:boilerplate/data/network/apis/request_type/request_type_api.dart';
import 'package:boilerplate/domain/entity/request_type/request_type.dart';
import 'package:boilerplate/domain/repository/request_type/processing_step_repository.dart';

class RequestTypeRepositoryImpl extends RequestTypeRepository {
  final RequestTypeApi _requestTypeApi;

  RequestTypeRepositoryImpl(this._requestTypeApi);

  @override
  Future<RequestType> getRequestTypes() async {
    return await _requestTypeApi.getRequestTypes().then((requestTypes) {
      return requestTypes;
    }).catchError((error) => throw error);
  }
}
