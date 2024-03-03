import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/status_bar_request/status_bar_request_list.dart';
import 'package:boilerplate/domain/repository/status_bar_request/request_status_repository.dart';

class GetStatusBarRequestUseCase extends UseCase<StatusBarRequestList, void> {
  final StatusBarRequestRepository _statusBarRequestRepository;

  GetStatusBarRequestUseCase(this._statusBarRequestRepository);

  @override
  Future<StatusBarRequestList> call({required params}) {
    return _statusBarRequestRepository.getStatusBarRequests();
  }
}
