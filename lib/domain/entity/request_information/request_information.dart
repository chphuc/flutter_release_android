class RequestAction {
  int id;
  String actionCode;
  String actionName;
  bool requiredReason;
  String result;

  RequestAction({
    required this.id,
    required this.actionCode,
    required this.actionName,
    required this.requiredReason,
    required this.result,
  });

  factory RequestAction.fromJson(Map<String, dynamic> json) {
    return RequestAction(
      id: json['id'] ?? 0,
      actionCode: json['actionCode'] ?? '',
      actionName: json['actionName'] ?? '',
      requiredReason: json['requiredReason'] ?? false,
      result: json['result'] ?? '',
    );
  }
}

class Progress {
  int id;
  String stepCode;
  String stepName;
  bool requiredImage;
  bool requiredPosition;

  Progress({
    required this.id,
    required this.stepCode,
    required this.stepName,
    required this.requiredImage,
    required this.requiredPosition,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      id: json['id'] ?? 0,
      stepCode: json['stepCode'] ?? '',
      stepName: json['stepName'] ?? '',
      requiredImage: json['requiredImage'] ?? false,
      requiredPosition: json['requiredPosition'] ?? false,
    );
  }
}

class RequestInformation {
  String reqCode;
  String statusName;
  String reqTypeName;
  String customer;
  String phoneNumber;
  String collateral;
  String reqUnitName;
  String recordManagerName;
  String execUnitName;
  String progressName;
  String execEmployeeName;
  String locationName;
  String execArea;
  String address;
  String receivingTime;
  String execTime;
  String requiredCompletionTime;
  List<RequestAction> actions;
  Progress progress;

  RequestInformation({
    required this.reqCode,
    required this.statusName,
    required this.reqTypeName,
    required this.customer,
    required this.phoneNumber,
    required this.collateral,
    required this.reqUnitName,
    required this.recordManagerName,
    required this.execUnitName,
    required this.progressName,
    required this.execEmployeeName,
    required this.locationName,
    required this.execArea,
    required this.address,
    required this.receivingTime,
    required this.execTime,
    required this.requiredCompletionTime,
    required this.actions,
    required this.progress,
  });

  factory RequestInformation.fromJson(Map<String, dynamic> json) {
    List<RequestAction> actionsList = [];
    if (json['result']['actions'] != null) {
      json['result']['actions'].forEach((actionJson) {
        actionsList.add(RequestAction.fromJson(actionJson));
      });
    }

    var progressData = Progress.fromJson(json['result']['progress']);

    return RequestInformation(
      reqCode: json['result']['request']['reqCode'] ?? '',
      statusName: json['result']['request']['statusName'] ?? '',
      reqTypeName: json['result']['request']['reqTypeName'] ?? '',
      customer: json['result']['request']['customer'] ?? '',
      phoneNumber: json['result']['request']['phoneNumber'] ?? '',
      collateral: json['result']['request']['collateral'] ?? '',
      reqUnitName: json['result']['request']['reqUnitName'] ?? '',
      recordManagerName: json['result']['request']['recordManagerName'] ?? '',
      execUnitName: json['result']['request']['execUnitName'] ?? '',
      progressName: json['result']['request']['progressName'] ?? '',
      execEmployeeName: json['result']['request']['execEmployeeName'] ?? '',
      locationName: json['result']['request']['locationName'] ?? '',
      execArea: json['result']['request']['execArea'] ?? '',
      address: json['result']['request']['address'] ?? '',
      receivingTime: json['result']['request']['receivingTime'] ?? '',
      execTime: json['result']['request']['execTime'] ?? '',
      requiredCompletionTime:
          json['result']['request']['requiredCompletionTime'] ?? '',
      actions: actionsList,
      progress: progressData,
    );
  }
}
