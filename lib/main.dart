import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';

import 'common/core/app_manager.dart';
import 'common/core/utils/error_handler.dart';
import 'common/core/utils/flavors.dart';
import 'firebase_options.dart';

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      /// Should be executed before EasyLocalization and Firebase initialization.
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

      /// Preserve splash screen until the app layouts are built and authentication is resolved.
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      await PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        FlavorConfig.initFlavorType(packageInfo.packageName);
      });

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      runApp(const AppManager());
    },
    handleFlutterFatalError,
  );
}
