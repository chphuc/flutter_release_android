
import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/request_type/request_type.dart';
import 'package:boilerplate/domain/repository/request_type/processing_step_repository.dart';

class GetRequestTypeUseCase extends UseCase<RequestType, void> {
  final RequestTypeRepository _requestTypeRepository;

  GetRequestTypeUseCase(this._requestTypeRepository);

  @override
  Future<RequestType> call({required params}) {
    return _requestTypeRepository.getRequestTypes();
  }
}
