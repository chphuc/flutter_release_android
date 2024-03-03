import 'package:boilerplate/presentation/notifycation/widget/notification_item_widget.dart';
import 'package:flutter/material.dart';

class NotificationListWidget extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  const NotificationListWidget({
    super.key,
    required this.data,
  });

  @override
  State<NotificationListWidget> createState() => _NotificationListWidgetState();
}

class _NotificationListWidgetState extends State<NotificationListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.data.length,
      itemBuilder: (context, index) {
        return index == 0
            ? NotificationItemWidget(
                data: widget.data[index],
              )
            : Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: NotificationItemWidget(
                  data: widget.data[index],
                ),
              );
      },
    );
  }
}
