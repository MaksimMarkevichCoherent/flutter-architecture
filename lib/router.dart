import 'package:auto_route/auto_route.dart';
import 'package:tapp/modules/move_money_module/move_money_module.dart';
import 'package:tapp/modules/operators_module/operators_module.dart';

import 'common/core/authenticated_screen.dart';
import 'common/core/loading_screen.dart';
import 'modules/authentication_module/authentication_module.dart';
import 'modules/authentication_module/flows/login_flow.dart';
import 'modules/authentication_module/flows/onboarding_flow.dart';
import 'modules/authentication_module/welcome_screen.dart';
import 'modules/home_module/dashboard_screen/dashboard_screen.dart';
import 'modules/home_module/home_module.dart';
import 'modules/settings_module/settings_module.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute<void>>[
    AutoRoute(
      page: LoadingScreen,
      path: 'loading',
    ),
    AutoRoute(
      page: AuthenticationModule,
      path: 'authentication',
      children: [
        RedirectRoute(
          path: '',
          redirectTo: 'welcome',
        ),
        AutoRoute<void>(
          page: WelcomeScreen,
          path: 'welcome',
        ),
        AutoRoute<void>(
          page: LoginFlow,
          path: 'login',
          children: [
            RedirectRoute(
              path: '',
              redirectTo: 'phone-number',
            ),
          ],
        ),
        AutoRoute<void>(
          page: OnboardingFlow,
          path: 'onboarding',
          children: [
            RedirectRoute(
              path: '',
              redirectTo: 'terms-and-conditions',
            ),
          ],
        ),
      ],
    ),
    AutoRoute(
      page: AuthenticatedScreen,
      path: 'authenticated',
      children: [
        AutoRoute<void>(
          page: HomeModule,
          path: 'home',
          initial: true,
          children: [
            AutoRoute<void>(
              page: DashboardScreen,
              path: 'dashboard',
              children: [],
            ),
            AutoRoute<void>(
              page: MoveMoneyModule,
              path: 'move-money',
            ),
            AutoRoute<void>(
              page: OperatorsModule,
              path: 'operators',
            ),
            AutoRoute<void>(
              page: SettingsModule,
              path: 'settings',
            ),
          ],
        ),
      ],
    ),
  ],
)
class $AppRouter {}
