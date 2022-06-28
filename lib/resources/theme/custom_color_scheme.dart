import 'package:flutter/material.dart';

import 'palette.dart';

extension CustomColorScheme on ColorScheme {
  Color get primaryText => (brightness == Brightness.light) ? Palette.primary0 : Palette.primary0;

  Color get primaryLightText => (brightness == Brightness.light) ? Palette.primary200 : Palette.primary200;

  Color get secondaryText => (brightness == Brightness.light) ? Palette.primary700 : Palette.primary700;

  Color get actionSheetItemText => (brightness == Brightness.light) ? Palette.primary1000 : Palette.primary1000;

  Color get actionSheetInactiveText => (brightness == Brightness.light) ? Palette.primary600 : Palette.primary600;

  Color get actionSheetItemBackground => (brightness == Brightness.light) ? Palette.primary200 : Palette.primary200;

  Color get listItemIcon => (brightness == Brightness.light) ? Palette.primary600 : Palette.primary600;

  Color get topBarItem => (brightness == Brightness.light) ? Palette.primary900 : Palette.primary900;

  Color get inputLabel => (brightness == Brightness.light) ? Palette.primary800 : Palette.primary800;

  Color get placeholderText => (brightness == Brightness.light) ? Palette.placeholder : Palette.placeholder;

  Color get linkText => (brightness == Brightness.light) ? Palette.link : Palette.link; // used to be Color(0xFF1B279C);

  Color get icon => (brightness == Brightness.light) ? Palette.placeholder : Palette.placeholder;

  Color get border => (brightness == Brightness.light) ? Palette.primary500 : Palette.primary500;

  Color get activeIndicator => (brightness == Brightness.light) ? Palette.link : Palette.link;

  Color get pinpadButton => (brightness == Brightness.light) ? Palette.primary400 : Palette.primary400;

  Color get activeBorder => (brightness == Brightness.light) ? Palette.link : Palette.link;

  Color get success =>
      (brightness == Brightness.light) ? Palette.success : Palette.success; // used to be Color(0xFF4ABA7E);

  Color get warning =>
      (brightness == Brightness.light) ? Palette.warning : Palette.warning; // used to be Color(0xFF4ABA7E);

  Color get separatorBoxSurface =>
      (brightness == Brightness.light) ? Palette.separatorSurface : Palette.separatorSurface;

  Color get containerSurface => (brightness == Brightness.light) ? Palette.surface : Palette.surface;

  Color get containerPrimary => (brightness == Brightness.light) ? Palette.primary : Palette.primary;

  Color get containerPrimary500 => (brightness == Brightness.light) ? Palette.primary500 : Palette.primary500;

  Color get containerDarkSurface => (brightness == Brightness.light) ? Palette.primary0 : Palette.primary0;

  Color get secondaryLight => (brightness == Brightness.light) ? Palette.secondaryLight : Palette.secondaryLight;

  Color get splashBackground =>
      (brightness == Brightness.light) ? Palette.splashBackground : Palette.splashBackgroundDark;
}
