import 'package:spendwise/services/auth/auth_user.dart';

abstract class AuthProvider {
  Future<void> initialize();

  AuthUser? get currentUser;

  Future<AuthUser> logIn({
    required String email,
    required String password,
  });

  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  Future<void> logOut();

  Future<void> sendEmailVerification();

  Future<void> sendResetPassword({required String toEmail});

  Future<void> googleSignIn({
    required String idToken,
    required String accessToken,
  });

  // Future<void> initializeNotification();
  //
  // Future<void> sendNotification();
}
