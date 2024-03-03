import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/domain/entity/request_information/request_information.dart';
import 'package:boilerplate/presentation/request_information/widget/row_text_widget.dart';
import 'package:flutter/material.dart';

class WorkProgressWidget extends StatelessWidget {
  final RequestInformation data;
  const WorkProgressWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tiến độ công việc',
              style: TextStyle(
                fontSize: AppThemeData.subHeading1FontSize,
                fontWeight: AppThemeData.bold,
                color: AppThemeData.lightColorScheme.primary,
              ),
            ),
            SizedBox(height: 16),
            RowTextWidget(
              startText: 'Tiến độ',
              endText:
                  '${data.progress.stepName} - ${data.statusName}',
            ),
          ],
        ),
      ),
    );
  }
}
