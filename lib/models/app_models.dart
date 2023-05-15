import 'dart:typed_data';
import 'package:flutter/material.dart';

class AppInfo {
  final String appName;
  final String packageName;
  final String versionName;
  final int versionCode;
  final Uint8List? appIcon;
  bool? isSelected;
  bool isLocked;

  AppInfo(
      {required this.appName,
      required this.packageName,
      required this.versionName,
      required this.versionCode,
      this.appIcon,
      this.isSelected = false,
      this.isLocked = false});
}
