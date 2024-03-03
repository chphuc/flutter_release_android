import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/domain/entity/request_information/request_information.dart';
import 'package:boilerplate/presentation/request_information/widget/row_text_widget.dart';
import 'package:boilerplate/utils/time/time_utils.dart';
import 'package:flutter/material.dart';

class DetailInformationWidget extends StatefulWidget {
  final RequestInformation data;
  const DetailInformationWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<DetailInformationWidget> createState() =>
      _DetailInformationWidgetState();
}

class _DetailInformationWidgetState extends State<DetailInformationWidget> {
  static const int initialVisibleRowCount = 4;
  static const int expandedRowCount = 16;
  int visibleRowCount = initialVisibleRowCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông tin yêu cầu',
            style: TextStyle(
              fontSize: AppThemeData.subHeading1FontSize,
              fontWeight: AppThemeData.bold,
              color: AppThemeData.lightColorScheme.primary,
            ),
          ),
          SizedBox(height: 16),
          Column(
            children: [
              RowTextWidget(
                startText: 'Mã yêu cầu',
                endText: widget.data.reqCode,
              ),
              Divider(color: Color(0xFFE7E7E7)),
              RowTextWidget(
                startText: 'Trạng thái',
                endText: widget.data.statusName,
                endTextColor: AppThemeData.lightColorScheme.primary,
              ),
              Divider(color: Color(0xFFE7E7E7)),
              RowTextWidget(
                startText: 'Loại yêu cầu',
                endText: widget.data.reqTypeName,
                endTextColor: AppThemeData.lightColorScheme.primary,
              ),
              Divider(color: Color(0xFFE7E7E7)),
              RowTextWidget(
                startText: 'Tên khách hàng',
                endText: widget.data.customer,
              ),
              Divider(color: Color(0xFFE7E7E7)),
              Visibility(
                visible: visibleRowCount > initialVisibleRowCount,
                child: Column(
                  children: [
                    RowTextWidget(
                      startText: 'SĐT khách hàng',
                      endText: widget.data.phoneNumber,
                    ),
                    Divider(color: Color(0xFFE7E7E7)),
                    RowTextWidget(
                      startText: 'Thông tin tài sản đảm bảo',
                      endText: widget.data.collateral,
                    ),
                    Divider(color: Color(0xFFE7E7E7)),
                    RowTextWidget(
                      startText: 'Đơn vị yêu cầu',
                      endText: widget.data.reqUnitName,
                    ),
                    Divider(color: Color(0xFFE7E7E7)),
                    RowTextWidget(
                      startText: 'Nhân viên quản lý hồ sơ',
                      endText: widget.data.recordManagerName,
                    ),
                    Divider(color: Color(0xFFE7E7E7)),
                    RowTextWidget(
                      startText: 'Đơn vị thực hiện',
                      endText: widget.data.execUnitName,
                    ),
                    Divider(color: Color(0xFFE7E7E7)),
                    RowTextWidget(
                      startText: 'Nhân viên thực hiện',
                      endText: widget.data.execEmployeeName,
                    ),
                    Divider(color: Color(0xFFE7E7E7)),
                    RowTextWidget(
                      startText: 'Vùng thực hiện',
                      endText: widget.data.execArea,
                    ),
                    Divider(color: Color(0xFFE7E7E7)),
                    RowTextWidget(
                      startText: 'Địa điểm',
                      endText: widget.data.locationName,
                    ),
                    Divider(color: Color(0xFFE7E7E7)),
                    RowTextWidget(
                      startText: 'Địa chỉ',
                      endText: widget.data.address,
                    ),
                    Divider(color: Color(0xFFE7E7E7)),
                    RowTextWidget(
                      startText: 'Thời gian gửi yêu cầu',
                      endText: TimeUtils.convertDateFormatApiToDayMonthYear(
                        widget.data.receivingTime,
                      ),
                    ),
                    Divider(color: Color(0xFFE7E7E7)),
                    RowTextWidget(
                      startText: 'Thời gian thực hiện',
                      endText: TimeUtils.convertDateFormatApiToDayMonthYear(
                        widget.data.execTime,
                      ),
                    ),
                    Divider(color: Color(0xFFE7E7E7)),
                    RowTextWidget(
                      startText: 'Thời gian yêu cầu hoàn thành',
                      endText: TimeUtils.convertDateFormatApiToDayMonthYear(
                        widget.data.requiredCompletionTime,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: InkWell(
              onTap: () {
                _toggleRowCount();
              },
              child: Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      visibleRowCount <= initialVisibleRowCount
                          ? Icons.expand_more
                          : Icons.expand_less,
                      color: Color(0xFF535353),
                    ),
                    SizedBox(width: 4),
                    Text(
                      visibleRowCount <= initialVisibleRowCount
                          ? 'Xem thêm'
                          : 'Thu Gọn',
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
      ),
    );
  }

  void _toggleRowCount() {
    setState(() {
      visibleRowCount = (visibleRowCount == initialVisibleRowCount)
          ? expandedRowCount
          : initialVisibleRowCount;
    });
  }
}
