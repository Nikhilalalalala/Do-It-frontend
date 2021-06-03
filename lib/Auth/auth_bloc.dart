import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:doit/Service/AuthRepository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc(AuthService authService)
      : assert(authService != null),
        authService = authService,
        super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {

    if (event is LoggedIn) {
      yield AuthLoading();
      await authService.persistToken(event.token);
      yield AuthAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthLoading();
      await authService.deleteToken();
      yield AuthUnauthenticated();
    }
  }
}
