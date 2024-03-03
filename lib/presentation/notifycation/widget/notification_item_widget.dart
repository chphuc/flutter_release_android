import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotificationItemWidget extends StatefulWidget {
  final Map<String, dynamic> data;

  const NotificationItemWidget({
    super.key,
    required this.data,
  });

  @override
  State<NotificationItemWidget> createState() => _NotificationItemWidgetState();
}

class _NotificationItemWidgetState extends State<NotificationItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: widget.data['seen'] ? Color(0xFFE9F0F6) : Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleText(
            widget.data['title'],
            widget.data['receivingTime'],
          ),
          SizedBox(height: 8.0),
          _contentText(
            widget.data['requestType'],
            widget.data['requestCode'],
            widget.data['requiredCompletionTime'],
          )
        ],
      ),
    );
  }

  Widget _titleText(String title, String time) {
    return Row(
      children: [
        if (widget.data['seen'])
          Row(
            children: [
              SvgPicture.asset(Assets.circleIcon,
                  width: 16,
                  height: 16,
                  color: AppThemeData.lightColorScheme.primary),
              SizedBox(width: 8.0)
            ],
          ),
        Text(
          title,
          style: TextStyle(
            color: AppThemeData.lightColorScheme.primary,
            fontSize: AppThemeData.subHeading2FontSize,
            fontWeight:
                widget.data['seen'] ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        SizedBox(width: 8.0),
        Text(
          "30 phút trước",
          style: TextStyle(
            color: Color(0xFF595959),
            fontSize: AppThemeData.subHeading2FontSize,
          ),
        ),
      ],
    );
  }

  Widget _contentText(String requestType, String requestCode, String time) {
    return Text(
      "Có một yêu cầu ${requestType} Mã yêu cầu: ${requestCode} đang được chờ tiếp nhận đến ngày 20/06/2023",
      style: TextStyle(
        color: Color(0xFF686868),
      ),
    );
  }
}
