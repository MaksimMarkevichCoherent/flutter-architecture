import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

part 'connectivity_state.dart';

const _serverToPing = 'http://www.gstatic.com/generate_204';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription$;

  ConnectivityCubit() : super(ConnectivityState());

  void init() {
    _connectivitySubscription$ = _connectivity.onConnectivityChanged.listen((result) async {
      final connected = await _isPhoneConnected();
      emit(ConnectivityState(connected: connected));
    });
  }

  Future<bool> _isPhoneConnected() async {
    try {
      final result = await http.get(Uri.parse(_serverToPing)).timeout(
        const Duration(seconds: 2),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
      if (result.statusCode > 199 && result.statusCode < 400) {
        return true;
      }
      return false;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription$.cancel();
    return super.close();
  }
}
