import 'package:boilerplate/constants/app_theme.dart';
import 'package:flutter/material.dart';

class TextViewWidget extends StatelessWidget {
  final String title;
  final TextEditingController textController;
  final EdgeInsets padding;

  const TextViewWidget({
    Key? key,
    required this.title,
    required this.textController,
    this.padding = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          this.title,
          style: TextStyle(
            fontSize: AppThemeData.bodyText2FontSize,
            color: Colors.black,
            fontWeight: AppThemeData.bold,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          controller: this.textController,
          enabled: false,
          cursorColor: Colors.transparent,
          decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Color(0xFFC5C6CC), 
              ),
            ),
            filled: true,
            fillColor:
                Colors.grey.shade100,
          ),
          style: TextStyle(
            fontSize: AppThemeData.bodyText1FontSize,
            color: Color(0xFF8F9098), 
          ),
        ),
      ],
    );
  }
}
