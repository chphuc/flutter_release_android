import 'dart:async';

import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/core/stores/form/form_store.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/usecase/post/get_post_usecase.dart';
import 'package:boilerplate/domain/usecase/processing_step/get_processing_step_usecase.dart';
import 'package:boilerplate/domain/usecase/request/get_request_usecase.dart';
import 'package:boilerplate/domain/usecase/request_department/get_request_department_usecase.dart';
import 'package:boilerplate/domain/usecase/request_information/get_request_information_usecase.dart';
import 'package:boilerplate/domain/usecase/request_status/get_request_status_usecase.dart';
import 'package:boilerplate/domain/usecase/request_type/get_request_department_usecase.dart';
import 'package:boilerplate/domain/usecase/status_bar_request/get_status_bar_request_usecase.dart';
import 'package:boilerplate/domain/usecase/user/is_logged_in_usecase.dart';
import 'package:boilerplate/domain/usecase/user/login_usecase.dart';
import 'package:boilerplate/domain/usecase/user/save_login_in_status_usecase.dart';
import 'package:boilerplate/domain/usecase/user_information/get_user_information_usecase.dart';
import 'package:boilerplate/presentation/account_information/store/account_information_store.dart';
import 'package:boilerplate/presentation/home/store/home_store.dart';
import 'package:boilerplate/presentation/login/store/login_store.dart';
import 'package:boilerplate/presentation/navigator/store/navigator_store.dart';
import 'package:boilerplate/presentation/post/store/post_store.dart';
import 'package:boilerplate/presentation/request_information/store/request_information_store.dart';
import 'package:boilerplate/presentation/request_list/store/request_store.dart';
import 'package:boilerplate/presentation/request_search/store/request_search_store.dart';
import 'package:boilerplate/presentation/user_information/store/user_information_store.dart';

import '../../../di/service_locator.dart';

mixin StoreModule {
  static Future<void> configureStoreModuleInjection() async {
    // factories:---------------------------------------------------------------
    getIt.registerFactory(() => ErrorStore());
    getIt.registerFactory(() => FormErrorStore());
    getIt.registerFactory(
      () => FormStore(getIt<FormErrorStore>(), getIt<ErrorStore>()),
    );

    // stores:------------------------------------------------------------------
    getIt.registerSingleton<UserStore>(
      UserStore(
          getIt<IsLoggedInUseCase>(),
          getIt<SaveLoginStatusUseCase>(),
          getIt<LoginUseCase>(),
          getIt<FormErrorStore>(),
          getIt<ErrorStore>(),
          getIt<SharedPreferenceHelper>()),
    );

    getIt.registerSingleton<PostStore>(
      PostStore(
        getIt<GetPostUseCase>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<NavigatorStore>(
      NavigatorStore(),
    );

    getIt.registerSingleton<HomeStore>(
      HomeStore(
        getIt<GetStatusBarRequestUseCase>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<RequestListStore>(
      RequestListStore(
        getIt<GetRequestUseCase>(),
        getIt<GetProcessingStepUseCase>(),
        getIt<GetRequestDepartmentUseCase>(),
        getIt<GetRequestTypeUseCase>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<RequestSearchStore>(
      RequestSearchStore(
        getIt<GetRequestUseCase>(),
        getIt<GetRequestStatusUseCase>(),
        getIt<GetProcessingStepUseCase>(),
        getIt<GetRequestDepartmentUseCase>(),
        getIt<GetRequestTypeUseCase>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<RequestInformationStore>(
      RequestInformationStore(
        getIt<GetRequestInformationUseCase>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<AccountInformationStore>(
      AccountInformationStore(
        getIt<GetUserInformationUseCase>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<UserInformationStore>(
      UserInformationStore(
        getIt<GetUserInformationUseCase>(),
        getIt<ErrorStore>(),
      ),
    );
  }
}
