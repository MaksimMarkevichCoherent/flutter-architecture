import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../common/core/app_manager.dart';
import '../../common/widgets/navigation/app_navigation_bar.dart';

class HomeModule extends StatelessWidget {
  const HomeModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        // DashboardRoute(),
        // MoveMoneyRoute(),
        // OperatorsRoute(),
        // SettingsModule(),
      ],
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          key: homeScaffoldKey,
          body: FadeTransition(
            opacity: animation,
            child: child,
          ),
          bottomNavigationBar: AppNavigationBar(
            activeIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
          ),
        );
      },
    );
  }
}
