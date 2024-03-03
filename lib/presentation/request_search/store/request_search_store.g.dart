// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RequestSearchStore on _RequestSearchStore, Store {
  Computed<bool>? _$requestLoadingComputed;

  @override
  bool get requestLoading =>
      (_$requestLoadingComputed ??= Computed<bool>(() => super.requestLoading,
              name: '_RequestSearchStore.requestLoading'))
          .value;
  Computed<bool>? _$requestStatusLoadingComputed;

  @override
  bool get requestStatusLoading => (_$requestStatusLoadingComputed ??=
          Computed<bool>(() => super.requestStatusLoading,
              name: '_RequestSearchStore.requestStatusLoading'))
      .value;
  Computed<bool>? _$processStepLoadingComputed;

  @override
  bool get processStepLoading => (_$processStepLoadingComputed ??=
          Computed<bool>(() => super.processStepLoading,
              name: '_RequestSearchStore.processStepLoading'))
      .value;
  Computed<bool>? _$requestDepartmentLoadingComputed;

  @override
  bool get requestDepartmentLoading => (_$requestDepartmentLoadingComputed ??=
          Computed<bool>(() => super.requestDepartmentLoading,
              name: '_RequestSearchStore.requestDepartmentLoading'))
      .value;
  Computed<bool>? _$requestTypeLoadingComputed;

  @override
  bool get requestTypeLoading => (_$requestTypeLoadingComputed ??=
          Computed<bool>(() => super.requestTypeLoading,
              name: '_RequestSearchStore.requestTypeLoading'))
      .value;

  late final _$fetchRequestFutureAtom =
      Atom(name: '_RequestSearchStore.fetchRequestFuture', context: context);

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

  late final _$fetchRequestStatusFutureAtom = Atom(
      name: '_RequestSearchStore.fetchRequestStatusFuture', context: context);

  @override
  ObservableFuture<RequestStatus?> get fetchRequestStatusFuture {
    _$fetchRequestStatusFutureAtom.reportRead();
    return super.fetchRequestStatusFuture;
  }

  @override
  set fetchRequestStatusFuture(ObservableFuture<RequestStatus?> value) {
    _$fetchRequestStatusFutureAtom
        .reportWrite(value, super.fetchRequestStatusFuture, () {
      super.fetchRequestStatusFuture = value;
    });
  }

  late final _$fetchProcessStepFutureAtom = Atom(
      name: '_RequestSearchStore.fetchProcessStepFuture', context: context);

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
      name: '_RequestSearchStore.fetchRequestDepartmentFuture',
      context: context);

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

  late final _$fetchRequestTypeFutureAtom = Atom(
      name: '_RequestSearchStore.fetchRequestTypeFuture', context: context);

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
      Atom(name: '_RequestSearchStore.requestList', context: context);

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

  late final _$requestStatusListAtom =
      Atom(name: '_RequestSearchStore.requestStatusList', context: context);

  @override
  RequestStatus? get requestStatusList {
    _$requestStatusListAtom.reportRead();
    return super.requestStatusList;
  }

  @override
  set requestStatusList(RequestStatus? value) {
    _$requestStatusListAtom.reportWrite(value, super.requestStatusList, () {
      super.requestStatusList = value;
    });
  }

  late final _$processingStepListAtom =
      Atom(name: '_RequestSearchStore.processingStepList', context: context);

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
      Atom(name: '_RequestSearchStore.requestDepartmentList', context: context);

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
      Atom(name: '_RequestSearchStore.requestTypeList', context: context);

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

  late final _$getRequestsAsyncAction =
      AsyncAction('_RequestSearchStore.getRequests', context: context);

  @override
  Future<dynamic> getRequests(
      RequestListParams requestListParams, bool loadMore) {
    return _$getRequestsAsyncAction
        .run(() => super.getRequests(requestListParams, loadMore));
  }

  late final _$getRequestStatusesAsyncAction =
      AsyncAction('_RequestSearchStore.getRequestStatuses', context: context);

  @override
  Future<dynamic> getRequestStatuses() {
    return _$getRequestStatusesAsyncAction
        .run(() => super.getRequestStatuses());
  }

  late final _$getProcessingStepsAsyncAction =
      AsyncAction('_RequestSearchStore.getProcessingSteps', context: context);

  @override
  Future<dynamic> getProcessingSteps() {
    return _$getProcessingStepsAsyncAction
        .run(() => super.getProcessingSteps());
  }

  late final _$getRequestDepartmentsAsyncAction = AsyncAction(
      '_RequestSearchStore.getRequestDepartments',
      context: context);

  @override
  Future<dynamic> getRequestDepartments() {
    return _$getRequestDepartmentsAsyncAction
        .run(() => super.getRequestDepartments());
  }

  late final _$getRequestTypesAsyncAction =
      AsyncAction('_RequestSearchStore.getRequestTypes', context: context);

  @override
  Future<dynamic> getRequestTypes() {
    return _$getRequestTypesAsyncAction.run(() => super.getRequestTypes());
  }

  @override
  String toString() {
    return '''
fetchRequestFuture: ${fetchRequestFuture},
fetchRequestStatusFuture: ${fetchRequestStatusFuture},
fetchProcessStepFuture: ${fetchProcessStepFuture},
fetchRequestDepartmentFuture: ${fetchRequestDepartmentFuture},
fetchRequestTypeFuture: ${fetchRequestTypeFuture},
requestList: ${requestList},
requestStatusList: ${requestStatusList},
processingStepList: ${processingStepList},
requestDepartmentList: ${requestDepartmentList},
requestTypeList: ${requestTypeList},
requestLoading: ${requestLoading},
requestStatusLoading: ${requestStatusLoading},
processStepLoading: ${processStepLoading},
requestDepartmentLoading: ${requestDepartmentLoading},
requestTypeLoading: ${requestTypeLoading}
    ''';
  }
}
