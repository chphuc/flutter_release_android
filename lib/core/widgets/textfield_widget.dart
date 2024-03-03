import 'package:boilerplate/constants/app_theme.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String? title;
  final String? hint;
  final String? errorText;
  final bool? isObscure;
  final TextEditingController textController;
  final ValueChanged? onChanged;
  final double? borderRadius;
  final Color? backgroundColor;
  final double? borderWidth;
  final Color? borderColor;
  final double? textFontSize;
  final Color? textColor;
  final double? height;

  const TextFieldWidget({
    Key? key,
    this.title,
    required this.textController,
    this.errorText = "",
    this.hint = "",
    this.isObscure = false,
    this.onChanged,
    this.borderRadius = 0,
    this.backgroundColor = Colors.transparent,
    this.borderWidth = 2,
    this.borderColor = Colors.grey,
    this.textFontSize,
    this.textColor,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle commonStyle = TextStyle(
      fontSize: textFontSize ?? AppThemeData.bodyText2FontSize,
      color: textColor ?? Colors.black,
    );

    return SizedBox(
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (title != null)
            Text(
              title!,
              style: TextStyle(
                fontSize: AppThemeData.bodyText2FontSize,
                color: Colors.black,
                fontWeight: AppThemeData.bold,
              ),
            ),
          if (title != null) SizedBox(height: 8),
          Container(
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius!),
              border: Border.all(
                width: borderWidth!,
                color: borderColor!,
              ),
              color: backgroundColor!,
            ),
            child: TextField(
              controller: textController,
              onChanged: onChanged,
              cursorColor: Colors.transparent,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: hint,
                hintStyle: commonStyle,
              ),
              style: commonStyle,
              obscureText: isObscure!,
            ),
          ),
          if (errorText != null && errorText!.isNotEmpty)
            Column(
              children: [
                SizedBox(height: 8),
                Text(
                  errorText!,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: AppThemeData.bodyText2FontSize,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
