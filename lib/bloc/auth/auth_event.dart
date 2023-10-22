part of 'auth_bloc.dart';

sealed class AuthEvent {}

class AuthEventLogin extends AuthEvent {
  AuthEventLogin(this.email,this.pass);
  final String email;
  final String pass;
}

class AuthEventLogout extends AuthEvent {}
