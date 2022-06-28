import 'package:bloc/bloc.dart';

import '../session_manager/session_cubit.dart';

part 'loading_state.dart';

class LoadingCubit extends Cubit<LoadingState> {
  final SessionCubit _session;

  LoadingCubit({required SessionCubit session})
      : _session = session,
        super(LoadingState(status: LoadingStatus.pending));

  void init() {
    _session.subscribeOnLogoutEvent().listen((_) {
      resetState();
    });
  }

  void startLoading() {
    emit(state.copyWith(status: LoadingStatus.loading));
  }

  void stopLoading() {
    emit(state.copyWith(status: LoadingStatus.pending));
  }

  void stopInitialLoading() {
    emit(state.copyWith(initialLoadingComplete: true));
  }

  void resetState() {
    emit(LoadingState(status: LoadingStatus.pending));
  }
}
