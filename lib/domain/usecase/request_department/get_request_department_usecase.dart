import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/request_department/request_department.dart';
import 'package:boilerplate/domain/repository/request_department/request_department_repository.dart';

class GetRequestDepartmentUseCase extends UseCase<RequestDepartment, void> {
  final RequestDepartmentRepository _requestDepartmentRepository;

  GetRequestDepartmentUseCase(this._requestDepartmentRepository);

  @override
  Future<RequestDepartment> call({required params}) {
    return _requestDepartmentRepository.getRequestDepartments();
  }
}
