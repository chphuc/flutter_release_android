import 'package:boilerplate/constants/app_theme.dart';
import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  final String title;
  final String content;
  final bool isError;
  final List<DialogButtonConfig> buttons;

  DialogWidget({
    required this.title,
    required this.content,
    this.isError = false,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: isError ? Colors.red : Colors.black,
              fontSize: AppThemeData.heading2FontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            content,
            style: TextStyle(
              color: isError ? Colors.red : Colors.black,
              fontSize: AppThemeData.bodyText1FontSize,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Divider(
              height: 2,
              color: Color(0xFFE7E7E7),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: buttons
                .map((buttonConfig) => TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        buttonConfig.onPressed();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            buttonConfig.bgColor ?? Colors.transparent),
                      ),
                      child: Text(
                        buttonConfig.text,
                        style: TextStyle(
                          fontSize: AppThemeData.bodyText1FontSize,
                          color: isError
                              ? Colors.red
                              : buttonConfig.textColor ??
                                  AppThemeData.lightColorScheme.primary,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class DialogButtonConfig {
  final String text;
  final VoidCallback onPressed;
  final Color? bgColor;
  final Color? textColor;

  DialogButtonConfig({
    required this.text,
    required this.onPressed,
    this.bgColor,
    this.textColor,
  });
}
