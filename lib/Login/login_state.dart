part of 'login_bloc.dart';

class LoginState {
  final String username;
  final String password;
  final FormSubmissionStatus formSubmissionStatus;

  LoginState({
    this.username = '',
    this.password = '',
    this.formSubmissionStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String username,
    String password,
    FormSubmissionStatus formSubmissionStatus,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
    );
  }

}