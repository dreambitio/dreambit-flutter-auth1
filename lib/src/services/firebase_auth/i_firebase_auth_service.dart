part of '../../../one_day_auth.dart';

abstract interface class IFirebaseAuthService {
  FirebaseAuth get auth;

  User? get currentUser;

  String get authProjectId;

  Future<String?> get userIdToken;

  Stream<User?> get userStream;

  Future<User?> reloadUser();

  Future<Either<Object?, UserCredential>> signUpEmailPassword({
    required final String email,
    required final String password,
  });

  Future<Either<Object?, UserCredential>> signInEmailPassword({
    required final String email,
    required final String password,
  });

  Future<Either<Object?, CodeSentResult>> verifyPhoneNumber({
    required final String phoneNumber,
  });

  Future<Either<Object?, CodeSentResult>> verifyPhoneNumberApp({
    required final String phoneNumber,
  });

  Future<Either<Object?, CodeSentResult>> verifyPhoneNumberWeb({
    required final String phoneNumber,
  });

  Future<Either<Object?, UserCredential>> signInPhoneCode({
    required final CodeSentResult codeSentResult,
    required final String code,
    final AuthActionCallback afterAuthAction,
  });

  Future<Either<Object?, UserCredential>> signInPhoneCodeApp({
    required final CodeSentResult codeSentResult,
    required final String code,
    final AuthActionCallback afterAuthAction,
  });

  Future<Either<Object?, UserCredential>> signInPhoneCodeWeb({
    required final CodeSentResult codeSentResult,
    required final String code,
    final AuthActionCallback afterAuthAction,
  });

  Future<Either<Object?, bool>> resetPassword({
    required final String email,
  });

  Future<Either<Object?, bool>> emailVerification();

  Future<Either<Object?, bool>> changePassword({
    required final String password,
    required final String newPassword,
  });

  Future<Either<Object?, UserCredential>> googleSignIn({
    required final String? webClientId,
    final AuthActionCallback afterAuthAction,
  });

  Future<Either<Object?, UserCredential>> facebookSignIn({
    required final String appId,
    final AuthActionCallback afterAuthAction,
  });

  Future<Either<Object?, UserCredential>> appleSignIn({
    final AuthActionCallback afterAuthAction,
  });

  Future<Either<Object?, UserCredential>> twitterSignIn({
    final AuthActionCallback afterAuthAction,
  });

  Future<Either<Object?, UserCredential>> gitHubSignIn({
    final AuthActionCallback afterAuthAction,
  });

  Future<Either<Object?, UserCredential>> microsoftSignIn({
    final AuthActionCallback afterAuthAction,
  });

  Future<Either<Object?, UserCredential>> reAuthWithOAuth({
    required final AuthEnums type,
    required final AuthProvider provider,
  });

  Future<Either<Object?, UserCredential>> anonymouslySignIn({
    final AuthActionCallback afterAuthAction,
  });

  Future<void> signOut({
    final AuthActionCallback preSignOutAction,
    final FutureVoidCallback? afterSignOutAction,
  });

  Future<Either<Object?, bool>> deleteUser({
    final AuthActionCallback preDeleteAction,
    final FutureVoidCallback? afterDeleteAction,
  });
}
