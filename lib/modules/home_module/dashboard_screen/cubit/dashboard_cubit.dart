import 'package:bloc/bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../common/core/utils/logger.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final RefreshController refreshController = RefreshController();
  final BehaviorSubject<DashboardTab> changeTab$ = BehaviorSubject<DashboardTab>();
  final BehaviorSubject<DashboardTab> refreshTab$ = BehaviorSubject<DashboardTab>();
  final BehaviorSubject<String> selectCard = BehaviorSubject<String>();

  DashboardCubit() : super(DashboardState());

  void selectTab(DashboardTab tab) {
    emit(state.copyWith(currentTab: tab));
    changeTab$.add(tab);
  }

  void refreshCurrentTab() {
    refreshTab$.add(state.currentTab);
  }

  void startDashboardLoading() {
    logger.i('startDashboardLoading');
    emit(state.copyWith(status: DashboardStatus.loading));
  }

  void endDashboardLoading() {
    logger.i('endDashboardLoading');
    refreshController.refreshCompleted();
    emit(state.copyWith(status: DashboardStatus.pending));
  }

  @override
  Future<void> close() {
    changeTab$.close();
    refreshTab$.close();
    selectCard.close();
    return super.close();
  }
}
