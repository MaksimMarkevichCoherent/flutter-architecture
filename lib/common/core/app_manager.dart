import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tapp/common/core/utils/push_notification_handler.dart';

import '../../l10n/l10n.dart';
import '../../networking/api_providers/authentication_provider.dart';
import '../../networking/environments.dart';
import '../../networking/network_client.dart';
import '../../resources/theme/app_theme.dart';
import '../../router.gr.dart';
import '../secure_repository.dart';
import '../widgets/biometric/cubit/biometric_cubit.dart';
import '../widgets/connectivity_wrapper.dart';
import 'cubit/connectivity_manager/connectivity_cubit.dart';
import 'cubit/loading_manager/loading_cubit.dart';
import 'cubit/session_manager/session_cubit.dart';

final AppRouter _router = AppRouter();
// Global variable for handling localization without context
late AppLocalizations tr;

final GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();

class AppManager extends StatefulWidget {
  const AppManager({Key? key}) : super(key: key);

  @override
  State<AppManager> createState() => _AppManagerState();
}

class _AppManagerState extends State<AppManager> with WidgetsBindingObserver {
  late SecureRepository _secureRepository;
  late SessionCubit _sessionCubit;

  @override
  void initState() {
    super.initState();
    _secureRepository = SecureRepository()..clearSecureStorageIfAppReinstalled();
    _sessionCubit = SessionCubit(secureRepository: _secureRepository)..init();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final networkClient = NetworkClient(
      baseUrl: Environments.current.baseUrl,
      session: _sessionCubit,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityCubit>(create: (_) => ConnectivityCubit()..init()),
        BlocProvider<SessionCubit>(create: (_) => _sessionCubit),
        BlocProvider<LoadingCubit>(
          create: (_) => LoadingCubit(session: _sessionCubit)..init(),
        ),
        BlocProvider<BiometricCubit>(
          create: (_) => BiometricCubit(
            secureRepository: _secureRepository,
            session: _sessionCubit,
          ),
        ),
      ],
      child: MultiProvider(
        providers: [
          Provider<AuthenticationProvider>(
            create: (_) => AuthenticationProvider(
              networkClient: networkClient,
              session: _sessionCubit,
            ),
          ),
          Provider<SecureRepository>(create: (_) => _secureRepository),
          Provider<PushNotificationHandler>(
            lazy: false,
            create: (context) => PushNotificationHandler(
              firebaseMessaging: FirebaseMessaging.instance,
            )..init(context),
          ),
        ],
        child: const _App(),
      ),
    );
  }
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        final routes = <PageRouteInfo<dynamic>>[];

        if (state.authenticated == null) {
          routes.add(const LoadingRoute());
        } else if (state.authenticated!) {
          routes.add(const AuthenticatedRoute());
        } else {
          routes.add(const AuthenticationModule());
        }

        return ScreenUtilInit(
          builder: (context, widget) => MaterialApp.router(
            routerDelegate: AutoRouterDelegate.declarative(
              _router,
              routes: (_) => routes,
            ),
            routeInformationParser: _router.defaultRouteParser(includePrefixMatches: true),
            builder: (context, widget) {
              tr = AppLocalizations.of(context)!;
              return ConnectivityWrapper(child: widget ?? const SizedBox.shrink());
            },
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: L10n.all,
            theme: AppTheme.lightTheme,
          ),
        );
      },
    );
  }
}
