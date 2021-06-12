part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginUsernameChanged extends LoginEvent {
  final String username;
  LoginUsernameChanged({this.username});
}
class LoginPasswordChanged extends LoginEvent {
  final String password;
  LoginPasswordChanged({this.password});
}
class LoginButtonClicked extends LoginEvent {}

class LoginSubmissionReset extends LoginEvent {}

class IntentionToCreateNewUser extends LoginEvent {}