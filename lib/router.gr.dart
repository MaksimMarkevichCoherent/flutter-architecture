// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;

import 'common/core/authenticated_screen.dart' as _i3;
import 'common/core/loading_screen.dart' as _i1;
import 'modules/authentication_module/authentication_module.dart' as _i2;
import 'modules/authentication_module/flows/login_flow.dart' as _i5;
import 'modules/authentication_module/flows/onboarding_flow.dart' as _i6;
import 'modules/authentication_module/welcome_screen.dart' as _i4;
import 'modules/home_module/dashboard_screen/dashboard_screen.dart' as _i8;
import 'modules/home_module/home_module.dart' as _i7;
import 'modules/move_money_module/move_money_module.dart' as _i9;
import 'modules/operators_module/operators_module.dart' as _i10;
import 'modules/settings_module/settings_module.dart' as _i11;

class AppRouter extends _i12.RootStackRouter {
  AppRouter([_i13.GlobalKey<_i13.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    LoadingRoute.name: (routeData) {
      return _i12.MaterialPageX<void>(
          routeData: routeData, child: const _i1.LoadingScreen());
    },
    AuthenticationModule.name: (routeData) {
      return _i12.MaterialPageX<void>(
          routeData: routeData, child: const _i2.AuthenticationModule());
    },
    AuthenticatedRoute.name: (routeData) {
      return _i12.MaterialPageX<void>(
          routeData: routeData, child: const _i3.AuthenticatedScreen());
    },
    WelcomeRoute.name: (routeData) {
      final args = routeData.argsAs<WelcomeRouteArgs>(
          orElse: () => const WelcomeRouteArgs());
      return _i12.MaterialPageX<void>(
          routeData: routeData, child: _i4.WelcomeScreen(key: args.key));
    },
    LoginFlow.name: (routeData) {
      return _i12.MaterialPageX<void>(
          routeData: routeData, child: const _i5.LoginFlow());
    },
    OnboardingFlow.name: (routeData) {
      return _i12.MaterialPageX<void>(
          routeData: routeData, child: const _i6.OnboardingFlow());
    },
    HomeModule.name: (routeData) {
      return _i12.MaterialPageX<void>(
          routeData: routeData, child: const _i7.HomeModule());
    },
    DashboardRoute.name: (routeData) {
      return _i12.MaterialPageX<void>(
          routeData: routeData, child: const _i8.DashboardScreen());
    },
    MoveMoneyModule.name: (routeData) {
      return _i12.MaterialPageX<void>(
          routeData: routeData, child: const _i9.MoveMoneyModule());
    },
    OperatorsModule.name: (routeData) {
      return _i12.MaterialPageX<void>(
          routeData: routeData, child: const _i10.OperatorsModule());
    },
    SettingsModule.name: (routeData) {
      return _i12.MaterialPageX<void>(
          routeData: routeData, child: const _i11.SettingsModule());
    }
  };

  @override
  List<_i12.RouteConfig> get routes => [
        _i12.RouteConfig(LoadingRoute.name, path: 'loading'),
        _i12.RouteConfig(AuthenticationModule.name,
            path: 'authentication',
            children: [
              _i12.RouteConfig('#redirect',
                  path: '',
                  parent: AuthenticationModule.name,
                  redirectTo: 'welcome',
                  fullMatch: true),
              _i12.RouteConfig(WelcomeRoute.name,
                  path: 'welcome', parent: AuthenticationModule.name),
              _i12.RouteConfig(LoginFlow.name,
                  path: 'login',
                  parent: AuthenticationModule.name,
                  children: [
                    _i12.RouteConfig('#redirect',
                        path: '',
                        parent: LoginFlow.name,
                        redirectTo: 'phone-number',
                        fullMatch: true)
                  ]),
              _i12.RouteConfig(OnboardingFlow.name,
                  path: 'onboarding',
                  parent: AuthenticationModule.name,
                  children: [
                    _i12.RouteConfig('#redirect',
                        path: '',
                        parent: OnboardingFlow.name,
                        redirectTo: 'terms-and-conditions',
                        fullMatch: true)
                  ])
            ]),
        _i12.RouteConfig(AuthenticatedRoute.name,
            path: 'authenticated',
            children: [
              _i12.RouteConfig('#redirect',
                  path: '',
                  parent: AuthenticatedRoute.name,
                  redirectTo: 'home',
                  fullMatch: true),
              _i12.RouteConfig(HomeModule.name,
                  path: 'home',
                  parent: AuthenticatedRoute.name,
                  children: [
                    _i12.RouteConfig(DashboardRoute.name,
                        path: 'dashboard', parent: HomeModule.name),
                    _i12.RouteConfig(MoveMoneyModule.name,
                        path: 'move-money', parent: HomeModule.name),
                    _i12.RouteConfig(OperatorsModule.name,
                        path: 'operators', parent: HomeModule.name),
                    _i12.RouteConfig(SettingsModule.name,
                        path: 'settings', parent: HomeModule.name)
                  ])
            ])
      ];
}

/// generated route for
/// [_i1.LoadingScreen]
class LoadingRoute extends _i12.PageRouteInfo<void> {
  const LoadingRoute() : super(LoadingRoute.name, path: 'loading');

  static const String name = 'LoadingRoute';
}

/// generated route for
/// [_i2.AuthenticationModule]
class AuthenticationModule extends _i12.PageRouteInfo<void> {
  const AuthenticationModule({List<_i12.PageRouteInfo>? children})
      : super(AuthenticationModule.name,
            path: 'authentication', initialChildren: children);

  static const String name = 'AuthenticationModule';
}

/// generated route for
/// [_i3.AuthenticatedScreen]
class AuthenticatedRoute extends _i12.PageRouteInfo<void> {
  const AuthenticatedRoute({List<_i12.PageRouteInfo>? children})
      : super(AuthenticatedRoute.name,
            path: 'authenticated', initialChildren: children);

  static const String name = 'AuthenticatedRoute';
}

/// generated route for
/// [_i4.WelcomeScreen]
class WelcomeRoute extends _i12.PageRouteInfo<WelcomeRouteArgs> {
  WelcomeRoute({_i13.Key? key})
      : super(WelcomeRoute.name,
            path: 'welcome', args: WelcomeRouteArgs(key: key));

  static const String name = 'WelcomeRoute';
}

class WelcomeRouteArgs {
  const WelcomeRouteArgs({this.key});

  final _i13.Key? key;

  @override
  String toString() {
    return 'WelcomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.LoginFlow]
class LoginFlow extends _i12.PageRouteInfo<void> {
  const LoginFlow({List<_i12.PageRouteInfo>? children})
      : super(LoginFlow.name, path: 'login', initialChildren: children);

  static const String name = 'LoginFlow';
}

/// generated route for
/// [_i6.OnboardingFlow]
class OnboardingFlow extends _i12.PageRouteInfo<void> {
  const OnboardingFlow({List<_i12.PageRouteInfo>? children})
      : super(OnboardingFlow.name,
            path: 'onboarding', initialChildren: children);

  static const String name = 'OnboardingFlow';
}

/// generated route for
/// [_i7.HomeModule]
class HomeModule extends _i12.PageRouteInfo<void> {
  const HomeModule({List<_i12.PageRouteInfo>? children})
      : super(HomeModule.name, path: 'home', initialChildren: children);

  static const String name = 'HomeModule';
}

/// generated route for
/// [_i8.DashboardScreen]
class DashboardRoute extends _i12.PageRouteInfo<void> {
  const DashboardRoute() : super(DashboardRoute.name, path: 'dashboard');

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i9.MoveMoneyModule]
class MoveMoneyModule extends _i12.PageRouteInfo<void> {
  const MoveMoneyModule() : super(MoveMoneyModule.name, path: 'move-money');

  static const String name = 'MoveMoneyModule';
}

/// generated route for
/// [_i10.OperatorsModule]
class OperatorsModule extends _i12.PageRouteInfo<void> {
  const OperatorsModule() : super(OperatorsModule.name, path: 'operators');

  static const String name = 'OperatorsModule';
}

/// generated route for
/// [_i11.SettingsModule]
class SettingsModule extends _i12.PageRouteInfo<void> {
  const SettingsModule() : super(SettingsModule.name, path: 'settings');

  static const String name = 'SettingsModule';
}
