import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/account_information/account_information.dart';
import 'package:boilerplate/presentation/home/home.dart';
import 'package:boilerplate/presentation/navigator/store/navigator_store.dart';
import 'package:boilerplate/presentation/notifycation/notifycation.dart';
import 'package:boilerplate/presentation/request_list/request_list.dart';
import 'package:boilerplate/presentation/request_list/store/request_store.dart';
import 'package:boilerplate/presentation/request_search/request_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({Key? key}) : super(key: key);

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  final NavigatorStore _navigatorStore = getIt<NavigatorStore>();
  final RequestListStore _requestListStore = getIt<RequestListStore>();

  late List<Widget> _NavigatorScreens;

  @override
  void initState() {
    super.initState();
    _NavigatorScreens = [
      _buildHomeScreen(),
      RequestListScreen(),
      RequestSearchScreen(),
      NotifycationScreen(),
      AccountInformationScreen(),
    ];
  }

  void _onTap(int index) {
    _navigatorStore.setCurrentIndexScreen(index);
  }

  void _onNavigateToRequest(int indexBarRequest) {
    _requestListStore.setCurrentIndexBarRequest(indexBarRequest);

    _onTap(1);
  }

  Widget _buildHomeScreen() {
    return HomeScreen(
      onNavigateToRequest: (indexBarRequest) =>
          _onNavigateToRequest(indexBarRequest),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Scaffold(
          body: _NavigatorScreens[_navigatorStore.currentIndexScreen],
          bottomNavigationBar: _MyBottomNavigationBar(),
        );
      },
    );
  }

  Widget _MyBottomNavigationBar() {
    return Container(
      height: 70,
      child: BottomNavigationBar(
        currentIndex: _navigatorStore.currentIndexScreen,
        onTap: _onTap,
        selectedItemColor: AppThemeData.lightColorScheme.primary,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: [
          _buildNavigationBarItem(Assets.homeIcon, 'Trang chủ', 0),
          _buildNavigationBarItem(Assets.requestIcon, 'Yêu cầu', 1),
          _buildNavigationBarItem(Assets.searchIcon, 'Tra cứu', 2),
          _buildNavigationBarItem(Assets.notifyIcon, 'Thông báo', 3),
          _buildNavigationBarItem(Assets.userIcon, 'Tài khoản', 4),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavigationBarItem(
      String iconAsset, String label, int index) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        iconAsset,
        width: 20,
        height: 20,
        color: _navigatorStore.currentIndexScreen == index
            ? AppThemeData.lightColorScheme.primary // Active color
            : Colors.grey, // Inactive color
      ),
      label: label,
    );
  }
}
