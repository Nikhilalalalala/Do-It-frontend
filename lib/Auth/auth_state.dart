part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  // const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthUninitialized extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthLoading extends AuthState {}
