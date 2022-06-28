part of 'dashboard_cubit.dart';

enum DashboardTab { cards, accounts }

enum DashboardStatus {
  pending,
  loading,
}

class DashboardState {
  final DashboardTab currentTab;
  final DashboardStatus status;

  bool get isLoading => status == DashboardStatus.loading;

  DashboardState({
    this.currentTab = DashboardTab.cards,
    this.status = DashboardStatus.pending,
  });

  DashboardState copyWith({
    DashboardTab? currentTab,
    DashboardStatus? status,
  }) =>
      DashboardState(
        currentTab: currentTab ?? this.currentTab,
        status: status ?? this.status,
      );
}
