import 'package:boilerplate/presentation/request_history/widget/timeline_item_widget.dart';
import 'package:flutter/material.dart';

class TimelineWidget extends StatefulWidget {
  final List<Map<String, dynamic>> timelineData;
  const TimelineWidget({
    super.key,
    required this.timelineData,
  });

  @override
  State<TimelineWidget> createState() => _TimelineWidgetState();
}

class _TimelineWidgetState extends State<TimelineWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.timelineData.length,
      itemBuilder: (context, index) {
        return TimelineItemWidget(
          data: widget.timelineData[index],
          index: index,
          canShowMore: true,
        );
      },
    );
  }
}
