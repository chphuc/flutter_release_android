import 'package:boilerplate/data/network/apis/processing_step/processing_step_api.dart';
import 'package:boilerplate/domain/entity/processing_step/processing_step.dart';
import 'package:boilerplate/domain/repository/processing_step/processing_step_repository.dart';

class ProcessingStepRepositoryImpl extends ProcessingStepRepository {
  final ProcessingStepApi _processingStepApi;

  ProcessingStepRepositoryImpl(this._processingStepApi);

  @override
  Future<ProcessingStep> getProcessingSteps() async {
    return await _processingStepApi.getProcessingSteps().then((processingStep) {
      return processingStep;
    }).catchError((error) => throw error);
  }
}
