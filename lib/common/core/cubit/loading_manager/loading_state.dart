part of 'loading_cubit.dart';

enum LoadingStatus {
  loading,
  pending,
}

class LoadingState {
  final LoadingStatus status;

  /// Indicates whether the dashboard has been loaded initially or not
  ///
  /// There are 2 cases:
  /// 1. User opens the app and they've been logged in already.
  /// In this case [initialLoadingComplete] affects splash screen
  /// 2. User is logging in.
  /// Loading screen is shown until home screen's content is loaded.
  final bool initialLoadingComplete;

  bool get isLoading => status == LoadingStatus.loading;

  LoadingState({
    this.status = LoadingStatus.loading,
    this.initialLoadingComplete = false,
  });

  LoadingState copyWith({
    LoadingStatus? status,
    bool? initialLoadingComplete,
  }) {
    return LoadingState(
      status: status ?? this.status,
      initialLoadingComplete: initialLoadingComplete ?? this.initialLoadingComplete,
    );
  }
}
