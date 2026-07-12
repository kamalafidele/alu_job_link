import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthStatus { unauthenticated, loading, authenticatedStudent, authenticatedStartup }

class AuthState {
  final AuthStatus status;
  final String? uid;
  final String? name;
  final bool verified;
  final String? errorMessage;

  const AuthState({
    required this.status,
    this.uid,
    this.name,
    this.verified = false,
    this.errorMessage,
  });

  const AuthState.unauthenticated({String? errorMessage})
      : this(status: AuthStatus.unauthenticated, errorMessage: errorMessage);
}

// Handles signup/login/logout using Firebase Auth
class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  AuthCubit() : super(const AuthState.unauthenticated()) {
    _checkCurrentUser();
  }

  // If the user is already logged in from a previous session, load their profile.
  Future<void> _checkCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      await _loadProfileAndEmit(user.uid);
    }
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    emit(const AuthState(status: AuthStatus.loading));
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = credential.user!.uid;

      await _db.collection('users').doc(uid).set({
        'name': name,
        'email': email,
        'role': role,
        // Students don't need verification; startups start unverified until an admin approves them
        'verified': role == 'student',
      });

      await _loadProfileAndEmit(uid);
    } on FirebaseAuthException catch (e) {
      emit(AuthState.unauthenticated(errorMessage: e.message ?? 'Signup failed'));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(const AuthState(status: AuthStatus.loading));
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _loadProfileAndEmit(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      emit(AuthState.unauthenticated(errorMessage: e.message ?? 'Login failed'));
    }
  }

  // Reads the user's profile doc from Firestore and emits the matching
  Future<void> _loadProfileAndEmit(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    final data = doc.data();
    if (data == null) {
      emit(AuthState.unauthenticated(errorMessage: 'Profile not found'));
      return;
    }

    final role = data['role'] ?? 'student';
    emit(AuthState(
      status: role == 'startup' ? AuthStatus.authenticatedStartup : AuthStatus.authenticatedStudent,
      uid: uid,
      name: data['name'] ?? '',
      verified: data['verified'] ?? false,
    ));
  }

  Future<void> requestVerification() async {
    if (state.uid == null) return;
    await _db.collection('users').doc(state.uid).update({'verificationRequested': true});
  }

  Future<void> logout() async {
    await _auth.signOut();
    emit(const AuthState.unauthenticated());
  }
}
