import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider extends ChangeNotifier {
  List<String> selectedPackages = [];
  Duration lockDuration = Duration();

  SharedPreferences? _prefs;

  SharedPreferences? get prefs => _prefs;

  SharedPreferencesProvider() {
    initializeSharedPreferences();
  }

  void initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    notifyListeners();
  }

  Future<void> saveAppIcon(String packageName, Uint8List appIcon) async {
    final key = _getAppIconKey(packageName);
    await _prefs?.setString(key, base64Encode(appIcon));
    print('App Icon for $packageName: $appIcon');
  }

  Uint8List? getAppIcon(String packageName) {
    final key = _getAppIconKey(packageName);
    final encodedIcon = _prefs?.getString(key);
    if (encodedIcon != null) {
      return base64Decode(encodedIcon);
    }
    return null;
  }

  Future<void> saveAppName(String packageName, String appName) async {
    final key = _getAppNameKey(packageName);
    await _prefs?.setString(key, appName);
    print('App Icon for $packageName: $appName');
  }

  String? getAppName(String packageName) {
    final key = _getAppNameKey(packageName);
    return _prefs?.getString(key);
  }

  String _getAppIconKey(String packageName) => 'app_icon_$packageName';

  String _getAppNameKey(String packageName) => 'app_name_$packageName';
}
