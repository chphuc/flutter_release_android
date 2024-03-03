import 'package:boilerplate/constants/app_theme.dart';
import 'package:flutter/material.dart';

class AppData {
  AppData._(); // private constructor to prevent instantiation

  static List<Map<String, dynamic>> get barRequests => _barRequests;

  static List<Map<String, dynamic>> _barRequests = [
    {
      "title": "Yêu cầu đang chờ tiếp nhận",
      "shortTitle": "Chờ tiếp nhận",
      "name": "Đang chờ xử lý",
      "showRequiredCompletionTime": true,
      "statusRequest": ['Chờ tiếp nhận'],
      "statusColor": AppThemeData.lightColorScheme.primary
    },
    {
      "title": "Yêu cầu chờ xử lý",
      "shortTitle": "Chờ xử lý",
      "name": "Chờ xử lý",
      "showRequiredCompletionTime": true,
      "statusRequest": ['Chờ xử lý'],
      "statusColor": AppThemeData.lightColorScheme.primary
    },
    {
      "title": "Yêu cầu đang xử lý",
      "shortTitle": "Đang xử lý",
      "name": "Đang xử lý",
      "showRequiredCompletionTime": true,
      "statusRequest": ['Đang xử lý'],
      "statusColor": AppThemeData.lightColorScheme.primary
    },
    {
      "title": "Yêu cầu đã hoàn tất xử lý",
      "shortTitle": "Đã xử lý",
      "name": "Đã hoàn tất xử lý",
      "showRequiredCompletionTime": true,
      "statusRequest": [
        'Thành công',
        'Không thành công',
        'Nhận phiếu hẹn',
        'Nhận kết quả'
      ],
      "statusColor": Colors.yellow
    },
    {
      "title": "Yêu cầu đang chờ xác nhận",
      "shortTitle": "Chờ xác nhận",
      "name": "Đang chờ xác nhận",
      "showRequiredCompletionTime": false,
      "statusRequest": ['Chờ xác nhận từ chối', 'Chờ xác nhận điều chỉnh'],
      "statusColor": Colors.green
    },
    {
      "title": "Yêu cầu đã từ chối xử lý",
      "shortTitle": "Đã từ chối",
      "name": "Đã từ chối xử lý",
      "showRequiredCompletionTime": false,
      "statusRequest": ['Từ chối'],
      "statusColor": Colors.red
    },
  ];
}
