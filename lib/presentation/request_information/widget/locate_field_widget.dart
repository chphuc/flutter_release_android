import 'dart:math';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/core/widgets/dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LocateFieldWidget extends StatefulWidget {
  const LocateFieldWidget({super.key});

  @override
  State<LocateFieldWidget> createState() => _LocateFieldWidgetState();
}

class _LocateFieldWidgetState extends State<LocateFieldWidget> {
  late String lat;
  late String long;
  bool _findedPosition = false;
  bool _correctPosition = false;
  bool _isLoading = false;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        _showLocationPermissionDialog(
          context,
          "Quyền vị trí bị từ chối",
          "Vui lòng kích hoạt quyền vị trí để truy cập tính năng này.",
        );
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      _showLocationPermissionDialog(
        context,
        "Quyền vị trí bị từ chối",
        "Vui lòng đi tới cài đặt thiết bị để bật quyền truy cập vị trí.",
      );
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void _showLocationPermissionDialog(
      BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogWidget(
          title: title,
          content: content,
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

  void _onPressedLocate() {
    setState(() {
      _isLoading = true;
    });

    _determinePosition().then((value) {
      lat = '${value.latitude}';
      long = '${value.longitude}';

      if (!isWithinRadius()) {
        _showLocationPermissionDialog(
          context,
          "Định vị thất bại",
          "Vị trí hiện tại của bạn không nằm trong vùng quy định.",
        );
      } else {
        _showSuccessMessage("Định vị thành công",
            "Vị trí hiện tại của bạn nằm trong vùng quy định.");
      }

      setState(() {
        _correctPosition = isWithinRadius();
        _findedPosition = true;
        _isLoading = false;
      });
    });
  }

  bool isWithinRadius() {
    double latAddress = 10.537177;
    double longAddress = 107.4059558;
    double radius = 20.0;

    var distance = haversine(
      latAddress,
      longAddress,
      double.parse(lat),
      double.parse(long),
    );

    return distance <= radius;
  }

  double haversine(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371.0; // Radius of the Earth in kilometers
    var dLat = (lat2 - lat1) * pi / 180.0;
    var dLon = (lon2 - lon1) * pi / 180.0;
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * pi / 180.0) *
            cos(lat2 * pi / 180.0) *
            sin(dLon / 2) *
            sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var distance = R * c; // Distance in kilometers
    return distance;
  }

  Future<void> _openMap(String lat, String long) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    await canLaunchUrlString(googleUrl)
        ? await launchUrlString(googleUrl)
        : throw 'Could not launch $googleUrl';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: 16.0,
        right: 8.0,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'Định vị',
                style: TextStyle(
                  fontSize: AppThemeData.subHeading1FontSize,
                  fontWeight: AppThemeData.bold,
                  color: AppThemeData.lightColorScheme.primary,
                ),
              ),
              Visibility(
                visible: _findedPosition && !_isLoading,
                child: Row(
                  children: [
                    SizedBox(width: 8.0),
                    IconButton(
                      onPressed: () {
                        _openMap(lat, long);
                      },
                      icon: SvgPicture.asset(
                        Assets.mapsIcon,
                        width: 28,
                        height: 28,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          IconButton(
            onPressed: () {
              _onPressedLocate();
            },
            icon: _isLoading
                ? Container(
                    width: 24.0,
                    height: 24.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppThemeData.lightColorScheme.primary),
                    ),
                  )
                : _findedPosition
                    ? _correctPosition
                        ? SvgPicture.asset(
                            Assets.locationFilledIcon,
                            width: 30,
                            height: 30,
                            color: AppThemeData.lightColorScheme.primary,
                          )
                        : SvgPicture.asset(
                            Assets.locationFilledIcon,
                            width: 30,
                            height: 30,
                            color: Colors.red,
                          )
                    : SvgPicture.asset(
                        Assets.locationIcon,
                        width: 30,
                        height: 30,
                        color: AppThemeData.lightColorScheme.primary,
                      ),
          ),
        ],
      ),
    );
  }

  _showSuccessMessage(String title, String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createSuccess(
          message: message,
          title: title,
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }
}
