import 'package:flutter/material.dart';

enum ScreenType { mobile, tablet, desktop, desktopLarge }

ScreenType getScreenType(MediaQueryData mediaQuery) {
  var orientation = mediaQuery.orientation;

  double deviceWidth = 0;
  if (orientation == Orientation.landscape) {
    deviceWidth = mediaQuery.size.height;
  } else {
    deviceWidth = mediaQuery.size.width;
  }

  if (deviceWidth > 1200) {
    return ScreenType.desktopLarge;
  }

  if (deviceWidth > 900) {
    return ScreenType.desktop;
  }

  if (deviceWidth > 600) {
    return ScreenType.tablet;
  }

  return ScreenType.mobile;
}
