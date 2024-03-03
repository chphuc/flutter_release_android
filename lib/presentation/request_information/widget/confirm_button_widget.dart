import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/core/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';

class ConfirmButtonWidget extends StatelessWidget {
  const ConfirmButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RoundedButtonWidget(
        buttonText: "Xác nhận",
        textColor: Colors.white,
        buttonColor: AppThemeData.lightColorScheme.primary,
        height: 52,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        onPressed: () {},
      ),
    );
  }
}
