import 'package:spendwise/services/auth/auth_provider.dart';
import 'package:spendwise/services/auth/auth_user.dart';

import 'firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  AuthService(this.provider);
  // uncomment when FirebaseAuth Provider is written
  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<void> initialize() => provider.initialize();

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> createUser(
          {required String email, required String password}) =>
      provider.createUser(
        email: email,
        password: password,
      );

  @override
  Future<AuthUser> logIn({required String email, required String password}) =>
      provider.logIn(
        email: email,
        password: password,
      );

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<void> sendResetPassword({required String toEmail}) =>
      provider.sendResetPassword(toEmail: toEmail);

  @override
  Future<void> googleSignIn(
          {required String idToken, required String accessToken}) =>
      provider.googleSignIn(
        idToken: idToken,
        accessToken: accessToken,
      );
}
