import '../common/core/app_manager.dart';

/// This file contains errors which can come from the backend.
///
/// To enable handling of a specific error:
/// 1. Add the new case at [getLocalizedErrorFromCode] with appropriate localization string
/// 2. Add the new entry at lib/l10n/app_en.arb
///
/// app_error.dart
///
/// String getLocalizedErrorFromCode(String code) {
/// ...
///   case 'ERROR_FROM_THE_BACKEND'
///     return tr.appropriateLocalizationString
/// ...
///
/// lib/l10n/app_en.arb
/// ...
/// "appropriateLocalizationString": "Appropriate Localization String"
/// ...

/// Get localized error from error code retrieved from the backend.
///
/// Returns localized string if the error exists.
/// Returns back the [code] if the error does not exist.
String getLocalizedErrorFromCode(String code) {
  switch (code) {
    case 'SOMETHING_WENT_WRONG':
      return "tr.errorSomethingWentWrong";
    default:
      return "tr.errorSomethingWentWrong";
  }
}

/// Get default error localized string
String getDefaultError() => "tr.errorSomethingWentWrong";

///Get error if PIN webview can't be loaded
String getPinWebViewError() => "tr.errorPinIsNotAvailableNow";
