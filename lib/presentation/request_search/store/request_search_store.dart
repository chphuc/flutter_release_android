import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/domain/entity/processing_step/processing_step.dart';
import 'package:boilerplate/domain/entity/request/request_list.dart';
import 'package:boilerplate/domain/entity/request_department/request_department.dart';
import 'package:boilerplate/domain/entity/request_status/request_status.dart';
import 'package:boilerplate/domain/entity/request_type/request_type.dart';
import 'package:boilerplate/domain/repository/request/request_repository.dart';
import 'package:boilerplate/domain/usecase/processing_step/get_processing_step_usecase.dart';
import 'package:boilerplate/domain/usecase/request/get_request_usecase.dart';
import 'package:boilerplate/domain/usecase/request_department/get_request_department_usecase.dart';
import 'package:boilerplate/domain/usecase/request_status/get_request_status_usecase.dart';
import 'package:boilerplate/domain/usecase/request_type/get_request_department_usecase.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'request_search_store.g.dart';

class RequestSearchStore = _RequestSearchStore with _$RequestSearchStore;

abstract class _RequestSearchStore with Store {
  // constructor:---------------------------------------------------------------
  _RequestSearchStore(
    this._getRequestUseCase,
    this._getRequestStatusUseCase,
    this._getProcessingStepUseCase,
    this._getRequestDepartmentUseCase,
    this._getRequestTypeUseCase,
    this.errorStore,
  );

  // use cases:-----------------------------------------------------------------
  final GetRequestUseCase _getRequestUseCase;

  final GetRequestStatusUseCase _getRequestStatusUseCase;

  final GetProcessingStepUseCase _getProcessingStepUseCase;

  final GetRequestDepartmentUseCase _getRequestDepartmentUseCase;

  final GetRequestTypeUseCase _getRequestTypeUseCase;

  // stores:--------------------------------------------------------------------
  // store for handling errors
  final ErrorStore errorStore;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<RequestList?> emptyRequestResponse =
      ObservableFuture.value(null);

  static ObservableFuture<RequestStatus?> emptyRequestStatusResponse =
      ObservableFuture.value(null);

  static ObservableFuture<ProcessingStep?> emptyProcessStepResponse =
      ObservableFuture.value(null);

  static ObservableFuture<RequestDepartment?> emptyRequestDepartmentResponse =
      ObservableFuture.value(null);

  static ObservableFuture<RequestType?> emptyRequestTypeResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<RequestList?> fetchRequestFuture =
      ObservableFuture<RequestList?>(emptyRequestResponse);

  @observable
  ObservableFuture<RequestStatus?> fetchRequestStatusFuture =
      ObservableFuture<RequestStatus?>(emptyRequestStatusResponse);

  @observable
  ObservableFuture<ProcessingStep?> fetchProcessStepFuture =
      ObservableFuture<ProcessingStep?>(emptyProcessStepResponse);

  @observable
  ObservableFuture<RequestDepartment?> fetchRequestDepartmentFuture =
      ObservableFuture<RequestDepartment?>(emptyRequestDepartmentResponse);

  @observable
  ObservableFuture<RequestType?> fetchRequestTypeFuture =
      ObservableFuture<RequestType?>(emptyRequestTypeResponse);

  @observable
  RequestList? requestList;

  @observable
  RequestStatus? requestStatusList;

  @observable
  ProcessingStep? processingStepList;

  @observable
  RequestDepartment? requestDepartmentList;

  @observable
  RequestType? requestTypeList;

  @computed
  bool get requestLoading => fetchRequestFuture.status == FutureStatus.pending;

  @computed
  bool get requestStatusLoading =>
      fetchRequestStatusFuture.status == FutureStatus.pending;

  @computed
  bool get processStepLoading =>
      fetchProcessStepFuture.status == FutureStatus.pending;

  @computed
  bool get requestDepartmentLoading =>
      fetchRequestDepartmentFuture.status == FutureStatus.pending;

  @computed
  bool get requestTypeLoading =>
      fetchRequestTypeFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getRequests(RequestListParams requestListParams, bool loadMore) async {
    final future = _getRequestUseCase.call(params: requestListParams);

    fetchRequestFuture = ObservableFuture(future);

    future.then((requests) {
      if (loadMore) {
        if (this.requestList != null) {
          // Append new requests to existing list
          this.requestList!.requests.addAll(requests.requests);
        } else {
          // Initialize requestList with new requests
          this.requestList = requests;
        }
      } else {
        this.requestList = requests;
      }
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getRequestStatuses() async {
    final future = _getRequestStatusUseCase.call(params: null);
    fetchRequestStatusFuture = ObservableFuture(future);

    future.then((requestStatuses) {
      this.requestStatusList = requestStatuses;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getProcessingSteps() async {
    final future = _getProcessingStepUseCase.call(params: null);
    fetchProcessStepFuture = ObservableFuture(future);

    future.then((processingSteps) {
      this.processingStepList = processingSteps;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getRequestDepartments() async {
    final future = _getRequestDepartmentUseCase.call(params: null);
    fetchRequestDepartmentFuture = ObservableFuture(future);

    future.then((requestDepartments) {
      this.requestDepartmentList = requestDepartments;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getRequestTypes() async {
    final future = _getRequestTypeUseCase.call(params: null);
    fetchRequestTypeFuture = ObservableFuture(future);

    future.then((requestTypes) {
      this.requestTypeList = requestTypes;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
