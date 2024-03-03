import 'package:boilerplate/constants/app_theme.dart';
import 'package:flutter/material.dart';

class DropdownItem {
  final String label;
  final String data;

  DropdownItem(this.label, this.data);
}

class DropListDownWidget extends StatefulWidget {
  final String? title;
  final List<DropdownItem> items;
  final TextEditingController controller;
  final EdgeInsets? padding;
  final double? borderRadius;
  final Color? backgroundColor;
  final double? borderWidth;
  final Color? borderColor;
  final double? fontSize;
  final Color? textColor;

  const DropListDownWidget({
    Key? key,
    this.title,
    required this.items,
    required this.controller,
    this.padding = const EdgeInsets.all(0),
    this.borderRadius,
    this.backgroundColor,
    this.borderWidth,
    this.borderColor,
    this.fontSize,
    this.textColor,
  }) : super(key: key);

  @override
  _DropListDownWidgetState createState() => _DropListDownWidgetState();
}

class _DropListDownWidgetState extends State<DropListDownWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.title != null)
          Text(
            widget.title!,
            style: TextStyle(
              fontSize: AppThemeData.bodyText2FontSize,
              color: Colors.black,
              fontWeight: AppThemeData.bold,
            ),
          ),
        SizedBox(height: widget.title != null ? 8 : 0),
        InputDecorator(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
              borderSide: BorderSide(
                width: widget.borderWidth ?? 2,
                color: widget.borderColor ?? Colors.blue.shade800,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
              borderSide: BorderSide(
                width: widget.borderWidth ?? 2,
                color: widget.borderColor ?? Colors.blue.shade800,
              ),
            ),
            filled: true,
            fillColor: widget.backgroundColor ?? Colors.transparent,
          ),
          child: DropdownButtonFormField<String>(
            value: widget.controller.text,
            onChanged: (String? value) {
              widget.controller.text = value ?? '';
              setState(() {});
            },
            items: widget.items
                .map((item) => DropdownMenuItem<String>(
                      value: item.data,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          item.label,
                          style: TextStyle(
                            fontSize: widget.fontSize ??
                                AppThemeData.bodyText2FontSize,
                            color: widget.textColor ?? Colors.black,
                          ),
                        ),
                      ),
                    ))
                .toList(),
            decoration: InputDecoration.collapsed(hintText: ''),
            isExpanded: true,
          ),
        ),
      ],
    );
  }
}
