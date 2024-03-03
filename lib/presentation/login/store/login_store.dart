import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/core/stores/form/form_store.dart';
import 'package:boilerplate/core/widgets/dialog_widget.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/usecase/user/is_logged_in_usecase.dart';
import 'package:boilerplate/domain/usecase/user/save_login_in_status_usecase.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/entity/user/user.dart';
import '../../../domain/usecase/user/login_usecase.dart';

part 'login_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  // constructor:---------------------------------------------------------------
  _UserStore(
    this._isLoggedInUseCase,
    this._saveLoginStatusUseCase,
    this._loginUseCase,
    this.formErrorStore,
    this.errorStore,
    this._sharedPrefsHelper,
  ) {
    // setting up disposers
    _setupDisposers();

    // checking if user is logged in
    _isLoggedInUseCase.call(params: null).then((value) async {
      isLoggedIn = value;
    });
  }
  // ------------------------------------------------------
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final SharedPreferenceHelper _sharedPrefsHelper;

  // use cases:-----------------------------------------------------------------
  final IsLoggedInUseCase _isLoggedInUseCase;
  final SaveLoginStatusUseCase _saveLoginStatusUseCase;
  final LoginUseCase _loginUseCase;

  // stores:--------------------------------------------------------------------
  // for handling form errors
  final FormErrorStore formErrorStore;

  // store for handling error messages
  final ErrorStore errorStore;

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<User?> emptyLoginResponse =
      ObservableFuture.value(null);

  // store variables:-----------------------------------------------------------
  bool isLoggedIn = false;

  @observable
  bool success = false;

  @observable
  ObservableFuture<User?> loginFuture = emptyLoginResponse;

  @computed
  bool get isLoading => loginFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future login(String email, String password) async {
    final LoginParams loginParams =
        LoginParams(username: email, password: password);
    final future = _loginUseCase.call(params: loginParams);
    loginFuture = ObservableFuture(future);

    await future.then((value) async {
      if (value != null) {
        this.success = true;

        await _sharedPrefsHelper.saveAuthToken(value.accessToken);

        bool isFingerprintLoginEnabled =
            _sharedPrefsHelper.fingerprintLogin ?? false;
        if (isFingerprintLoginEnabled) {
          String usernameLogined = _sharedPrefsHelper.usernameLogined ?? "";
          if (usernameLogined.isNotEmpty) {
            if (usernameLogined != email) {
              await _sharedPrefsHelper.setFingerprintLogin(false);
            }
          }
        }

        int expireInSeconds =
            value.expireInSeconds == 0 ? 1800 : value.expireInSeconds;

        Future.delayed(Duration(seconds: expireInSeconds), () {
          _showLogoutModal(navigatorKey.currentState!.overlay!.context);
        });
      }
    }).catchError((e) {
      print(e);
      this.success = false;
      throw e;
    });
  }

  logout(BuildContext context) async {
    await _sharedPrefsHelper.removeAuthToken();
    await _sharedPrefsHelper.setFingerprintLogin(false);
    Navigator.of(context).pushReplacementNamed(Routes.login);
  }

  void _showLogoutModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DialogWidget(
          title: "Phiên hết hạn",
          content: "Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.",
          isError: true,
          buttons: [
            DialogButtonConfig(
              text: "Xác nhận",
              onPressed: () {
                logout(context);
              },
            ),
          ],
        );
      },
    );
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
