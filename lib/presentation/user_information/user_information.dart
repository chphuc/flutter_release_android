import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/core/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/core/widgets/textview_widget.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/user_information/store/user_information_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class UserInformationScreen extends StatefulWidget {
  const UserInformationScreen({super.key});

  @override
  State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  final UserInformationStore _userInformationStore =
      getIt<UserInformationStore>();

  TextEditingController _userNameLoginController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _positionController = TextEditingController();
  TextEditingController _departmentController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // check to see if already called api
    if (!_userInformationStore.loading) {
      _userInformationStore.getUserInformation();
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
        if (_userInformationStore.loading) {
          return CustomProgressIndicatorWidget();
        } else if (_userInformationStore.fetchUserInformationsFuture.status ==
            FutureStatus.fulfilled) {
          // Update controllers here after the API call is complete
          _userNameLoginController.text =
              _userInformationStore.userInformation!.userName;
          _userNameController.text =
              _userInformationStore.userInformation!.surname +
                  " " +
                  _userInformationStore.userInformation!.name;
          _positionController.text =
              _userInformationStore.userInformation!.role;
          _departmentController.text =
              _userInformationStore.userInformation!.department;
          _emailController.text =
              _userInformationStore.userInformation!.emailAddress;

          return Material(child: _maincontent());
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  Widget _maincontent() {
    return Center(
      child: Column(
        children: [
          _userImage(),
          SizedBox(height: 20),
          _userInfo(),
        ],
      ),
    );
  }

  Widget _userImage() {
    return Container(
      color: Colors.white,
      padding: EdgeInsetsDirectional.symmetric(vertical: 8),
      child: Center(
        child: CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(Assets.avatarDefault),
        ),
      ),
    );
  }

  Widget _userInfo() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: Dimens.horizontal_padding,
        vertical: Dimens.vertical_padding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextViewWidget(
            title: 'Tên đăng nhập',
            textController: _userNameLoginController,
          ),
          SizedBox(
            height: 8,
          ),
          TextViewWidget(
            title: 'Tên người dùng',
            textController: _userNameController,
          ),
          SizedBox(
            height: 8,
          ),
          TextViewWidget(
            title: 'Chức vụ',
            textController: _positionController,
          ),
          SizedBox(
            height: 8,
          ),
          TextViewWidget(
            title: 'Đơn vị',
            textController: _departmentController,
          ),
          SizedBox(
            height: 8,
          ),
          TextViewWidget(
            title: 'Email',
            textController: _emailController,
          ),
        ],
      ),
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_userInformationStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(
              _userInformationStore.errorStore.errorMessage);
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
