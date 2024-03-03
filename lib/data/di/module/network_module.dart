import 'package:boilerplate/core/data/network/dio/configs/dio_configs.dart';
import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/core/data/network/dio/interceptors/auth_interceptor.dart';
import 'package:boilerplate/core/data/network/dio/interceptors/logging_interceptor.dart';
import 'package:boilerplate/data/network/apis/auth/auth_api.dart';
import 'package:boilerplate/data/network/apis/posts/post_api.dart';
import 'package:boilerplate/data/network/apis/processing_step/processing_step_api.dart';
import 'package:boilerplate/data/network/apis/request/request_api.dart';
import 'package:boilerplate/data/network/apis/request_department/request_department_api.dart';
import 'package:boilerplate/data/network/apis/request_information/request_information_api.dart';
import 'package:boilerplate/data/network/apis/request_status/request_status_api.dart';
import 'package:boilerplate/data/network/apis/request_type/request_type_api.dart';
import 'package:boilerplate/data/network/apis/status_bar_request/request_status_api.dart';
import 'package:boilerplate/data/network/apis/user_information/user_information_api.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/interceptors/error_interceptor.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:event_bus/event_bus.dart';

import '../../../di/service_locator.dart';

mixin NetworkModule {
  static Future<void> configureNetworkModuleInjection() async {
    // event bus:---------------------------------------------------------------
    getIt.registerSingleton<EventBus>(EventBus());

    // interceptors:------------------------------------------------------------
    getIt.registerSingleton<LoggingInterceptor>(LoggingInterceptor());
    getIt.registerSingleton<ErrorInterceptor>(ErrorInterceptor(getIt()));
    getIt.registerSingleton<AuthInterceptor>(
      AuthInterceptor(
        accessToken: () async => await getIt<SharedPreferenceHelper>().authToken,
      ),
    );

    // rest client:-------------------------------------------------------------
    getIt.registerSingleton(RestClient());

    // dio:---------------------------------------------------------------------
    getIt.registerSingleton<DioConfigs>(
      const DioConfigs(
        baseUrl: Endpoints.baseUrl,
        connectionTimeout: Endpoints.connectionTimeout,
        receiveTimeout:Endpoints.receiveTimeout,
      ),
    );
    getIt.registerSingleton<DioClient>(
      DioClient(dioConfigs: getIt())
        ..addInterceptors(
          [
            getIt<AuthInterceptor>(),
            getIt<ErrorInterceptor>(),
            getIt<LoggingInterceptor>(),
          ],
        ),
    );

    // api's:-------------------------------------------------------------------
    getIt.registerSingleton(AuthApi(getIt<DioClient>(), getIt<RestClient>()));
    getIt.registerSingleton(PostApi(getIt<DioClient>(), getIt<RestClient>()));
    getIt.registerSingleton(StatusBarRequestApi(getIt<DioClient>(), getIt<RestClient>()));
    getIt.registerSingleton(RequestApi(getIt<DioClient>(), getIt<RestClient>()));
    getIt.registerSingleton(ProcessingStepApi(getIt<DioClient>(), getIt<RestClient>()));
    getIt.registerSingleton(RequestDepartmentApi(getIt<DioClient>(), getIt<RestClient>()));
    getIt.registerSingleton(RequestStatusApi(getIt<DioClient>(), getIt<RestClient>()));
    getIt.registerSingleton(RequestTypeApi(getIt<DioClient>(), getIt<RestClient>()));
    getIt.registerSingleton(RequestInformationApi(getIt<DioClient>(), getIt<RestClient>()));
    getIt.registerSingleton(UserInformationApi(getIt<DioClient>(), getIt<RestClient>()));
  }
}
