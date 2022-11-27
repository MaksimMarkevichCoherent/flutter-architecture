import '../../common/core/cubit/session_manager/session_cubit.dart';

import '../network_client.dart';

abstract class IAuthenticationProvider {

}

class AuthenticationProvider implements IAuthenticationProvider {
  final NetworkClient _networkClient;
  final SessionCubit _session;

  AuthenticationProvider({
    required NetworkClient networkClient,
    required SessionCubit session,
  })  : _networkClient = networkClient,
        _session = session;
}
