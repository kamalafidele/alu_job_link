import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/auth_cubit.dart';
import 'screens/auth/login_screen.dart';
import 'screens/student/student_shell.dart';
import 'screens/startup/startup_shell.dart';

class AluJobLinkApp extends StatelessWidget {
  const AluJobLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: MaterialApp(
        title: 'ALU JobLink',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.deepPurple,
          useMaterial3: true,
        ),
        home: const AuthGate(),
      ),
    );
  }
}

// Watches AuthCubit and shows the right part of the app:
// logged out -> Login, logged in as student -> StudentShell,
// logged in as startup -> StartupShell.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        switch (state.status) {
          case AuthStatus.authenticatedStudent:
            return const StudentShell();
          case AuthStatus.authenticatedStartup:
            return const StartupShell();
          case AuthStatus.loading:
          case AuthStatus.unauthenticated:
            return const LoginScreen();
        }
      },
    );
  }
}
