import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/core/stores/form/form_store.dart';
import 'package:boilerplate/core/widgets/dialog_widget.dart';
import 'package:boilerplate/core/widgets/empty_app_bar_widget.dart';
import 'package:boilerplate/core/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/core/widgets/rounded_button_widget.dart';
import 'package:boilerplate/core/widgets/textfield_widget.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/presentation/login/store/login_store.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di/service_locator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Authentication ------------------------------------------------------------
  late final LocalAuthentication auth;
  // variable-------------------------------------------------------------------
  SharedPreferenceHelper? _sharedPrefsHelper;
  bool _rememberMe = false;
  //text controllers:-----------------------------------------------------------
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //stores:---------------------------------------------------------------------
  final FormStore _formStore = getIt<FormStore>();
  final UserStore _userStore = getIt<UserStore>();

  //focus node:-----------------------------------------------------------------
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();

    SharedPreferences.getInstance().then((prefs) {
      _sharedPrefsHelper = SharedPreferenceHelper(prefs);

      _userNameController.text = _sharedPrefsHelper?.username ?? '';
      _passwordController.text = _sharedPrefsHelper?.password ?? '';

      _formStore.setUserId(_sharedPrefsHelper?.username ?? '');
      _formStore.setPassword(_sharedPrefsHelper?.password ?? '');
    });

    auth = LocalAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: EmptyAppBar(),
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Material(
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 250,
                    child: _buildLogo(),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: _buildForm(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Observer(
            builder: (context) {
              return _userStore.success ? navigate(context) : Container();
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _userStore.isLoading,
                child: CustomProgressIndicatorWidget(),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      color: AppThemeData.lightColorScheme.primaryContainer,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            child: Image.asset(Assets.appLogo),
          ),
          Text(
            'QUẢN LÝ HÀNH TRÌNH HTTD',
            style: TextStyle(
              color: AppThemeData.lightColorScheme.primary,
              fontSize: AppThemeData.heading1FontSize,
              fontWeight: AppThemeData.bold,
            ),
          ),
          Text(
            'LƯU ĐỘNG',
            style: TextStyle(
              color: AppThemeData.lightColorScheme.primary,
              fontSize: AppThemeData.heading1FontSize,
              fontWeight: AppThemeData.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.horizontal_padding,
        vertical: Dimens.vertical_padding,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildUserIdField(),
            SizedBox(height: 10),
            _buildPasswordField(),
            SizedBox(height: 10),
            _buildRememberMe(),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: _buildSignInButton(),
                ),
                SizedBox(width: 8),
                _buildSignInFinger(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildUserIdField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          title: 'Tên tài khoản',
          hint: 'Nhập tên tài khoản',
          textController: _userNameController,
          errorText: _formStore.formErrorStore.userEmail,
          onChanged: (value) {
            _formStore.setUserId(_userNameController.text);
          },
          textFontSize: AppThemeData.bodyText1FontSize,
          textColor: Color(0xFF8F9098),
          borderRadius: 4,
          borderWidth: 1,
          borderColor: Color(0xFFC5C6CC),
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          title: 'Mật khẩu',
          hint: 'Nhập mật khẩu',
          isObscure: true,
          textController: _passwordController,
          errorText: _formStore.formErrorStore.password,
          onChanged: (value) {
            _formStore.setPassword(_passwordController.text);
          },
          textFontSize: AppThemeData.bodyText1FontSize,
          textColor: Color(0xFF8F9098),
          borderRadius: 4,
          borderWidth: 1,
          borderColor: Color(0xFFC5C6CC),
        );
      },
    );
  }

  Widget _buildRememberMe() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: _rememberMe,
            onChanged: (bool? value) {
              setState(() {
                _rememberMe = value!;
              });
            },
            activeColor: Colors.grey,
            hoverColor: Colors.transparent,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'Ghi nhớ tài khoản',
          style: TextStyle(
            fontSize: AppThemeData.bodyText2FontSize,
            fontWeight: AppThemeData.extraBold,
          ),
        ),
      ],
    );
  }

  Widget _buildSignInButton() {
    return RoundedButtonWidget(
      buttonText: 'Đăng nhập',
      textColor: Colors.white,
      buttonColor: AppThemeData.lightColorScheme.primary,
      height: 60,
      borderRadius: BorderRadius.circular(12.0),
      onPressed: () async {
        _formStore.validateAll();
        if (_formStore.canLogin) {
          DeviceUtils.hideKeyboard(context);
          try {
            await _userStore.login(
              _userNameController.text,
              _passwordController.text,
            );

            if (_rememberMe) {
              await _sharedPrefsHelper?.setUsername(_userNameController.text);
              await _sharedPrefsHelper?.setPassword(_passwordController.text);
            }

            await _sharedPrefsHelper
                ?.setUsernameLogined(_userNameController.text);
          } catch (e) {
            if (e is DioException && e.response != null) {
              dynamic errorDetails = e.response!.data['error']['details'];
              dynamic errorMessage = e.response!.data['error']['message'];
              if (errorDetails != null) {
                _showDialog(errorDetails, errorMessage);
              }
            }
          }
        }
      },
    );
  }

  Widget _buildSignInFinger() {
    return IconButton(
      onPressed: () async {
        bool canCheckBiometrics = await _canCheckBiometrics();
        if (!canCheckBiometrics) {
          _showDialog("Thiết bị không hỗ trợ vân tay",
              "Thiết bị của bạn không hỗ trợ chức năng đăng nhập bằng vân tay.");
        } else {
          _authenticate();
        }
      },
      icon: SvgPicture.asset(
        Assets.fingerPrintIcon,
        width: 50.0,
        height: 50.0,
        color: AppThemeData.lightColorScheme.primary,
      ),
    );
  }

  Future<bool> _canCheckBiometrics() async {
    try {
      bool canCheckBiometrics = await auth.canCheckBiometrics;

      return canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> _authenticate() async {
    bool isFingerprintLoginEnabled =
        _sharedPrefsHelper?.fingerprintLogin ?? false;
    if (!isFingerprintLoginEnabled) {
      _showDialog("Đăng nhập bằng vân tay chưa được kích hoạt",
          "Vui lòng đăng nhập bằng tên người dùng và mật khẩu.");
    } else {
      try {
        bool authticated = await auth.authenticate(
          localizedReason:
              'Authenticate to enhance the security of your account.',
          options: AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ),
        );

        if (authticated) {
          String? authToken = await _sharedPrefsHelper?.authToken;
          if (authToken != null) {
            _userStore.success = true;
          } else {
            _showDialog("Phiên hết hạn",
                "Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.");
          }
        }
      } on PlatformException catch (e) {
        print(e);
      }
    }
  }

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.navigator, (Route<dynamic> route) => false);
    });

    return Container();
  }

  // Function to show an error dialog
  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogWidget(
          title: title,
          content: message,
          isError: true,
          buttons: [
            DialogButtonConfig(
              text: "Đã hiểu",
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _userNameController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
