import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/request_information/request_information.dart';
import 'package:boilerplate/domain/repository/request_information/request_information_repository.dart';

class GetRequestInformationUseCase extends UseCase<RequestInformation, int> {
  final RequestInformationRepository _requestInformationRepository;

  GetRequestInformationUseCase(this._requestInformationRepository);

  @override
  Future<RequestInformation> call({required int params}) {
    return _requestInformationRepository.getRequestInformation(params);
  }
}
