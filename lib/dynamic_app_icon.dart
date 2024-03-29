import 'dart:async';

import 'package:flutter/services.dart';

class DynamicAppIcon {
  static const MethodChannel _channel = MethodChannel('dynamic_app_icon');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// Indicate whether the current platform supports dynamic app icons
  static Future<bool> get supportsAlternateIcons async {
    final bool supportsAltIcons =
        await _channel.invokeMethod('mSupportsAlternateIcons');
    return supportsAltIcons;
  }

  /// Fetch the current iconName
  ///
  /// Return null if the current icon is the default icon
  static Future<String?> getAlternateIconName() async {
    final String? altIconName =
        await _channel.invokeMethod('mGetAlternateIconName');
    return altIconName;
  }

  /// Set [iconName] as the current icon for the app
  ///
  /// Throw a [PlatformException] with description if
  /// it can't find [iconName] or there's any other error
  static Future setAlternateIconName(String? iconName) async {
    await _channel.invokeMethod(
      'mSetAlternateIconName',
      <String, dynamic>{'iconName': iconName},
    );
  }

  // For Android
  static Future<void> setupAppIcon(
      {required String iconName, required List<String> iconList}) async {
    if (!iconList.contains(iconName)) return;
    await _channel.invokeMethod("setupIconList", iconList);
    // final result =
    await _channel.invokeMethod<bool>('setupAppIcon', iconName);
    // return result;
  }
}
