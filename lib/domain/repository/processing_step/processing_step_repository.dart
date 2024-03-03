import 'dart:async';

import 'package:boilerplate/domain/entity/processing_step/processing_step.dart';

abstract class ProcessingStepRepository {
  Future<ProcessingStep> getProcessingSteps();
}
