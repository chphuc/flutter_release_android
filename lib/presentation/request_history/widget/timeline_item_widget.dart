import 'package:boilerplate/constants/app_theme.dart';
import 'package:flutter/material.dart';

class TimelineItemWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  final int index;
  final bool canShowMore;

  const TimelineItemWidget({
    super.key,
    required this.data,
    required this.index,
    required this.canShowMore,
  });

  @override
  State<TimelineItemWidget> createState() => _TimelineItemWidgetState();
}

class _TimelineItemWidgetState extends State<TimelineItemWidget> {
  GlobalKey<State<StatefulWidget>> _containerKey = GlobalKey();
  bool _showMore = false;
  double _containerHeight = 50.0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateContainerHeight();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color colorTitle =
        widget.index == 0 ? Color(0xFFA0A0A0) : Color(0xFFC3C3C3);
    final Color colorValue =
        widget.index == 0 ? Color(0xFF000000) : Color(0xFF828282);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: 2,
              height: _containerHeight,
              color: widget.index == 0
                  ? AppThemeData.lightColorScheme.primary
                  : Color(0xFFC3D6E5),
            ),
            CircleAvatar(
              radius: 5,
              backgroundColor: widget.index == 0
                  ? AppThemeData.lightColorScheme.primary
                  : Color(0xFFC3D6E5),
            ),
          ],
        ),
        SizedBox(width: 24),
        Expanded(
          child: Column(
            key: _containerKey,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data['title'],
                style: TextStyle(
                    fontSize: AppThemeData.subHeading1FontSize,
                    fontWeight: FontWeight.bold,
                    color: colorValue),
              ),
              if (widget.canShowMore) SizedBox(height: 8),
              if (widget.data['exacLocation'] != null)
                _descriptionText(
                  "Địa điểm thực hiện: ",
                  widget.data['exacLocation'],
                  colorTitle,
                  colorValue,
                ),
              if (widget.data['department'] != null)
                _descriptionText(
                  "Đơn vị yêu cầu: ",
                  widget.data['department'],
                  colorTitle,
                  colorValue,
                ),
              if (widget.data['times'] != null)
                ...widget.data['times']
                    .map((item) => _descriptionText(
                          "${item['title']} ",
                          item['value'],
                          colorTitle,
                          colorValue,
                        ))
                    .toList(),
              if (widget.data['status'] != null)
                _descriptionText(
                  "Trạng thái: ",
                  widget.data['status'],
                  colorTitle,
                  colorValue,
                ),
              Visibility(
                visible: _showMore,
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    if (widget.data['detail'] != null &&
                        widget.data['detail'].isNotEmpty)
                      Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.data['detail'].length,
                          itemBuilder: (context, index) {
                            return TimelineItemWidget(
                              data: widget.data['detail'][index],
                              index: index,
                              canShowMore: false,
                            );
                          },
                        ),
                      )
                  ],
                ),
              ),
              if (widget.canShowMore)
                Column(
                  children: [
                    SizedBox(height: 16),
                    Center(
                      child: InkWell(
                        onTap: () {
                          _updateContainerHeight();
                          _showMore = !_showMore;
                          setState(() {});
                        },
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                !_showMore
                                    ? Icons.expand_more
                                    : Icons.expand_less,
                                color: Color(0xFF535353),
                              ),
                              SizedBox(width: 4),
                              Text(
                                !_showMore ? 'Xem thêm' : 'Thu Gọn',
                                style: TextStyle(
                                  fontSize: AppThemeData.bodyText1FontSize,
                                  color: Color(0xFF535353),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ],
    );
  }

  Widget _descriptionText(
      String title, String value, Color colorTitle, Color colorValue) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              fontSize: AppThemeData.bodyText1FontSize,
              color: colorTitle,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: 16,
              color: colorValue,
            ),
          ),
        ],
      ),
    );
  }

  void _updateContainerHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newHeight = getHeight();
      if (_containerHeight != newHeight) {
        setState(() {
          _containerHeight = newHeight;
        });
      }
    });
  }

  double getHeight() {
    final RenderBox? renderBox =
        _containerKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final height = renderBox.size.height;
      return height;
    }
    return 50.0;
  }
}
