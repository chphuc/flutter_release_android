import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/core/widgets/dialog_widget.dart';
import 'package:boilerplate/core/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/core/widgets/rounded_button_widget.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/account_information/store/account_information_store.dart';
import 'package:boilerplate/presentation/login/store/login_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';

class AccountInformationScreen extends StatefulWidget {
  const AccountInformationScreen({Key? key}) : super(key: key);

  @override
  _AccountInformationScreenState createState() =>
      _AccountInformationScreenState();
}

class _AccountInformationScreenState extends State<AccountInformationScreen> {
  final AccountInformationStore _acccountInformationStore =
      getIt<AccountInformationStore>();

  final UserStore _userStore = getIt<UserStore>();

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _roleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (!_acccountInformationStore.loading) {
      _acccountInformationStore.getUserInformation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thông tin tài khoản',
          style: TextStyle(
            fontSize: AppThemeData.heading2FontSize,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          _handleErrorMessage(),
          _buildMainContent(),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        if (_acccountInformationStore.loading) {
          return CustomProgressIndicatorWidget();
        } else if (_acccountInformationStore
                .fetchUserInformationsFuture.status ==
            FutureStatus.fulfilled) {
          _userNameController.text =
              _acccountInformationStore.userInformation!.surname +
                  " " +
                  _acccountInformationStore.userInformation!.name;
          _roleController.text =
              _acccountInformationStore.userInformation!.role;

          return Material(child: _maincontent());
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  Widget _maincontent() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.horizontal_padding,
          vertical: Dimens.vertical_padding,
        ),
        child: Column(children: [
          _profileInfomation(),
          SizedBox(height: 26),
          _actionUser(context),
        ]),
      ),
    );
  }

  Widget _profileInfomation() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(Assets.avatarDefault),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            _userNameController.text,
            style: TextStyle(
              color: AppThemeData.lightColorScheme.primary,
              fontSize: AppThemeData.heading1FontSize,
              fontWeight: AppThemeData.semiBold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Chức vụ: ',
                style: TextStyle(
                  fontSize: AppThemeData.bodyText1FontSize,
                ),
              ),
              Text(
                _roleController.text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: AppThemeData.bodyText1FontSize,
                  fontWeight: AppThemeData.semiBold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _actionUser(BuildContext context) {
    return Column(
      children: [
        _buttonUserInfomation(context),
        SizedBox(height: 26),
        _buttonSettingLogin(context),
        SizedBox(height: 26),
        _buttonLogout(context),
      ],
    );
  }

  Widget _buttonUserInfomation(BuildContext context) {
    return RoundedButtonWidget(
      buttonText: "Thông tin tài khoản",
      textColor: Colors.black,
      textAlign: TextAlign.start,
      leftIcon: SvgPicture.asset(
        Assets.userIcon,
        width: 16,
        height: 16,
        color: AppThemeData.lightColorScheme.primary,
      ),
      rightIcon: SvgPicture.asset(
        Assets.arrowRightIcon,
        width: 12,
        height: 12,
        color: AppThemeData.lightColorScheme.primary,
      ),
      leftIconColor: Colors.blue,
      rightIconColor: Colors.blue,
      buttonColor: Colors.white,
      height: 60,
      borderRadius: BorderRadius.circular(12.0),
      onPressed: () {
        Navigator.of(context).pushNamed(Routes.userInformation);
      },
    );
  }

  Widget _buttonSettingLogin(BuildContext context) {
    return RoundedButtonWidget(
      buttonText: "Cài đặt đăng nhập",
      textColor: Colors.black,
      textAlign: TextAlign.start,
      leftIcon: SvgPicture.asset(
        Assets.settingIcon,
        width: 16,
        height: 16,
        color: AppThemeData.lightColorScheme.primary,
      ),
      rightIcon: SvgPicture.asset(
        Assets.arrowRightIcon,
        width: 12,
        height: 12,
        color: AppThemeData.lightColorScheme.primary,
      ),
      leftIconColor: Colors.blue,
      rightIconColor: Colors.blue,
      buttonColor: Colors.white,
      height: 60,
      borderRadius: BorderRadius.circular(12.0),
      onPressed: () {
        Navigator.of(context).pushNamed(Routes.settingLogin);
      },
    );
  }

  Widget _buttonLogout(BuildContext context) {
    return RoundedButtonWidget(
      buttonText: "Đăng xuất",
      textColor: Colors.black,
      textAlign: TextAlign.start,
      leftIcon: SvgPicture.asset(
        Assets.logoutIcon,
        width: 16,
        height: 16,
        color: AppThemeData.lightColorScheme.primary,
      ),
      leftIconColor: Colors.blue,
      buttonColor: Colors.white,
      height: 60,
      borderRadius: BorderRadius.circular(12.0),
      onPressed: () {
        _showLogoutDialog(context);
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogWidget(
          title: "Xác nhận đăng xuất",
          content: "Bạn có muốn đăng xuất khỏi ứng dụng?",
          buttons: [
            DialogButtonConfig(
              text: "Huỷ",
              onPressed: () {},
            ),
            DialogButtonConfig(
              text: "Đăng xuất",
              onPressed: () {
                _userStore.logout(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_acccountInformationStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(
              _acccountInformationStore.errorStore.errorMessage);
        }

        return SizedBox.shrink();
      },
    );
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('home_tv_error'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }
}
