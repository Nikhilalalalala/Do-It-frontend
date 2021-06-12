part of 'create_new_user_cubit.dart';

@immutable


class CreateNewUserState {
  final String username;
  final String password;
  final FormSubmissionStatus formSubmissionStatus;

  CreateNewUserState({
    this.username = '',
    this.password = '',
    this.formSubmissionStatus = const InitialFormStatus(),
  });

  CreateNewUserState copyWith({
    String username,
    String password,
    FormSubmissionStatus formSubmissionStatus,
  }) {
    return CreateNewUserState(
      username: username ?? this.username,
      password: password ?? this.password,
      formSubmissionStatus: formSubmissionStatus ?? this.formSubmissionStatus,
    );
  }
  // @override
  // List<Object> get props => [username, password, formSubmissionStatus];
}

class CreateNewUserInitial extends CreateNewUserState {}

class CreateNewUserSuccess extends CreateNewUserState {}

class CreateNewUserFailure extends CreateNewUserState {
  final String error;

  CreateNewUserFailure({@required this.error});

  // @override
  // List<Object> get props => [error];
}