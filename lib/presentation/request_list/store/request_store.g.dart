// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RequestListStore on _RequestListStore, Store {
  Computed<bool>? _$requestLoadingComputed;

  @override
  bool get requestLoading =>
      (_$requestLoadingComputed ??= Computed<bool>(() => super.requestLoading,
              name: '_RequestListStore.requestLoading'))
          .value;
  Computed<bool>? _$processStepLoadingComputed;

  @override
  bool get processStepLoading => (_$processStepLoadingComputed ??=
          Computed<bool>(() => super.processStepLoading,
              name: '_RequestListStore.processStepLoading'))
      .value;
  Computed<bool>? _$requestDepartmentLoadingComputed;

  @override
  bool get requestDepartmentLoading => (_$requestDepartmentLoadingComputed ??=
          Computed<bool>(() => super.requestDepartmentLoading,
              name: '_RequestListStore.requestDepartmentLoading'))
      .value;
  Computed<bool>? _$requestTypeLoadingComputed;

  @override
  bool get requestTypeLoading => (_$requestTypeLoadingComputed ??=
          Computed<bool>(() => super.requestTypeLoading,
              name: '_RequestListStore.requestTypeLoading'))
      .value;

  late final _$fetchRequestFutureAtom =
      Atom(name: '_RequestListStore.fetchRequestFuture', context: context);

  @override
  ObservableFuture<RequestList?> get fetchRequestFuture {
    _$fetchRequestFutureAtom.reportRead();
    return super.fetchRequestFuture;
  }

  @override
  set fetchRequestFuture(ObservableFuture<RequestList?> value) {
    _$fetchRequestFutureAtom.reportWrite(value, super.fetchRequestFuture, () {
      super.fetchRequestFuture = value;
    });
  }

  late final _$fetchProcessStepFutureAtom =
      Atom(name: '_RequestListStore.fetchProcessStepFuture', context: context);

  @override
  ObservableFuture<ProcessingStep?> get fetchProcessStepFuture {
    _$fetchProcessStepFutureAtom.reportRead();
    return super.fetchProcessStepFuture;
  }

  @override
  set fetchProcessStepFuture(ObservableFuture<ProcessingStep?> value) {
    _$fetchProcessStepFutureAtom
        .reportWrite(value, super.fetchProcessStepFuture, () {
      super.fetchProcessStepFuture = value;
    });
  }

  late final _$fetchRequestDepartmentFutureAtom = Atom(
      name: '_RequestListStore.fetchRequestDepartmentFuture', context: context);

  @override
  ObservableFuture<RequestDepartment?> get fetchRequestDepartmentFuture {
    _$fetchRequestDepartmentFutureAtom.reportRead();
    return super.fetchRequestDepartmentFuture;
  }

  @override
  set fetchRequestDepartmentFuture(ObservableFuture<RequestDepartment?> value) {
    _$fetchRequestDepartmentFutureAtom
        .reportWrite(value, super.fetchRequestDepartmentFuture, () {
      super.fetchRequestDepartmentFuture = value;
    });
  }

  late final _$fetchRequestTypeFutureAtom =
      Atom(name: '_RequestListStore.fetchRequestTypeFuture', context: context);

  @override
  ObservableFuture<RequestType?> get fetchRequestTypeFuture {
    _$fetchRequestTypeFutureAtom.reportRead();
    return super.fetchRequestTypeFuture;
  }

  @override
  set fetchRequestTypeFuture(ObservableFuture<RequestType?> value) {
    _$fetchRequestTypeFutureAtom
        .reportWrite(value, super.fetchRequestTypeFuture, () {
      super.fetchRequestTypeFuture = value;
    });
  }

  late final _$requestListAtom =
      Atom(name: '_RequestListStore.requestList', context: context);

  @override
  RequestList? get requestList {
    _$requestListAtom.reportRead();
    return super.requestList;
  }

  @override
  set requestList(RequestList? value) {
    _$requestListAtom.reportWrite(value, super.requestList, () {
      super.requestList = value;
    });
  }

  late final _$processingStepListAtom =
      Atom(name: '_RequestListStore.processingStepList', context: context);

  @override
  ProcessingStep? get processingStepList {
    _$processingStepListAtom.reportRead();
    return super.processingStepList;
  }

  @override
  set processingStepList(ProcessingStep? value) {
    _$processingStepListAtom.reportWrite(value, super.processingStepList, () {
      super.processingStepList = value;
    });
  }

  late final _$requestDepartmentListAtom =
      Atom(name: '_RequestListStore.requestDepartmentList', context: context);

  @override
  RequestDepartment? get requestDepartmentList {
    _$requestDepartmentListAtom.reportRead();
    return super.requestDepartmentList;
  }

  @override
  set requestDepartmentList(RequestDepartment? value) {
    _$requestDepartmentListAtom.reportWrite(value, super.requestDepartmentList,
        () {
      super.requestDepartmentList = value;
    });
  }

  late final _$requestTypeListAtom =
      Atom(name: '_RequestListStore.requestTypeList', context: context);

  @override
  RequestType? get requestTypeList {
    _$requestTypeListAtom.reportRead();
    return super.requestTypeList;
  }

  @override
  set requestTypeList(RequestType? value) {
    _$requestTypeListAtom.reportWrite(value, super.requestTypeList, () {
      super.requestTypeList = value;
    });
  }

  late final _$currentIndexBarRequestAtom =
      Atom(name: '_RequestListStore.currentIndexBarRequest', context: context);

  @override
  int get currentIndexBarRequest {
    _$currentIndexBarRequestAtom.reportRead();
    return super.currentIndexBarRequest;
  }

  @override
  set currentIndexBarRequest(int value) {
    _$currentIndexBarRequestAtom
        .reportWrite(value, super.currentIndexBarRequest, () {
      super.currentIndexBarRequest = value;
    });
  }

  late final _$getRequestsAsyncAction =
      AsyncAction('_RequestListStore.getRequests', context: context);

  @override
  Future<dynamic> getRequests(
      RequestListParams requestListParams, bool loadMore) {
    return _$getRequestsAsyncAction
        .run(() => super.getRequests(requestListParams, loadMore));
  }

  late final _$getProcessingStepsAsyncAction =
      AsyncAction('_RequestListStore.getProcessingSteps', context: context);

  @override
  Future<dynamic> getProcessingSteps() {
    return _$getProcessingStepsAsyncAction
        .run(() => super.getProcessingSteps());
  }

  late final _$getRequestDepartmentsAsyncAction =
      AsyncAction('_RequestListStore.getRequestDepartments', context: context);

  @override
  Future<dynamic> getRequestDepartments() {
    return _$getRequestDepartmentsAsyncAction
        .run(() => super.getRequestDepartments());
  }

  late final _$getRequestTypesAsyncAction =
      AsyncAction('_RequestListStore.getRequestTypes', context: context);

  @override
  Future<dynamic> getRequestTypes() {
    return _$getRequestTypesAsyncAction.run(() => super.getRequestTypes());
  }

  late final _$_RequestListStoreActionController =
      ActionController(name: '_RequestListStore', context: context);

  @override
  void setCurrentIndexBarRequest(int index) {
    final _$actionInfo = _$_RequestListStoreActionController.startAction(
        name: '_RequestListStore.setCurrentIndexBarRequest');
    try {
      return super.setCurrentIndexBarRequest(index);
    } finally {
      _$_RequestListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchRequestFuture: ${fetchRequestFuture},
fetchProcessStepFuture: ${fetchProcessStepFuture},
fetchRequestDepartmentFuture: ${fetchRequestDepartmentFuture},
fetchRequestTypeFuture: ${fetchRequestTypeFuture},
requestList: ${requestList},
processingStepList: ${processingStepList},
requestDepartmentList: ${requestDepartmentList},
requestTypeList: ${requestTypeList},
currentIndexBarRequest: ${currentIndexBarRequest},
requestLoading: ${requestLoading},
processStepLoading: ${processStepLoading},
requestDepartmentLoading: ${requestDepartmentLoading},
requestTypeLoading: ${requestTypeLoading}
    ''';
  }
}
