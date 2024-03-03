import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/domain/entity/request_information/request_information.dart';
import 'package:boilerplate/domain/usecase/request_information/get_request_information_usecase.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'request_information_store.g.dart';

class RequestInformationStore = _RequestInformationStore
    with _$RequestInformationStore;

abstract class _RequestInformationStore with Store {
  // constructor:---------------------------------------------------------------
  _RequestInformationStore(
    this._getRequestInformationUseCase,
    this.errorStore,
  );

  // use cases:-----------------------------------------------------------------
  final GetRequestInformationUseCase _getRequestInformationUseCase;

  // stores:--------------------------------------------------------------------
  // store for handling errors
  final ErrorStore errorStore;

  // store variables:-----------------------------------------------------------

  static ObservableFuture<RequestInformation?> emptyRequestInformationResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<RequestInformation?> fetchRequestInformationFuture =
      ObservableFuture<RequestInformation?>(emptyRequestInformationResponse);

  @observable
  RequestInformation? requestInformation;

  @computed
  bool get loading =>
      fetchRequestInformationFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------

  @action
  Future getRequestInformation(int idRequest) async {
    final future = _getRequestInformationUseCase.call(params: idRequest);
    fetchRequestInformationFuture = ObservableFuture(future);

    future.then((requestInformation) {
      this.requestInformation = requestInformation;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
