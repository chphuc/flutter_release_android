import 'dart:async';

import 'package:boilerplate/domain/repository/post/post_repository.dart';
import 'package:boilerplate/domain/repository/processing_step/processing_step_repository.dart';
import 'package:boilerplate/domain/repository/request/request_repository.dart';
import 'package:boilerplate/domain/repository/request_department/request_department_repository.dart';
import 'package:boilerplate/domain/repository/request_information/request_information_repository.dart';
import 'package:boilerplate/domain/repository/request_status/request_status_repository.dart';
import 'package:boilerplate/domain/repository/request_type/processing_step_repository.dart';
import 'package:boilerplate/domain/repository/status_bar_request/request_status_repository.dart';
import 'package:boilerplate/domain/repository/user/user_repository.dart';
import 'package:boilerplate/domain/repository/user_information/user_information_repository.dart';
import 'package:boilerplate/domain/usecase/post/delete_post_usecase.dart';
import 'package:boilerplate/domain/usecase/post/find_post_by_id_usecase.dart';
import 'package:boilerplate/domain/usecase/post/get_post_usecase.dart';
import 'package:boilerplate/domain/usecase/post/insert_post_usecase.dart';
import 'package:boilerplate/domain/usecase/post/udpate_post_usecase.dart';
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

import '../../../di/service_locator.dart';

mixin UseCaseModule {
  static Future<void> configureUseCaseModuleInjection() async {
    // user:--------------------------------------------------------------------
    getIt.registerSingleton<IsLoggedInUseCase>(
      IsLoggedInUseCase(getIt<UserRepository>()),
    );
    getIt.registerSingleton<SaveLoginStatusUseCase>(
      SaveLoginStatusUseCase(getIt<UserRepository>()),
    );
    getIt.registerSingleton<LoginUseCase>(
      LoginUseCase(getIt<UserRepository>()),
    );

    // post:--------------------------------------------------------------------
    getIt.registerSingleton<GetPostUseCase>(
      GetPostUseCase(getIt<PostRepository>()),
    );
    getIt.registerSingleton<FindPostByIdUseCase>(
      FindPostByIdUseCase(getIt<PostRepository>()),
    );
    getIt.registerSingleton<InsertPostUseCase>(
      InsertPostUseCase(getIt<PostRepository>()),
    );
    getIt.registerSingleton<UpdatePostUseCase>(
      UpdatePostUseCase(getIt<PostRepository>()),
    );
    getIt.registerSingleton<DeletePostUseCase>(
      DeletePostUseCase(getIt<PostRepository>()),
    );

    getIt.registerSingleton<GetStatusBarRequestUseCase>(
      GetStatusBarRequestUseCase(getIt<StatusBarRequestRepository>()),
    );

    getIt.registerSingleton<GetRequestUseCase>(
      GetRequestUseCase(getIt<RequestRepository>()),
    );

    getIt.registerSingleton<GetProcessingStepUseCase>(
      GetProcessingStepUseCase(getIt<ProcessingStepRepository>()),
    );

    getIt.registerSingleton<GetRequestDepartmentUseCase>(
      GetRequestDepartmentUseCase(getIt<RequestDepartmentRepository>()),
    );

    getIt.registerSingleton<GetRequestStatusUseCase>(
      GetRequestStatusUseCase(getIt<RequestStatusRepository>()),
    );

    getIt.registerSingleton<GetRequestTypeUseCase>(
      GetRequestTypeUseCase(getIt<RequestTypeRepository>()),
    );

    getIt.registerSingleton<GetRequestInformationUseCase>(
      GetRequestInformationUseCase(getIt<RequestInformationRepository>()),
    );

    getIt.registerSingleton<GetUserInformationUseCase>(
      GetUserInformationUseCase(getIt<UserInformationRepository>()),
    );
  }
}
