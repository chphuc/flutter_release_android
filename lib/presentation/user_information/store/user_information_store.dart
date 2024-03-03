import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/domain/entity/user_information/user_information.dart';
import 'package:boilerplate/domain/usecase/user_information/get_user_information_usecase.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'user_information_store.g.dart';

class UserInformationStore = _UserInformationStore with _$UserInformationStore;

abstract class _UserInformationStore with Store {
  // constructor:---------------------------------------------------------------
  _UserInformationStore(this._getUserInformationUseCase, this.errorStore);

  // use cases:-----------------------------------------------------------------
  final GetUserInformationUseCase _getUserInformationUseCase;

  // stores:--------------------------------------------------------------------
  // store for handling errors
  final ErrorStore errorStore;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<UserInformation?> emptyUserInformationResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<UserInformation?> fetchUserInformationsFuture =
      ObservableFuture<UserInformation?>(emptyUserInformationResponse);

  @observable
  UserInformation? userInformation;

  @computed
  bool get loading =>
      fetchUserInformationsFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getUserInformation() async {
    final future = _getUserInformationUseCase.call(params: null);
    fetchUserInformationsFuture = ObservableFuture(future);

    future.then((userInformation) {
      this.userInformation = userInformation;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}
