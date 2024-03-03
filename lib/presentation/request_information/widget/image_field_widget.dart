import 'dart:io';

import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/core/widgets/dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class ImageFieldWidget extends StatefulWidget {
  final List<File> imageFiles;
  final Function(File) addImage;
  final Function(int) deleteImage;
  const ImageFieldWidget({
    Key? key,
    required this.imageFiles,
    required this.addImage,
    required this.deleteImage,
  }) : super(key: key);

  @override
  State<ImageFieldWidget> createState() => _ImageFieldWidgetState();
}

class _ImageFieldWidgetState extends State<ImageFieldWidget> {
  bool isDropdownVisible = false;

  Future<void> _pickImage({required ImageSource source}) async {
    final returnImage = await ImagePicker().pickImage(source: source);

    if (returnImage != null) {
      Navigator.pop(context);
      widget.addImage(File(returnImage.path));
      setState(() {});
    }
  }

  void _showDeleteImageDialog(BuildContext context, int indexImage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogWidget(
          title: "Xác nhận xoá hình ảnh",
          content: "Bạn có muốn xoá hình ảnh này?",
          buttons: [
            DialogButtonConfig(
              text: "Huỷ",
              onPressed: () {},
            ),
            DialogButtonConfig(
              text: "Xác nhận",
              onPressed: () {
                widget.deleteImage(indexImage);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Thêm ảnh',
                  style: TextStyle(
                    fontSize: AppThemeData.subHeading1FontSize,
                    fontWeight: AppThemeData.bold,
                    color: AppThemeData.lightColorScheme.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () {
                setState(() {
                  isDropdownVisible = !isDropdownVisible;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hình ảnh đính kèm (${widget.imageFiles.length})',
                    style: TextStyle(
                      fontSize: AppThemeData.subHeading1FontSize,
                      fontWeight: AppThemeData.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  Icon(
                    isDropdownVisible
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Color(0xFF535353),
                  )
                ],
              ),
            ),
            Visibility(
              visible: isDropdownVisible,
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: GridView.count(
                      crossAxisCount: 3,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppThemeData.lightColorScheme.primary,
                                width: 1,
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                _showImagePickerModal(context);
                              },
                              icon: SvgPicture.asset(
                                Assets.addPhotoIcon,
                                width: 24,
                                height: 24,
                                color: AppThemeData.lightColorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                        ...widget.imageFiles.asMap().entries.map((entry) {
                          final index = entry.key;
                          final file = entry.value;
                          return Container(
                            margin: EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                Image.file(
                                  file,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      _showDeleteImageDialog(context, index);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(4.0),
                                      padding: EdgeInsets.all(4.0),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImagePickerModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Chọn phương thức tải ảnh",
                style: TextStyle(
                  fontSize: AppThemeData.heading1FontSize,
                  fontWeight: AppThemeData.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildSelectionButton(
                    context,
                    icon: SvgPicture.asset(Assets.galleryIcon),
                    text: 'Thư viện',
                    onTap: () {
                      _pickImage(source: ImageSource.gallery);
                    },
                  ),
                  _buildSelectionButton(
                    context,
                    icon: SvgPicture.asset(Assets.cameraIcon),
                    text: 'Camera',
                    onTap: () {
                      _pickImage(source: ImageSource.camera);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSelectionButton(BuildContext context,
      {required Widget icon, required String text, required Function onTap}) {
    return InkWell(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 80.0,
              height: 80.0,
              child: icon,
            ),
            SizedBox(height: 8.0),
            Text(
              text,
              style: TextStyle(
                fontSize: AppThemeData.subHeading1FontSize,
                fontWeight: AppThemeData.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
