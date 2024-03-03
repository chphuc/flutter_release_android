import 'package:boilerplate/presentation/login/login.dart';
import 'package:boilerplate/presentation/navigator/navigator.dart';
import 'package:boilerplate/presentation/request_history/request_history.dart';
import 'package:boilerplate/presentation/request_information/request_information.dart';
import 'package:boilerplate/presentation/setting_login/setting_login.dart';
import 'package:boilerplate/presentation/user_information/user_information.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String login = '/login';
  static const String navigator = '/navigator';

  static const String settingLogin = '/setting_login';
  static const String userInformation = '/user_information';
  static const String requestInformation = '/request_information';
  static const String requestHistory = '/request_history';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LoginScreen(),
    navigator: (BuildContext context) => NavigatorScreen(),
    settingLogin: (BuildContext context) => SettingLoginScreen(),
    userInformation: (BuildContext context) => UserInformationScreen(),
    requestInformation: (BuildContext context) => RequestInformationScreen(),
    requestHistory: (BuildContext context) => RequestHistoryScreen(),
  };
}
