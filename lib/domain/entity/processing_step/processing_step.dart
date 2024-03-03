class ProcessingStep {
  List<String> data;

  ProcessingStep({
    required this.data,
  });

  factory ProcessingStep.fromJson(Map<String, dynamic> json) {
    List<String> jsonData = List<String>.from(json['result'] ?? []);

    return ProcessingStep(data: jsonData);
  }
}
