import 'package:flutter/material.dart';

import 'app_color_scheme.dart';
import 'app_typography.dart';
import 'palette.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    appBarTheme: _appBarTheme(AppColorScheme.lightScheme),
    inputDecorationTheme: _inputDecorationThemeLight(AppColorScheme.lightScheme),
    scaffoldBackgroundColor: AppColorScheme.lightScheme.background,
    errorColor: AppColorScheme.lightScheme.error,
    colorScheme: AppColorScheme.lightScheme,
    textTheme: _textThemeLight,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColorScheme.lightScheme.primaryContainer,
      cursorColor: AppColorScheme.lightScheme.onSecondary,
    ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    appBarTheme: _appBarTheme(AppColorScheme.darkScheme),
    inputDecorationTheme: _inputDecorationThemeDark(AppColorScheme.darkScheme),
    scaffoldBackgroundColor: AppColorScheme.darkScheme.background,
    errorColor: AppColorScheme.darkScheme.error,
    colorScheme: AppColorScheme.darkScheme,
    textTheme: _textThemeDark,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColorScheme.darkScheme.primaryContainer,
      cursorColor: AppColorScheme.darkScheme.onSecondary,
    ),
  );

  static AppBarTheme _appBarTheme(ColorScheme colorScheme) => AppBarTheme(
        centerTitle: true,
        elevation: 0,
        color: colorScheme.background,
      );

  static InputDecorationTheme _inputDecorationThemeLight(ColorScheme colorScheme) => InputDecorationTheme(
        alignLabelWithHint: true,
        errorMaxLines: 2,
        labelStyle: const TextStyle(color: Palette.placeholder),
        hintStyle: const TextStyle(color: Palette.primary700),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1.6,
            color: colorScheme.primary,
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1.6,
            color: colorScheme.error,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Palette.primary500),
        ),
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Palette.primary500),
        ),
      );

  static InputDecorationTheme _inputDecorationThemeDark(ColorScheme colorScheme) => InputDecorationTheme(
        alignLabelWithHint: true,
        errorMaxLines: 2,
        labelStyle: const TextStyle(color: Palette.placeholder),
        hintStyle: const TextStyle(color: Palette.primary700),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1.6,
            color: colorScheme.primary,
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1.6,
            color: colorScheme.error,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Palette.primary500),
        ),
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Palette.primary500),
        ),
      );
}

TextTheme _textThemeLight = TextTheme(
  headline1: AppTextStyles.r34.copyWith(color: Palette.primary0),
  headline2: AppTextStyles.r28.copyWith(color: Palette.primary0),
  headline3: AppTextStyles.r24.copyWith(color: Palette.primary0),
  headline4: AppTextStyles.r18.copyWith(color: Palette.primary0),
  headline5: AppTextStyles.r16.copyWith(color: Palette.primary0),
  headline6: AppTextStyles.r14.copyWith(color: Palette.primary0),
  bodyText1: AppTextStyles.r12.copyWith(color: Palette.primary0),
  bodyText2: AppTextStyles.r9.copyWith(color: Palette.primary0),
  button: AppTextStyles.b16.copyWith(color: Palette.primary0),
  subtitle1: AppTextStyles.r16.copyWith(color: Palette.primary0),
);

TextTheme _textThemeDark = TextTheme(
  headline1: AppTextStyles.r34.copyWith(color: Palette.primary0),
  headline2: AppTextStyles.r28.copyWith(color: Palette.primary0),
  headline3: AppTextStyles.r24.copyWith(color: Palette.primary0),
  headline4: AppTextStyles.r18.copyWith(color: Palette.primary0),
  headline5: AppTextStyles.r16.copyWith(color: Palette.primary0),
  headline6: AppTextStyles.r14.copyWith(color: Palette.primary0),
  bodyText1: AppTextStyles.r12.copyWith(color: Palette.primary0),
  bodyText2: AppTextStyles.r9.copyWith(color: Palette.primary0),
  button: AppTextStyles.b16.copyWith(color: Palette.primary0),
  subtitle1: AppTextStyles.r16.copyWith(color: Palette.primary0),
);
