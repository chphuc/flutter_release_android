import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/core/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/presentation/request_history/widget/timeline_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class RequestHistoryScreen extends StatefulWidget {
  const RequestHistoryScreen({super.key});

  @override
  State<RequestHistoryScreen> createState() => _RequestHistoryScreenState();
}

class _RequestHistoryScreenState extends State<RequestHistoryScreen> {
  List<Map<String, dynamic>> timelineData = [
    {
      'title': 'Thực hiện yêu cầu',
      'exacLocation': 'Lý Thường Kiệt',
      'times': [
        {
          'title': 'Thời gian gửi yêu cầu',
          'value': '8:00 12/12/2023',
        },
        {
          'title': 'Thời gian tiếp nhận',
          'value': '8:00 12/12/2023',
        },
      ],
      'status': 'Hoàn thành',
      'detail': [
        {
          'title': 'Chờ xử lý',
          'times': [
            {
              'title': 'Thời gian chờ',
              'value': '8:00 12/12/2023',
            }
          ],
        },
        {
          'title': 'Đang xử lý',
          'times': [
            {
              'title': 'Thời gian chờ',
              'value': '8:00 12/12/2023',
            }
          ],
        },
        {
          'title': 'Hoàn thành',
        },
      ]
    },
    {
      'title': 'Tiếp nhận hồ sơ',
      'department': 'Phòng ban Thủ Đức',
      'times': [
        {
          'title': 'Thời gian gửi yêu cầu',
          'value': '8:00 12/12/2023',
        },
        {
          'title': 'Thời gian tiếp nhận',
          'value': '8:00 12/12/2023',
        },
      ],
      'status': 'Hoàn thành',
      'detail': [
        {
          'title': 'Chờ xử lý',
          'times': [
            {
              'title': 'Thời gian chờ',
              'value': '8:00 12/12/2023',
            }
          ],
        },
        {
          'title': 'Đang xử lý',
          'times': [
            {
              'title': 'Thời gian chờ',
              'value': '8:00 12/12/2023',
            }
          ],
        },
        {
          'title': 'Hoàn thành',
        },
      ]
    },
    {
      'title': 'Tiếp nhận yêu cầu',
      'times': [
        {
          'title': 'Thời gian gửi yêu cầu',
          'value': '8:00 12/12/2023',
        },
        {
          'title': 'Thời gian tiếp nhận',
          'value': '8:00 12/12/2023',
        },
      ],
      'status': 'Hoàn thành',
      'detail': [
        {
          'title': 'Chờ xử lý',
          'times': [
            {
              'title': 'Thời gian chờ',
              'value': '8:00 12/12/2023',
            }
          ],
        },
        {
          'title': 'Đang xử lý',
          'times': [
            {
              'title': 'Thời gian chờ',
              'value': '8:00 12/12/2023',
            }
          ],
        },
        {
          'title': 'Hoàn thành',
        },
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lịch sử',
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
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: TimelineWidget(timelineData: timelineData),
      ),
    );
  }
}
