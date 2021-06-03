import 'dart:async';
import 'package:doit/Auth/auth_bloc.dart';
import 'package:doit/Service/AuthRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:doit/Common/FormSubmissionStatus.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final AuthBloc authBloc;
  final AuthService authService;

  LoginBloc(AuthBloc authBloc, AuthService authService)
      : assert(authBloc != null),
        assert(authService != null),
        authBloc = authBloc,
        authService = authService,
        super(LoginInitial());


  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    // Username updated
    if (event is LoginUsernameChanged) {
      yield state.copyWith(username: event.username);

      // Password updated
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);

      // Logging in
    } else if (event is LoginButtonClicked) {
      try {
        final token = await authService.login(state.username, state.password);
        authService.persistToken(token);
        authBloc.add(LoggedIn(token: token));
        yield state.copyWith(formSubmissionStatus: SubmissionSuccess());
        yield LoginSuccess();
      } catch (e) {
        print(e.toString());
        yield state.copyWith(formSubmissionStatus: SubmissionFailed(e));
        yield LoginFailure();
      }
    } else if (event is LoginSubmissionReset) {
      yield state.copyWith(formSubmissionStatus: InitialFormStatus());
      yield LoginInitial();
    }
  }
}
