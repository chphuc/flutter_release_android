import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/core/widgets/droplistdown_widget.dart';
import 'package:boilerplate/core/widgets/textfield_widget.dart';
import 'package:boilerplate/domain/entity/request_information/request_information.dart';
import 'package:flutter/material.dart';

class ActionWidget extends StatefulWidget {
  final RequestInformation data;
  final int idAction;
  final TextEditingController reasonController;
  final TextEditingController specificReasonController;
  final void Function(int) onChangeId;

  const ActionWidget({
    super.key,
    required this.data,
    required this.idAction,
    required this.reasonController,
    required this.specificReasonController,
    required this.onChangeId,
  });

  @override
  State<ActionWidget> createState() => _ActionWidgetState();
}

class _ActionWidgetState extends State<ActionWidget> {
  bool isDropdownVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isDropdownVisible = !isDropdownVisible;
            });
          },
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
                bottomLeft: Radius.circular(0.0),
                bottomRight: Radius.circular(0.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hành động',
                  style: TextStyle(
                    fontSize: AppThemeData.subHeading1FontSize,
                    fontWeight: AppThemeData.bold,
                    color: Colors.black,
                  ),
                ),
                Icon(
                  isDropdownVisible
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Color(0xFF535353),
                ),
              ],
            ),
          ),
        ),
        _actionContent()
      ],
    );
  }

  Widget _actionContent() {
    return Visibility(
      visible: isDropdownVisible,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0.0),
            topRight: Radius.circular(0.0),
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0),
          ),
        ),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...widget.data.actions.map(
                  (action) => RadioListTile(
                    title: Text(action.actionName),
                    value: action.id,
                    groupValue: widget.idAction,
                    onChanged: (value) {
                      widget.onChangeId(value!);
                    },
                  ),
                ),
              ],
            ),
            _actionContentReason()
          ],
        ),
      ),
    );
  }

  Widget _actionContentReason() {
    return Visibility(
      visible: getRequiredReason(widget.idAction),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lý do',
              style: TextStyle(
                fontSize: AppThemeData.bodyText1FontSize,
                fontWeight: AppThemeData.bold,
                color: AppThemeData.lightColorScheme.primary,
              ),
            ),
            SizedBox(height: 12),
            DropListDownWidget(
              items: [
                DropdownItem('Khác', ''),
                DropdownItem('Item 1', 'item1'),
                DropdownItem('Item 2', 'item2'),
                DropdownItem('Item 3', 'item3'),
              ],
              controller: widget.reasonController,
              fontSize: AppThemeData.subHeading1FontSize,
              textColor: Color(0xFFB0B0B0),
              backgroundColor: Color(0xFFF5F5F5),
              borderRadius: 16.0,
              borderWidth: 0,
              borderColor: Colors.transparent,
            ),
            SizedBox(height: 12),
            TextFieldWidget(
              hint: "Nhập nội dung lý do",
              textFontSize: AppThemeData.subHeading1FontSize,
              textColor: Color(0xFFB0B0B0),
              textController: widget.specificReasonController,
              backgroundColor: Color(0xFFF5F5F5),
              borderWidth: 0,
              borderColor: Colors.transparent,
              borderRadius: 16.0,
              height: 120,
            ),
          ],
        ),
      ),
    );
  }

  bool getRequiredReason(int idAction) {
    return widget.data.actions
        .firstWhere((action) => action.id == idAction)
        .requiredReason;
  }
}
