part of 'auth_bloc.dart';

@immutable
sealed class AuthState {} //Note AuthState must not extend AuthEvent --

final class AuthInitial extends AuthState {}

final class AuthFailure extends AuthState {
  final String error;
  AuthFailure({required this.error});
}

final class AuthSuccess extends AuthState {
  final String message;
  final String userId;
  AuthSuccess({required this.message, required this.userId});
}

final class AuthLoading extends AuthState {}
