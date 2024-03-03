import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/core/widgets/dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PickDateWidget extends StatelessWidget {
  final String title;
  final TextEditingController startDateController;
  final TextEditingController endDateController;

  const PickDateWidget({
    Key? key,
    required this.title,
    required this.startDateController,
    required this.endDateController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: AppThemeData.bodyText2FontSize,
              color: Colors.black,
              fontWeight: AppThemeData.bold,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                  child: _buildDateField(
                      startDateController, context, "Ngày bắt đầu")),
              SizedBox(width: 16),
              Expanded(
                  child: _buildDateField(
                      endDateController, context, "Ngày kết thúc")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(
      TextEditingController controller, BuildContext context, String hint) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: () => _selectDate(context, controller),
      decoration: InputDecoration(
        enabledBorder: _borderSide(),
        focusedBorder: _borderSide(width: 2, color: Colors.blue.shade800),
        hintText: hint,
        suffixIcon: IconButton(
          icon: Icon(
            Icons.calendar_month,
            size: 18,
            color: AppThemeData.lightColorScheme.primary,
          ),
          onPressed: () => _selectDate(context, controller),
        ),
      ),
      style: TextStyle(fontSize: AppThemeData.bodyText1FontSize),
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(2200),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            // Change the background color here
            backgroundColor: Colors.blue,
            // Change the border radius here
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          child: child ?? Container(),
        );
      },
    );

    if (picked != null) {
      if (controller == startDateController &&
          endDateController.text.isNotEmpty) {
        DateTime endDate =
            DateTime.parse(dateStringToISOFormat(endDateController.text));
        if (picked.isAfter(endDate)) {
          _showErrorDialog(context);
          return;
        }
      } else if (controller == endDateController &&
          startDateController.text.isNotEmpty) {
        DateTime startDate =
            DateTime.parse(dateStringToISOFormat(startDateController.text));
        if (picked.isBefore(startDate)) {
          _showErrorDialog(context);
          return;
        }
      }
      String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      controller.text = formattedDate;
    }
  }

  OutlineInputBorder _borderSide(
      {double width = 1.0, Color color = const Color(0xFFC5C6CC)}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: width,
        color: color,
      ),
    );
  }

  String dateStringToISOFormat(String dateString) {
    // Assuming the date format is 'dd/MM/yyyy'
    List<String> parts = dateString.split('/');
    return '${parts[2]}-${parts[1]}-${parts[0]}';
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogWidget(
          title: "Phạm vi ngày không hợp lệ",
          content:
              "Ngày đã chọn nằm sau ngày kết thúc. Vui lòng chọn phạm vi ngày hợp lệ.",
          isError: true,
          buttons: [
            DialogButtonConfig(
              text: "Đã hiểu",
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }
}
