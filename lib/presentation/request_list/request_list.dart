import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/constants/app_data.dart';
import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/core/widgets/droplistdown_widget.dart';
import 'package:boilerplate/core/widgets/pickdate_widget.dart';
import 'package:boilerplate/core/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/core/widgets/rounded_button_widget.dart';
import 'package:boilerplate/core/widgets/textfield_widget.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/request/request.dart';
import 'package:boilerplate/domain/repository/request/request_repository.dart';
import 'package:boilerplate/presentation/home/store/home_store.dart';
import 'package:boilerplate/presentation/request_list/store/request_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:boilerplate/utils/time/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';

class RequestListScreen extends StatefulWidget {
  const RequestListScreen({super.key});

  @override
  State<RequestListScreen> createState() => _RequestListScreenState();
}

class _RequestListScreenState extends State<RequestListScreen> {
  final RequestListStore _requestListStore = getIt<RequestListStore>();
  final HomeStore _homeStore = getIt<HomeStore>();
  final scrollController = ScrollController();
  TextEditingController idRequestController = TextEditingController();
  TextEditingController nameCustomerController = TextEditingController();
  TextEditingController startDateReceptionController = TextEditingController();
  TextEditingController endDateReceptionController = TextEditingController();
  TextEditingController startProcessingDateController = TextEditingController();
  TextEditingController endProcessingDateController = TextEditingController();
  TextEditingController departmentController = TextEditingController(text: '');
  TextEditingController currentStepController = TextEditingController(text: '');
  TextEditingController typeRequestController = TextEditingController(text: '');
  static const int maxResultCountDefault = 10;
  static const int loadMoreCount = 5;
  int maxResultCount = maxResultCountDefault;
  int skipCount = 0;
  bool isFirstTimeLoading = true;
  List<Map<String, dynamic>> _barRequests = AppData.barRequests;
  void Function(void Function())? _setStateBottom;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);

    _initializeData();
  }

  void _initializeData() {
    _fetchRequests();
    _fetchProcessingStep();
    _fetchRequestDepartment();
    _fetchRequestType();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _fetchRequests({bool loadMore = false}) {
    if (!loadMore) {
      setState(() {
        maxResultCount = maxResultCountDefault;
        skipCount = 0;
      });
    }
    _requestListStore.getRequests(
      RequestListParams(
        ReqCode: idRequestController.text,
        Customer: nameCustomerController.text,
        StatusRack: _homeStore
            .statusBarRequestList
            ?.statusBarRequests[_requestListStore.currentIndexBarRequest]
            .statusRack,
        ReceivingTimeMin: startDateReceptionController.text.isNotEmpty
            ? TimeUtils.convertDateFormat(startDateReceptionController.text)
            : '',
        ReceivingTimeMax: endDateReceptionController.text.isNotEmpty
            ? TimeUtils.convertDateFormat(endDateReceptionController.text)
            : '',
        ExecTimeMin: startProcessingDateController.text.isNotEmpty
            ? TimeUtils.convertDateFormat(startProcessingDateController.text)
            : '',
        ExecTimeMax: endProcessingDateController.text.isNotEmpty
            ? TimeUtils.convertDateFormat(endProcessingDateController.text)
            : '',
        ReqTypeName: typeRequestController.text,
        ReqUnitName: departmentController.text,
        ProgressName: currentStepController.text,
        SkipCount: skipCount,
        MaxResultCount: maxResultCount,
      ),
      loadMore,
    );
  }

  void _fetchProcessingStep() {
    _requestListStore.getProcessingSteps();
  }

  void _fetchRequestDepartment() {
    _requestListStore.getRequestDepartments();
  }

  void _fetchRequestType() {
    _requestListStore.getRequestTypes();
  }

  void _resetFilterField() {
    if (_setStateBottom == null) return;

    idRequestController.text = '';
    nameCustomerController.text = '';
    startDateReceptionController.text = '';
    endDateReceptionController.text = '';
    startProcessingDateController.text = '';
    endProcessingDateController.text = '';
    departmentController.text = '';
    currentStepController.text = '';
    typeRequestController.text = '';

    maxResultCount = maxResultCountDefault;
    skipCount = 0;

    _setStateBottom!(() {});
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent * 0.95) {
      setState(() {
        skipCount += maxResultCount;
        maxResultCount = loadMoreCount;
      });
      _fetchRequests(loadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Yêu cầu',
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
    return Material(child: _maincontent());
  }

  Widget _maincontent() {
    return Container(
      child: Column(
        children: [
          _search(),
          Visibility(
            visible: _homeStore.statusBarRequestList != null,
            child: _changeRequestStatus(),
          ),
          Expanded(
            child: Observer(
              builder: (context) {
                if (_requestListStore.requestLoading && isFirstTimeLoading) {
                  return CustomProgressIndicatorWidget();
                } else {
                  if (_requestListStore.requestList != null &&
                      !_requestListStore.requestList!.isEmpty) {
                    isFirstTimeLoading = false;
                    return _requests();
                  } else {
                    return Center(
                      child: Text('Danh sách yêu cầu không tồn tại'),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _search() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.horizontal_padding,
        vertical: Dimens.vertical_padding,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: idRequestController,
              onChanged: (value) {},
              cursorColor: Colors.transparent,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.blue.shade800,
                  ),
                ),
                hintText: 'Tìm theo mã yêu cầu',
                prefixIcon: Icon(Icons.search),
              ),
              style: TextStyle(
                fontSize: AppThemeData.bodyText1FontSize,
                color: Color(0xFF8F9098),
              ),
              onSubmitted: (value) {
                _fetchRequests();
              },
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            icon: SvgPicture.asset(
              Assets.filterIcon,
              width: 36,
              height: 36,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder: (BuildContext context,
                        void Function(void Function()) setStatateBottom) {
                      _setStateBottom = setStatateBottom;
                      return FractionallySizedBox(
                        heightFactor: 0.9,
                        child: _filterModal(),
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _filterModal() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Lọc yêu cầu',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: AppThemeData.subHeading1FontSize,
                    fontWeight: AppThemeData.bold,
                  ),
                ),
              ),
              // IconButton(
              //   icon: Icon(Icons.close),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
            ],
          ),
          SizedBox(height: 16),
          Divider(color: Colors.grey[400]),
          SizedBox(height: 16),
          Flexible(
            child: _filterFields(),
          ),
        ],
      ),
    );
  }

  Widget _filterFields() {
    final gapColumn = 16.0;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            _buildIdRequestField(),
            SizedBox(height: gapColumn),
            _buildNameCustomerField(),
            SizedBox(height: gapColumn),
            _buildDateReceptionField(),
            SizedBox(height: gapColumn),
            _buildProcessingDateField(),
            SizedBox(height: gapColumn),
            _buildDepartmentField(),
            SizedBox(height: gapColumn),
            _buildCurrentStepField(),
            SizedBox(height: gapColumn),
            _buildTypeRequestField(),
            SizedBox(height: gapColumn),
            _buildButtonField(),
          ],
        ),
      ),
    );
  }

  Widget _buildIdRequestField() {
    return TextFieldWidget(
      title: 'Mã yêu cầu',
      hint: 'Tìm theo mã yêu cầu',
      textController: idRequestController,
      textFontSize: AppThemeData.bodyText1FontSize,
      textColor: Color(0xFF8F9098),
      borderRadius: 4,
      borderWidth: 1,
      borderColor: Color(0xFFC5C6CC),
    );
  }

  Widget _buildNameCustomerField() {
    return TextFieldWidget(
      title: 'Tên khách hàng',
      hint: 'Tìm theo tên khách hàng yêu cầu',
      textController: nameCustomerController,
      textFontSize: AppThemeData.bodyText1FontSize,
      textColor: Color(0xFF8F9098),
      borderRadius: 4,
      borderWidth: 1,
      borderColor: Color(0xFFC5C6CC),
    );
  }

  Widget _buildDateReceptionField() {
    return PickDateWidget(
      title: "Ngày tiếp nhận",
      startDateController: startDateReceptionController,
      endDateController: endDateReceptionController,
    );
  }

  Widget _buildProcessingDateField() {
    return PickDateWidget(
      title: "Ngày xử lý",
      startDateController: startProcessingDateController,
      endDateController: endProcessingDateController,
    );
  }

  Widget _buildDepartmentField() {
    return DropListDownWidget(
      title: 'Đơn vị thực hiện yêu cầu',
      items: [
        DropdownItem('Tất cả', ''),
        ...generateDropdownItems(
            _requestListStore.requestDepartmentList?.data ?? [])
      ],
      controller: departmentController,
      fontSize: AppThemeData.bodyText1FontSize,
      textColor: Color(0xFF8F9098),
      borderRadius: 4.0,
      borderWidth: 1,
      borderColor: Color(0xFFC5C6CC),
    );
  }

  Widget _buildCurrentStepField() {
    return DropListDownWidget(
      title: 'Bước xử lý hiện tại',
      items: [
        DropdownItem('Tất cả', ''),
        ...generateDropdownItems(
            _requestListStore.processingStepList?.data ?? [])
      ],
      controller: currentStepController,
      fontSize: AppThemeData.bodyText1FontSize,
      textColor: Color(0xFF8F9098),
      borderRadius: 4.0,
      borderWidth: 1,
      borderColor: Color(0xFFC5C6CC),
    );
  }

  Widget _buildTypeRequestField() {
    return DropListDownWidget(
      title: 'Loại yêu cầu',
      items: [
        DropdownItem('Tất cả', ''),
        ...generateDropdownItems(_requestListStore.requestTypeList?.data ?? [])
      ],
      controller: typeRequestController,
      fontSize: AppThemeData.bodyText1FontSize,
      textColor: Color(0xFF8F9098),
      borderRadius: 4.0,
      borderWidth: 1,
      borderColor: Color(0xFFC5C6CC),
    );
  }

  List<DropdownItem> generateDropdownItems(List<String> items) {
    return items.map((item) => DropdownItem(item, item)).toList();
  }

  Widget _buildButtonField() {
    return Row(
      children: [
        Expanded(
          child: RoundedButtonWidget(
            buttonText: 'Thiết lập lại',
            textColor: AppThemeData.lightColorScheme.primary,
            buttonColor: Colors.white,
            buttonTextSize: AppThemeData.bodyText2FontSize,
            height: 46,
            borderRadius: BorderRadius.circular(12.0),
            borderWidth: 2,
            borderColor: AppThemeData.lightColorScheme.primary,
            onPressed: () async {
              _resetFilterField();
            },
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: RoundedButtonWidget(
            buttonText: 'Tìm kiếm',
            textColor: Colors.white,
            buttonColor: AppThemeData.lightColorScheme.primary,
            buttonTextSize: AppThemeData.bodyText2FontSize,
            height: 46,
            borderRadius: BorderRadius.circular(12.0),
            onPressed: () async {
              Navigator.of(context).pop();
              _fetchRequests();
            },
          ),
        ),
      ],
    );
  }

  Widget _changeRequestStatus() {
    // List<String> shortTitleBarRequests = List<String>.from(
    //     _barRequests.map((map) => map['shortTitle'] as String));

    void _onTap(int index) {
      setState(() {
        _requestListStore.setCurrentIndexBarRequest(index);
        _fetchRequests();
      });
    }

    return Observer(
      builder: (context) {
        return Container(
          height: 40.0,
          color: Colors.white,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _homeStore.statusBarRequestList!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _onTap(index),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: index ==
                                  _requestListStore.currentIndexBarRequest
                              ? AppThemeData.lightColorScheme
                                  .primary // Color for active status
                              : Colors.transparent, // Color for inactive status
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _homeStore.statusBarRequestList!
                            .statusBarRequests[index].statusRack,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: AppThemeData.semiBold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _requests() {
    return ListView.builder(
      controller: scrollController,
      itemCount: _requestListStore.requestLoading
          ? _requestListStore.requestList!.requests.length + 1
          : _requestListStore.requestList!.requests.length,
      itemBuilder: (context, index) {
        if (index < _requestListStore.requestList!.requests.length) {
          final request = _requestListStore.requestList!.requests[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _buildRequestContainer(request),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildRequestContainer(Request request) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.requestInformation,
          arguments: request.id,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.horizontal_padding,
          vertical: Dimens.vertical_padding,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            _buildRequestText("Tên khách hàng", request.customer),
            _divider(),
            _buildRequestText("Loại yêu cầu", request.reqTypeName),
            _divider(),
            _buildRequestText(
              "Bước xử lý hiện tại",
              "Tiếp nhận yêu cầu",
              secondTextColor: AppThemeData.lightColorScheme.primary,
            ),
            _divider(),
            _buildRequestTimeAndStatus(
              request.displayPeriod,
              request.requiredCompletionTime,
              request.status,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestText(String title, String content,
      {Color? secondTextColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildText(
            title,
            Colors.grey.shade800,
            fontWeight: AppThemeData.bold,
          ),
          _buildText(
            content,
            secondTextColor ?? Colors.black,
            fontWeight: AppThemeData.bold,
          ),
        ],
      ),
    );
  }

  Widget _buildText(String text, Color color, {FontWeight? fontWeight}) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: AppThemeData.bodyText1FontSize,
        fontWeight: fontWeight,
      ),
    );
  }

  Widget _buildRequestTimeAndStatus(
      bool displayPeriod, String requiredCompletionTime, String requestStatus) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          if (displayPeriod) _buildTimeInfo(requiredCompletionTime),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          _buildStatusContainer(requestStatus),
        ],
      ),
    );
  }

  Widget _buildTimeInfo(String requiredCompletionTime) {
    final isExpired = TimeUtils.hasTimeExpired(requiredCompletionTime);
    final timeDifference = TimeUtils.getTimeDifference(requiredCompletionTime);

    return Row(
      children: [
        _buildTimeIcon(isExpired),
        SizedBox(width: 8),
        _buildText(
          '${isExpired ? "Đã hết hạn" : "Còn thời hạn"} - $timeDifference',
          isExpired ? Colors.red : AppThemeData.lightColorScheme.primary,
          fontWeight: AppThemeData.bold,
        ),
      ],
    );
  }

  Widget _buildTimeIcon(bool isExpired) {
    return Icon(
      Icons.info,
      color: isExpired ? Colors.red : AppThemeData.lightColorScheme.primary,
      size: 20,
    );
  }

  Widget _buildStatusContainer(String requestStatus) {
    Color statusColor = getStatusColor(requestStatus);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: statusColor,
          width: 1,
        ),
      ),
      child: _buildText(
        requestStatus,
        statusColor,
        fontWeight: AppThemeData.bold,
      ),
    );
  }

  Color getStatusColor(String requestStatus) {
    for (var request in _barRequests) {
      if (request['statusRequest'].contains(requestStatus)) {
        return request['statusColor'];
      }
    }
    return Colors.grey;
  }

  Widget _divider() {
    return Divider(color: Colors.grey.shade200);
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_requestListStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_requestListStore.errorStore.errorMessage);
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
