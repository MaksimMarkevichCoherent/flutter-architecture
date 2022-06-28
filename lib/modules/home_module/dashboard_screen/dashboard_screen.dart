import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../common/core/cubit/loading_manager/loading_cubit.dart';
import '../../../../common/core/loading_screen.dart';
import '../../../../common/widgets/app_screen_wrapper.dart';
import '../../../../common/widgets/loading/app_loading_header.dart';
import 'cubit/dashboard_cubit.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardCubit>(
      create: (_) => DashboardCubit(),
      child: const _DashboardScreen(),
    );
  }
}

class _DashboardScreen extends StatelessWidget {
  const _DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoadingCubit, LoadingState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state.initialLoadingComplete) {
          // Remove splash once the screen is initialized
          FlutterNativeSplash.remove();
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            AutoTabsRouter(
              routes: [
                //DashboardCardsRoute(),
                //const DashboardAccountsRoute(),
              ],
              builder: (context, child, animation) {
                final tabsRouter = AutoTabsRouter.of(context);

                return AppScreenWrapper(
                  padding: const EdgeInsets.all(0),
                  child: SmartRefresher(
                    header: const AppLoadingHeader(),
                    controller: context.read<DashboardCubit>().refreshController,
                    onRefresh: () {
                      context.read<DashboardCubit>().refreshCurrentTab();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(24.w, 25.w, 24.w, 10.w),
                            child: BlocBuilder<DashboardCubit, DashboardState>(
                              builder: (context, state) {
                                return Row(
                                  children: [],
                                );
                              },
                            ),
                          ),
                          child,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            if (!state.initialLoadingComplete) const LoadingScreen(),
          ],
        );
      },
    );
  }
}
