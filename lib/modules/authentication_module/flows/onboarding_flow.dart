import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class OnboardingFlow extends StatelessWidget {
  static const purpose = 'onboarding';

  const OnboardingFlow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const AutoRouter();
}
