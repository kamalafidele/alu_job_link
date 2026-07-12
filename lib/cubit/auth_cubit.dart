import 'package:flutter_bloc/flutter_bloc.dart';

// The different states the app's auth flow can be in.
enum AuthStatus { unauthenticated, loading, authenticatedStudent, authenticatedStartup }

class AuthState {
  final AuthStatus status;
  final String? name;

  const AuthState({required this.status, this.name});

  const AuthState.unauthenticated() : this(status: AuthStatus.unauthenticated);
}

// AuthCubit controls whether the user sees the auth screens or the
// student/startup part of the app.
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState.unauthenticated());

  Future<void> login({required String email, required String role}) async {
    emit(const AuthState(status: AuthStatus.loading));
    await Future.delayed(const Duration(milliseconds: 500));

    if (role == 'startup') {
      emit(AuthState(status: AuthStatus.authenticatedStartup, name: email.split('@').first));
    } else {
      emit(AuthState(status: AuthStatus.authenticatedStudent, name: email.split('@').first));
    }
  }

  Future<void> signup({required String name, required String role}) async {
    emit(const AuthState(status: AuthStatus.loading));
    await Future.delayed(const Duration(milliseconds: 500));

    if (role == 'startup') {
      emit(AuthState(status: AuthStatus.authenticatedStartup, name: name));
    } else {
      emit(AuthState(status: AuthStatus.authenticatedStudent, name: name));
    }
  }

  void logout() {
    emit(const AuthState.unauthenticated());
  }
}
