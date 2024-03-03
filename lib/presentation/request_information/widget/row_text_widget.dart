import 'package:boilerplate/constants/app_theme.dart';
import 'package:flutter/material.dart';

class RowTextWidget extends StatelessWidget {
  final String startText;
  final String endText;
  final Color endTextColor;

  const RowTextWidget({
    super.key,
    required this.startText,
    required this.endText,
    this.endTextColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    List<String> lines = endText.split('-');
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              startText,
              style: TextStyle(
                fontSize: AppThemeData.subHeading1FontSize,
                fontWeight: AppThemeData.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  lines[0].trim(),
                  style: TextStyle(
                    fontSize: AppThemeData.subHeading1FontSize,
                    fontWeight: AppThemeData.bold,
                    color: endTextColor,
                  ),
                  textAlign: TextAlign.right,
                ),
                if (lines.length > 1)
                  Text(
                    '- ' + lines[1].trim(),
                    style: TextStyle(
                      fontSize: AppThemeData.subHeading1FontSize,
                      fontWeight: AppThemeData.bold,
                      color: endTextColor,
                    ),
                    textAlign: TextAlign.right,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
