import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/request/request_list.dart';
import 'package:boilerplate/domain/repository/request/request_repository.dart';

class GetRequestUseCase extends UseCase<RequestList, RequestListParams> {
  final RequestRepository _requestRepository;

  GetRequestUseCase(this._requestRepository);

  @override
  Future<RequestList> call({required RequestListParams params}) {
    return _requestRepository.getRequests(params);
  }
}
