import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
export 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateLogout()) {
    FirebaseAuth auth = FirebaseAuth.instance;
    on<AuthEventLogout>((event, emit) async {
      try {
        emit(AuthStateLoading());
        await auth.signOut();
        emit(AuthStateLogout());
      } on FirebaseAuthException catch (e) {
        emit(AuthStateError(e.message.toString()));
      } catch (e) {
        emit(AuthStateError(e.toString()));
      }
    });
    on<AuthEventLogin>((event, emit) async {
      try {
        emit(AuthStateLoading());
        await auth.signInWithEmailAndPassword(
            email: event.email, password: event.pass);
        emit(AuthStateLogin());
      } on FirebaseAuthException catch (e) {
        emit(AuthStateError(e.message.toString()));
      } catch (e) {
        emit(AuthStateError(e.toString()));
      }
    });
  }
}
