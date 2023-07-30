part of 'app_bloc.dart';

@immutable
sealed class AppEvent {
  const AppEvent();
}

/// Event of [AppBloc] for log out
final class AppLogOutRequested extends AppEvent {
  const AppLogOutRequested();
}

/// Event of [AppBloc] for user change
final class _AppUserChanged extends AppEvent {
  const _AppUserChanged(this.user);

  final User user;
}
