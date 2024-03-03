import 'package:boilerplate/data/network/apis/request_information/request_information_api.dart';
import 'package:boilerplate/domain/entity/request_information/request_information.dart';
import 'package:boilerplate/domain/repository/request_information/request_information_repository.dart';

class RequestInformationRepositoryImpl extends RequestInformationRepository {
  final RequestInformationApi _requestInformationApi;

  RequestInformationRepositoryImpl(this._requestInformationApi);

  @override
  Future<RequestInformation> getRequestInformation(int idRequest) async {
    return await _requestInformationApi
        .getRequestInformation(idRequest)
        .then((requestInformations) {
      return requestInformations;
    }).catchError((error) => throw error);
  }
}
