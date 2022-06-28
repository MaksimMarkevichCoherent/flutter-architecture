import 'package:flutter/material.dart';

import 'palette.dart';

class AppColorScheme {
  static const ColorScheme lightScheme = ColorScheme.light(
    primary: Palette.primary,
    primaryContainer: Palette.primaryLight,
    error: Palette.error,
    onBackground: Palette.onBackground,
  );

  static const ColorScheme darkScheme = ColorScheme.dark(
    primary: Palette.primary,
    primaryContainer: Palette.primaryLight,
    onPrimary: Palette.background,
    error: Palette.error,
    onBackground: Palette.onBackground,
  );
}
