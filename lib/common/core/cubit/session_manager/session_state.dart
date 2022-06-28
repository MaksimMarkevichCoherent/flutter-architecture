part of 'session_cubit.dart';

class SessionState {
  /// Shows whether user is authenticated.
  final bool? authenticated;

  /// Shows whether user has been logged in during current session
  final bool loggedInDuringCurrentSession;

  /// A role of the current user.
  final UserRole userRole;

  /// Shows whether access token is refreshing right now.
  final bool accessTokenRefreshInProgress;

  /// Package data for headers.
  final String? version;
  final String? buildNumber;

  const SessionState({
    this.authenticated,
    this.loggedInDuringCurrentSession = false,
    this.userRole = UserRole.undefined,
    this.accessTokenRefreshInProgress = false,
    this.version,
    this.buildNumber,
  });

  String get buildInfo => 'Ver. $version build $buildNumber';

  SessionState copyWith({
    bool? authenticated,
    bool? loggedInDuringCurrentSession,
    UserRole? userRole,
    bool? accessTokenRefreshInProgress,
    String? version,
    String? buildNumber,
  }) {
    return SessionState(
      authenticated: authenticated ?? this.authenticated,
      loggedInDuringCurrentSession: loggedInDuringCurrentSession ?? this.loggedInDuringCurrentSession,
      userRole: userRole ?? this.userRole,
      accessTokenRefreshInProgress: accessTokenRefreshInProgress ?? this.accessTokenRefreshInProgress,
      version: version ?? this.version,
      buildNumber: buildNumber ?? this.buildNumber,
    );
  }
}
