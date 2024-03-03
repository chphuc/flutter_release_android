import 'dart:async';

import 'package:boilerplate/data/local/datasources/post/post_datasource.dart';
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
import 'package:boilerplate/data/repository/post/post_repository_impl.dart';
import 'package:boilerplate/data/repository/processing_step/processing_step_repository_impl.dart';
import 'package:boilerplate/data/repository/request/request_repository_impl.dart';
import 'package:boilerplate/data/repository/request_department/request_department_repository_impl.dart';
import 'package:boilerplate/data/repository/request_information/request_information_repository_impl.dart';
import 'package:boilerplate/data/repository/request_status/request_status_repository_impl.dart';
import 'package:boilerplate/data/repository/request_type/request_type_repository_impl.dart';
import 'package:boilerplate/data/repository/setting/setting_repository_impl.dart';
import 'package:boilerplate/data/repository/status_bar_request/status_bar_request_repository_impl.dart';
import 'package:boilerplate/data/repository/user/user_repository_impl.dart';
import 'package:boilerplate/data/repository/user_information/user_information_repository_impl.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/repository/post/post_repository.dart';
import 'package:boilerplate/domain/repository/processing_step/processing_step_repository.dart';
import 'package:boilerplate/domain/repository/request/request_repository.dart';
import 'package:boilerplate/domain/repository/request_department/request_department_repository.dart';
import 'package:boilerplate/domain/repository/request_information/request_information_repository.dart';
import 'package:boilerplate/domain/repository/request_status/request_status_repository.dart';
import 'package:boilerplate/domain/repository/request_type/processing_step_repository.dart';
import 'package:boilerplate/domain/repository/setting/setting_repository.dart';
import 'package:boilerplate/domain/repository/status_bar_request/request_status_repository.dart';
import 'package:boilerplate/domain/repository/user/user_repository.dart';
import 'package:boilerplate/domain/repository/user_information/user_information_repository.dart';

import '../../../di/service_locator.dart';

mixin RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    // repository:--------------------------------------------------------------
    getIt.registerSingleton<SettingRepository>(SettingRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ));

    getIt.registerSingleton<UserRepository>(UserRepositoryImpl(
      getIt<AuthApi>(),
      getIt<SharedPreferenceHelper>(),
    ));

    getIt.registerSingleton<PostRepository>(PostRepositoryImpl(
      getIt<PostApi>(),
      getIt<PostDataSource>(),
    ));

    getIt.registerSingleton<StatusBarRequestRepository>(
        StatusBarRequestRepositoryImpl(getIt<StatusBarRequestApi>()));

    getIt.registerSingleton<RequestRepository>(
        RequestRepositoryImpl(getIt<RequestApi>()));

    getIt.registerSingleton<ProcessingStepRepository>(
        ProcessingStepRepositoryImpl(getIt<ProcessingStepApi>()));

    getIt.registerSingleton<RequestDepartmentRepository>(
        RequestDepartmentRepositoryImpl(getIt<RequestDepartmentApi>()));

    getIt.registerSingleton<RequestStatusRepository>(
        RequestStatusRepositoryImpl(getIt<RequestStatusApi>()));

    getIt.registerSingleton<RequestTypeRepository>(
        RequestTypeRepositoryImpl(getIt<RequestTypeApi>()));

    getIt.registerSingleton<RequestInformationRepository>(
        RequestInformationRepositoryImpl(getIt<RequestInformationApi>()));

    getIt.registerSingleton<UserInformationRepository>(
        UserInformationRepositoryImpl(getIt<UserInformationApi>()));
  }
}
