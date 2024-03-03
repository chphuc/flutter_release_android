import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter/material.dart';

class SettingLoginScreen extends StatefulWidget {
  const SettingLoginScreen({super.key});

  @override
  State<SettingLoginScreen> createState() => _SettingLoginScreenState();
}

class _SettingLoginScreenState extends State<SettingLoginScreen> {
  SharedPreferenceHelper? _sharedPrefsHelper;
  bool isSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cài đặt đăng nhập',
          style: TextStyle(
            fontSize: AppThemeData.heading2FontSize,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.horizontal_padding,
          vertical: Dimens.vertical_padding,
        ),
        child: Column(
          children: [
            _content(),
          ],
        ),
      ),
    );
  }

  Widget _content() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _leftSide()),
          _RightSide(),
        ],
      ),
    );
  }

  Widget _leftSide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Đăng nhập bằng vân tay/ khuôn mặt',
          style: TextStyle(
            fontSize: AppThemeData.heading1FontSize,
            fontWeight: AppThemeData.semiBold,
            color: AppThemeData.lightColorScheme.primary,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Bật chức năng này để có thể đăng nhập bằng vân tay hoặc khuôn mặt',
          style: TextStyle(
            fontSize: AppThemeData.bodyText1FontSize,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _RightSide() {
    return Container(
      child: Switch(
        value: isSwitch,
        onChanged: (value) {
          changeSwitch(value);
        },
        activeColor:
            Colors.white, // Set the color of the thumb when the switch is ON
        activeTrackColor:
            Colors.green, // Set the color of the track when the switch is ON
        inactiveThumbColor:
            Colors.white, // Set the color of the thumb when the switch is OFF
        inactiveTrackColor:
            Colors.grey, // Set the color of the track when the switch is OFF
      ),
    );
  }

  Future<void> changeSwitch(value) async {
    setState(() {
      isSwitch = value;
    });
    await _sharedPrefsHelper?.setFingerprintLogin(value);
  }
}
