import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/domain/entity/status_bar_request/status_bar_request_list.dart';
import 'package:boilerplate/domain/usecase/status_bar_request/get_status_bar_request_usecase.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  // constructor:---------------------------------------------------------------
  _HomeStore(
    this._getStatusBarRequestUseCase,
    this.errorStore,
  );

  // use cases:-----------------------------------------------------------------
  final GetStatusBarRequestUseCase _getStatusBarRequestUseCase;

  // stores:--------------------------------------------------------------------
  // store for handling errors
  final ErrorStore errorStore;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<StatusBarRequestList?> emptyStatusBarRequestResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<StatusBarRequestList?> fetchStatusBarRequestFuture =
      ObservableFuture<StatusBarRequestList?>(emptyStatusBarRequestResponse);

  @observable
  StatusBarRequestList? statusBarRequestList;

  @computed
  bool get statusBarRequestLoading =>
      fetchStatusBarRequestFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getStatusBarRequests() async {
    final future = _getStatusBarRequestUseCase.call(params: null);
    fetchStatusBarRequestFuture = ObservableFuture(future);

    future.then((statusBarRequest) {
      this.statusBarRequestList = statusBarRequest;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
