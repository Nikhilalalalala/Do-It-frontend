part of 'login_bloc.dart';

class LoginState extends Equatable {

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
  @override
  List<Object> get props => [username, password, formSubmissionStatus];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({@required this.error});

  @override
  List<Object> get props => [error];
}

class CreatingNewUserPageState extends LoginState {}