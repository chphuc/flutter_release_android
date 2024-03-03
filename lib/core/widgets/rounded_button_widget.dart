import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String buttonText;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final Color? buttonColor;
  final Color? textColor;
  final double? buttonTextSize;
  final FontWeight? fontWeight;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback onPressed;
  final double? borderWidth;
  final Color? borderColor;
  final TextAlign? textAlign;
  final Color? leftIconColor;
  final Color? rightIconColor;

  const RoundedButtonWidget({
    Key? key,
    required this.buttonText,
    this.leftIcon,
    this.rightIcon,
    this.buttonColor = Colors.blue,
    this.textColor = Colors.white,
    required this.onPressed,
    this.buttonTextSize = 14.0,
    this.fontWeight = FontWeight.normal,
    this.height = 20.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(0.0)),
    this.borderWidth = 0.0,
    this.borderColor = Colors.transparent,
    this.textAlign = TextAlign.center,
    this.leftIconColor = Colors.white,
    this.rightIconColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor!),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: borderRadius!,
            side: BorderSide(
              width: borderWidth!,
              color: borderColor!,
            ),
          ),
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          Size(double.infinity, height!),
        ),
      ),
      child: Row(
        children: [
          if (leftIcon != null)
            Padding(
              padding: EdgeInsets.only(right: 12),
              child: leftIcon!,
            ),
          Expanded(
            child: Text(
              buttonText,
              style: TextStyle(
                color: textColor,
                fontSize: buttonTextSize,
                fontWeight: fontWeight,
              ),
              textAlign: textAlign,
            ),
          ),
          if (rightIcon != null)
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: rightIcon!,
            ),
        ],
      ),
    );
  }
}