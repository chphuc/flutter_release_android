import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/core/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/presentation/notifycation/widget/notification_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class NotifycationScreen extends StatefulWidget {
  const NotifycationScreen({super.key});

  @override
  State<NotifycationScreen> createState() => _NotifycationScreenState();
}

class _NotifycationScreenState extends State<NotifycationScreen> {
  List<Map<String, dynamic>> notifications = [
    {
      "title": "Tiêu đề thông báo",
      "receivingTime": "",
      "requestType": "Công chứng",
      "requestCode": "YC912983",
      "requiredCompletionTime": "",
      "seen": true
    },
    {
      "title": "Tiêu đề thông báo",
      "receivingTime": "",
      "requestType": "Công chứng",
      "requestCode": "YC912983",
      "requiredCompletionTime": "",
      "seen": true
    },
    {
      "title": "Tiêu đề thông báo",
      "receivingTime": "",
      "requestType": "Công chứng",
      "requestCode": "YC912983",
      "requiredCompletionTime": "",
      "seen": false
    },
    {
      "title": "Tiêu đề thông báo",
      "receivingTime": "",
      "requestType": "Công chứng",
      "requestCode": "YC912983",
      "requiredCompletionTime": "",
      "seen": false
    },
    {
      "title": "Tiêu đề thông báo",
      "receivingTime": "",
      "requestType": "Công chứng",
      "requestCode": "YC912983",
      "requiredCompletionTime": "",
      "seen": false
    },
    {
      "title": "Tiêu đề thông báo",
      "receivingTime": "",
      "requestType": "Công chứng",
      "requestCode": "YC912983",
      "requiredCompletionTime": "",
      "seen": false
    },
    {
      "title": "Tiêu đề thông báo",
      "receivingTime": "",
      "requestType": "Công chứng",
      "requestCode": "YC912983",
      "requiredCompletionTime": "",
      "seen": false
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thông báo',
          style: TextStyle(
            fontSize: AppThemeData.heading2FontSize,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          _buildMainContent(),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return false
            ? CustomProgressIndicatorWidget()
            : Material(child: _maincontent());
      },
    );
  }

  Widget _maincontent() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: Dimens.vertical_padding,
          horizontal: Dimens.horizontal_padding),
      child: Container(
        width: double.infinity,
        child: NotificationListWidget(data: notifications),
      ),
    );
  }
}
