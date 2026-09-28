import 'package:assignment/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuthService authService;

  AuthRepository({
    required this.authService,
  });

  Future<UserCredential> signUp(
    String email,
    String password,
  ) async {
    return await authService.signUp(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> login(
    String email,
    String password,
  ) async {
    return await authService.login(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    await authService.logout();
  }

  User? get currentUser {
    return authService.currentUser;
  }

  Stream<User?> get authStateChanges {
    return authService.authStateChanges;
  }
}