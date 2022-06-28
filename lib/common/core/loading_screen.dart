import 'package:flutter/material.dart';

import '../widgets/app_screen_wrapper.dart';
import '../widgets/loading/app_loading_box.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScreenWrapper(
      child: Center(
        child: AppLoadingBox(
          color: Theme.of(context).colorScheme.background,
        ),
      ),
    );
  }
}
