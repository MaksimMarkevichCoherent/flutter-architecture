import '../common/core/utils/flavors.dart';
import '../resources/customization_config.dart';

class Environments {
  Environments(this.baseUrl);

  final String baseUrl;

  // ignore: prefer_constructors_over_static_methods
  static Environments get current {
    var url = Environments.dev();
    if (FlavorConfig.isDev()) {
      url = Environments.dev();
    }  else if (FlavorConfig.isStage()) {
      url = Environments.stage();
    } else {
      url = Environments.prod();
    }

    return url;
  }

  static bool get productionFlavorUsed => FlavorConfig.isStage() || FlavorConfig.isProd();

  factory Environments.dev() => Environments(CustomizationConfig.devUrl);

  factory Environments.stage() => Environments(CustomizationConfig.stageUrl);

  factory Environments.prod() => Environments(CustomizationConfig.prodUrl);

  @override
  String toString() => baseUrl;
}
