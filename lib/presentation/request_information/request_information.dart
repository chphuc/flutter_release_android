import 'dart:io';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/core/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/request_information/store/request_information_store.dart';
import 'package:boilerplate/presentation/request_information/widget/action_widget.dart';
import 'package:boilerplate/presentation/request_information/widget/confirm_button_widget.dart';
import 'package:boilerplate/presentation/request_information/widget/detail_information_widget.dart';
import 'package:boilerplate/presentation/request_information/widget/image_field_widget.dart';
import 'package:boilerplate/presentation/request_information/widget/locate_field_widget.dart';
import 'package:boilerplate/presentation/request_information/widget/work_progress_widget.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class RequestInformationScreen extends StatefulWidget {
  const RequestInformationScreen({super.key});

  @override
  State<RequestInformationScreen> createState() =>
      _RequestInformationScreenState();
}

class _RequestInformationScreenState extends State<RequestInformationScreen> {
  final RequestInformationStore _requestInformationStore =
      getIt<RequestInformationStore>();
  int idAction = 1;
  TextEditingController reasonController = TextEditingController(text: '');
  TextEditingController specificReasonController = TextEditingController();
  List<File> imageFiles = [];

  void addImage(File imageFile) {
    imageFiles.add(imageFile);
    setState(() {});
  }

  void deleteImage(int index) {
    imageFiles.removeAt(index);
    setState(() {});
  }

  void onChangeIdAction(int id) {
    idAction = id;
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments != null && arguments is int) {
      if (!_requestInformationStore.loading) {
        _requestInformationStore.getRequestInformation(arguments);
      }
    } else {
      // Handle the case where arguments are not as expected
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thông tin yêu cầu',
          style: TextStyle(
            fontSize: AppThemeData.heading2FontSize,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.history,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.requestHistory);
            },
          ),
        ],
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
        return _requestInformationStore.loading
            ? CustomProgressIndicatorWidget()
            : Material(child: _maincontent());
      },
    );
  }

  Widget _maincontent() {
    return _requestInformationStore.requestInformation != null
        ? Padding(
            padding: EdgeInsets.symmetric(
              vertical: Dimens.vertical_padding,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DetailInformationWidget(
                      data: _requestInformationStore.requestInformation!),
                  SizedBox(height: 12),
                  WorkProgressWidget(
                      data: _requestInformationStore.requestInformation!),
                  SizedBox(height: 12),
                  Visibility(
                    visible: _requestInformationStore
                        .requestInformation!.progress.requiredPosition,
                    child: Column(
                      children: [
                        LocateFieldWidget(),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _requestInformationStore
                        .requestInformation!.progress.requiredImage,
                    child: Column(
                      children: [
                        ImageFieldWidget(
                          imageFiles: imageFiles,
                          addImage: addImage,
                          deleteImage: deleteImage,
                        ),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _requestInformationStore
                            .requestInformation!.actions.length >
                        0,
                    child: Column(
                      children: [
                        ActionWidget(
                          data: _requestInformationStore.requestInformation!,
                          idAction: idAction,
                          reasonController: reasonController,
                          specificReasonController: specificReasonController,
                          onChangeId: onChangeIdAction,
                        ),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                  ConfirmButtonWidget(),
                ],
              ),
            ),
          )
        : Center(child: Text('Vui lòng thử lại sau'));
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_requestInformationStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(
              _requestInformationStore.errorStore.errorMessage);
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
