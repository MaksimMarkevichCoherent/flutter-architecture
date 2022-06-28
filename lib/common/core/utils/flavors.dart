import 'package:flutter/material.dart';

import 'logger.dart';

enum Flavor {
  dev,
  stage,
  prod,
}

class FlavorValues {
  FlavorValues({required this.bannerColor});

  final Color bannerColor;

// Add other flavor specific values, e.g resources, URLs, databases here
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final FlavorValues values;
  static FlavorConfig? _instance;

  static void initFlavorType(String packageName) {
    if (packageName.endsWith('.dev')) {
      FlavorConfig(
        flavor: Flavor.dev,
        values: FlavorValues(
          bannerColor: Colors.red,
        ),
      );
    }  else if (packageName.endsWith('.stage')) {
      FlavorConfig(
        flavor: Flavor.stage,
        values: FlavorValues(
          bannerColor: Colors.green,
        ),
      );
    }  else {
      FlavorConfig(
        flavor: Flavor.prod,
        values: FlavorValues(
          bannerColor: Colors.transparent,
        ),
      );
    }
  }

  factory FlavorConfig({
    required Flavor flavor,
    required FlavorValues values,
  }) {
    final flavorString = flavor.toString().split('.').last;
    logger.d('Flavor: $flavorString');
    _instance ??= FlavorConfig._internal(
      flavor,
      flavorString,
      values,
    );
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.name, this.values);

  static FlavorConfig? get instance => _instance;

  static bool isDev() => _instance?.flavor == Flavor.dev;

  static bool isStage() => _instance?.flavor == Flavor.stage;

  static bool isProd() => _instance?.flavor == Flavor.prod;
}
