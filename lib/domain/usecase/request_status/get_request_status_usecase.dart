import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/request_status/request_status.dart';
import 'package:boilerplate/domain/repository/request_status/request_status_repository.dart';

class GetRequestStatusUseCase extends UseCase<RequestStatus, void> {
  final RequestStatusRepository _requestStatusRepository;

  GetRequestStatusUseCase(this._requestStatusRepository);

  @override
  Future<RequestStatus> call({required params}) {
    return _requestStatusRepository.getRequestStatuses();
  }
}
