import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'app_event.dart';

part 'app_state.dart';

/// BLoC that provide control user is authenticated or unauthenticated
/// Also provided method for user change[_onUserChanged] and
/// user log out[_onLogoutRequested]
class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(authenticationRepository.currentUser.isNotEmpty
            ? AppState.authenticated(authenticationRepository.currentUser)
            : const AppState.unauthenticated()) {
    on<_AppUserChanged>(_onUserChanged);
    on<AppLogOutRequested>(_onLogoutRequested);
    _userSubscription = _authenticationRepository.user
        .listen((user) => add(_AppUserChanged(user)));
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) {
    emit(event.user.isNotEmpty
        ? AppState.authenticated(event.user)
        : const AppState.unauthenticated());
  }

  void _onLogoutRequested(AppLogOutRequested event, Emitter<AppState> emit){
    unawaited(_authenticationRepository.logOut());
  }

  @override
  Future<void> close(){
    _userSubscription.cancel();
    return super.close();
  }
}
