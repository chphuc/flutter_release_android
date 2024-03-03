import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/core/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/home/store/home_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomeScreen extends StatefulWidget {
  final Function(int) onNavigateToRequest;

  const HomeScreen({
    super.key,
    required this.onNavigateToRequest,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeStore _homeStore = getIt<HomeStore>();

  @override
  void initState() {
    super.initState();

    _homeStore.getStatusBarRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trang chủ',
          style: TextStyle(
            fontSize: AppThemeData.heading2FontSize,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          _handleErrorMessage(),
          _buildMainContent(),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _homeStore.statusBarRequestLoading
            ? CustomProgressIndicatorWidget()
            : Material(child: _maincontent());
      },
    );
  }

  Widget _maincontent() {
    return _homeStore.statusBarRequestList!.length > 0
        ? Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimens.horizontal_padding,
              vertical: Dimens.vertical_padding,
            ),
            child: _statusBarRequests())
        : Center(child: Text("Khay yêu cầu không tồn tại"));
  }

  Widget _statusBarRequests() {
    return ListView.builder(
      itemCount: _homeStore.statusBarRequestList!.length,
      itemBuilder: (context, index) {
        final request =
            _homeStore.statusBarRequestList!.statusBarRequests[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: GestureDetector(
            onTap: () => widget.onNavigateToRequest(index),
            child: _statusBarRequest(
              request.statusRack,
              request.count,
            ),
          ),
        );
      },
    );
  }

  Widget _statusBarRequest(String status, int quantity) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 3,
            blurRadius: 3,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: Container(
        // Add a left border
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Colors.grey, // set the color of the left border
              width: 7.0, // set the width of the left border
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Yêu cầu $status',
                      style: TextStyle(
                        fontSize: AppThemeData.subHeading2FontSize,
                        fontWeight: AppThemeData.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Tổng cộng: $quantity',
                      style: TextStyle(
                        fontSize: AppThemeData.bodyText1FontSize,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.navigate_next),
            ],
          ),
        ),
      ),
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_homeStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_homeStore.errorStore.errorMessage);
        }

        return SizedBox.shrink();
      },
    );
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('home_tv_error'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }
}
