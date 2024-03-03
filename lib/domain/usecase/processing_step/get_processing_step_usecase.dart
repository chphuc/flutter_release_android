import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/processing_step/processing_step.dart';
import 'package:boilerplate/domain/repository/processing_step/processing_step_repository.dart';

class GetProcessingStepUseCase extends UseCase<ProcessingStep, void> {
  final ProcessingStepRepository _userInformationRepository;

  GetProcessingStepUseCase(this._userInformationRepository);

  @override
  Future<ProcessingStep> call({required params}) {
    return _userInformationRepository.getProcessingSteps();
  }
}
