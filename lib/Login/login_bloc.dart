import 'dart:async';
import 'package:doit/Login/AuthRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:doit/Common/FormSubmissionStatus.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  LoginBloc({this.authRepo}) : super(LoginState());

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
      yield state.copyWith(formSubmissionStatus: FormSubmitting());

      try {
        await authRepo.login();
        yield state.copyWith(formSubmissionStatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(formSubmissionStatus: SubmissionFailed(e));
      }
    } else if (event is LoginSubmissionReset) {
      yield state.copyWith(formSubmissionStatus: InitialFormStatus());
    }
  }
}
