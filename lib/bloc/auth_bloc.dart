import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        String email = event.email;
        String password = event.password;

        final bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email);

        if (emailValid == false) {
          emit(AuthFailure(error: 'Email is Invalid'));
          return;
        }
        if (password.length < 6) {
          emit(AuthFailure(error: "Password length must be greater than 6"));
          return;
        }
        await Future.delayed(const Duration(seconds: 1));
        //fetch user ID from your external API/Service like FireBase or SupaBase .
        //I am creating a Dummy user Id as --> $email-password .
        emit(AuthSuccess(
            message: 'Login In successful', userId: '$email-$password'));
        return;
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
        return;
      }
    });
    on<AuthLogoutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await Future.delayed(const Duration(seconds: 1));
        //log out this user from your external API/Service like FireBase or SupaBase .
        emit(AuthInitial()); //Back to Initial state(logged out state) ...
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
        return;
      }
    });
  }
}
