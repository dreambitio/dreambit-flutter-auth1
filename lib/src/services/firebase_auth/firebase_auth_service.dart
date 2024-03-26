part of '../../../one_day_auth.dart';

class FirebaseAuthService implements IFirebaseAuthService {
  FirebaseAuthService._i();

  static final FirebaseAuthService _instance = FirebaseAuthService._i();

  static FirebaseAuthService get instance => _instance;

  static const String _l = 'FirebaseAuthService';

  @override
  FirebaseAuth get auth => FirebaseAuth.instance;

  @override
  String get authProjectId => auth.app.options.projectId;

  @override
  User? get currentUser => auth.currentUser;

  @override
  Future<String?> get userIdToken async => auth.currentUser?.getIdToken();

  @override
  Stream<User?> get userStream => FirebaseAuth.instance.userChanges();

  @override
  Future<User?> reloadUser() async {
    try {
      if (currentUser != null) {
        await currentUser?.reload();
        return currentUser;
      }
      return null;
    } catch (e, s) {
      log(e.toString(), name: _l, stackTrace: s);
      return null;
    }
  }

  @override
  Future<Either<Object?, UserCredential>> signUpEmailPassword({
    required final String email,
    required final String password,
    final AuthActionCallback afterSignUpAction,
  }) async {
    try {
      final UserCredential res = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await afterSignUpAction?.call(res.user);
      return Right(res);
    } catch (e, s) {
      log(e.toString(), name: _l, stackTrace: s);
      return Left(e);
    }
  }

  @override
  Future<Either<Object?, UserCredential>> signInEmailPassword({
    required final String email,
    required final String password,
    final AuthActionCallback afterSignInAction,
  }) async {
    try {
      final UserCredential res = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await afterSignInAction?.call(res.user);
      return Right(res);
    } catch (e) {
      log(e.toString(), name: _l);
      return Left(e);
    }
  }

  @override
  Future<Either<Object?, CodeSentResult>> verifyPhoneNumber({
    required final String phoneNumber,
  }) async {
    return kIsWeb
        ? verifyPhoneNumberWeb(
            phoneNumber: phoneNumber,
          )
        : verifyPhoneNumberApp(
            phoneNumber: phoneNumber,
          );
  }

  @override
  Future<Either<Object?, CodeSentResult>> verifyPhoneNumberApp({
    required final String phoneNumber,
  }) async {
    try {
      final Completer<Either<Object?, CodeSentResult>> completer = Completer();
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber.clearDefaultPhoneNumber,
        codeSent: (String verificationId, int? forceResendingToken) {
          if (!completer.isCompleted) {
            completer.complete(
              Right(
                CodeSentResult(
                  phoneNumber: phoneNumber.clearDefaultPhoneNumber,
                  verificationId: verificationId,
                  forceResendingToken: forceResendingToken,
                  timeStamp: DateTime.now(),
                ),
              ),
            );
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          log(e.toString(), name: _l);
          if (!completer.isCompleted) {
            completer.complete(
              Left(e),
            );
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
      );
      return await completer.future;
    } catch (e, s) {
      log(e.toString(), name: _l, stackTrace: s);
      return Left(e);
    }
  }

  @override
  Future<Either<Object?, CodeSentResult>> verifyPhoneNumberWeb({
    required final String phoneNumber,
  }) async {
    try {
      final ConfirmationResult confirmationResult =
          await auth.signInWithPhoneNumber(
        phoneNumber.clearDefaultPhoneNumber,
      );
      return Right(
        CodeSentResult(
          phoneNumber: phoneNumber.clearDefaultPhoneNumber,
          verificationId: confirmationResult.verificationId,
          confirmationResult: confirmationResult,
          timeStamp: DateTime.now(),
        ),
      );
    } catch (e, s) {
      log(e.toString(), name: _l, stackTrace: s);
      return Left(e);
    }
  }

  @override
  Future<Either<Object?, UserCredential>> signInPhoneCode({
    required final CodeSentResult codeSentResult,
    required final String code,
    final AuthActionCallback afterAuthAction,
  }) async {
    return kIsWeb
        ? signInPhoneCodeWeb(
            codeSentResult: codeSentResult,
            code: code,
            afterAuthAction: afterAuthAction,
          )
        : signInPhoneCodeApp(
            codeSentResult: codeSentResult,
            code: code,
            afterAuthAction: afterAuthAction,
          );
  }

  @override
  Future<Either<Object?, UserCredential>> signInPhoneCodeApp({
    required final CodeSentResult codeSentResult,
    required final String code,
    final AuthActionCallback afterAuthAction,
  }) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: codeSentResult.verificationId,
        smsCode: code,
      );
      final UserCredential res = await auth.signInWithCredential(credential);
      await afterAuthAction?.call(res.user);
      return Right(res);
    } catch (e, s) {
      log(e.toString(), name: _l, stackTrace: s);
      return Left(e);
    }
  }

  @override
  Future<Either<Object?, UserCredential>> signInPhoneCodeWeb({
    required final CodeSentResult codeSentResult,
    required final String code,
    final AuthActionCallback afterAuthAction,
  }) async {
    try {
      final UserCredential res =
          await codeSentResult.confirmationResult!.confirm(
        code,
      );
      await afterAuthAction?.call(res.user);
      return Right(res);
    } catch (e, s) {
      log(e.toString(), name: _l, stackTrace: s);
      return Left(e);
    }
  }

  @override
  Future<Either<Object?, bool>> resetPassword({
    required final String email,
  }) async {
    try {
      await auth.sendPasswordResetEmail(
        email: email,
      );
      return const Right(true);
    } catch (e, s) {
      log(e.toString(), name: _l, stackTrace: s);
      return Left(e);
    }
  }

  @override
  Future<Either<Object?, bool>> emailVerification() async {
    try {
      await currentUser!.sendEmailVerification();
      return const Right(true);
    } catch (e, s) {
      log(e.toString(), name: _l, stackTrace: s);
      return Left(e);
    }
  }

  @override
  Future<Either<Object?, bool>> changePassword({
    required final String password,
    required final String newPassword,
  }) async {
    try {
      await currentUser!.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: currentUser!.email!,
          password: password,
        ),
      );
      await currentUser!.updatePassword(newPassword);
      return const Right(true);
    } catch (e, s) {
      log(e.toString(), name: _l, stackTrace: s);
      return Left(e);
    }
  }

  @override
  Future<Either<Object?, UserCredential>> googleSignIn({
    required final String? webClientId,
    final AuthActionCallback afterAuthAction,
    final AuthenticateActions action = AuthenticateActions.authorization,
  }) async {
    try {
      final google.GoogleSignInAccount? user = await google.GoogleSignIn(
        clientId: kIsWeb ? webClientId : null,
      ).signIn();
      if (user == null) {
        return const Left(null);
      }
      final google.GoogleSignInAuthentication googleAuth =
          await user.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential res;
      if (action == AuthenticateActions.reAuthenticate) {
        res = await currentUser!.reauthenticateWithCredential(
          credential,
        );
      } else {
        res = await auth.signInWithCredential(credential);
      }
      await afterAuthAction?.call(res.user);
      return Right(res);
    } catch (e, s) {
      log(e.toString(), name: _l, stackTrace: s);
      return Left(e);
    }
  }

  @override
  Future<Either<Object?, UserCredential>> facebookSignIn({
    required final String appId,
    final AuthActionCallback afterAuthAction,
    final AuthenticateActions action = AuthenticateActions.authorization,
  }) async {
    try {
      final facebook.FacebookAuth fAuth = facebook.FacebookAuth.instance;
      await _facebookWebInit(appId);
      final facebook.LoginResult user = await fAuth.login();
      if (user.accessToken?.token == null) {
        return const Left(null);
      }
      final OAuthCredential credential = FacebookAuthProvider.credential(
        user.accessToken!.token,
      );
      final UserCredential res;
      if (action == AuthenticateActions.reAuthenticate) {
        res = await currentUser!.reauthenticateWithCredential(
          credential,
        );
      } else {
        res = await auth.signInWithCredential(credential);
      }
      await afterAuthAction?.call(res.user);
      return Right(res);
    } catch (e, s) {
      log(e.toString(), name: _l, stackTrace: s);
      return Left(e);
    }
  }

  Future<void> _facebookWebInit(final String appId) async {
    if (kIsWeb) {
      if (!facebook.FacebookAuth.i.isWebSdkInitialized) {
        await facebook.FacebookAuth.i.webAndDesktopInitialize(
          appId: appId,
          cookie: true,
          xfbml: true,
          version: 'v15.0',
        );
      }
    }
  }

  @override
  Future<Either<Object?, UserCredential>> appleSignIn({
    final AuthActionCallback afterAuthAction,
  }) async {
    try {
      final AppleAuthProvider provider = AppleAuthProvider();
      if (kIsWeb) {
        final UserCredential res = await auth.signInWithPopup(
          provider,
        );
        await afterAuthAction?.call(res.user);
        return Right(res);
      } else {
        final UserCredential res = await auth.signInWithProvider(
          provider,
        );
        await afterAuthAction?.call(res.user);
        return Right(res);
      }
    } catch (e, s) {
      log(e.toString(), name: _l, stackTrace: s);
      return Left(e);
    }
  }

  @override
  Future<Either<Object?, UserCredential>> twitterSignIn({
    final AuthActionCallback afterAuthAction,
  }) async {
    try {
      final TwitterAuthProvider provider = TwitterAuthProvider();
      if (kIsWeb) {
        final UserCredential res = await auth.signInWithPopup(
          provider,
        );
        await afterAuthAction?.call(res.user);
        return Right(res);
      } else {
        final UserCredential res = await auth.signInWithProvider(
          provider,
        );
        await afterAuthAction?.call(res.user);
        return Right(res);
      }
    } catch (e, s) {
      log(e.toString(), name: _l, stackTrace: s);
      return Left(e);
    }
  }

  @override
  Future<Either<Object?, UserCredential>> gitHubSignIn({
    final AuthActionCallback afterAuthAction,
  }) async {
    try {
      final GithubAuthProvider provider = GithubAuthProvider();
      if (kIsWeb) {
        final UserCredential res = await auth.signInWithPopup(
          provider,
        );
        await afterAuthAction?.call(res.user);
        return Right(res);
      } else {
        final UserCredential res = await auth.signInWithProvider(
          provider,
        );
        await afterAuthAction?.call(res.user);
        return Right(res);
      }
    } catch (e, s) {
      log(e.toString(), name: _l, stackTrace: s);
      return Left(e);
    }
  }

  @override
  Future<Either<Object?, UserCredential>> microsoftSignIn({
    final AuthActionCallback afterAuthAction,
  }) async {
    try {
      final MicrosoftAuthProvider provider = MicrosoftAuthProvider();
      if (kIsWeb) {
        final UserCredential res = await auth.signInWithPopup(
          provider,
        );
        await afterAuthAction?.call(res.user);
        return Right(res);
      } else {
        final UserCredential res = await auth.signInWithProvider(
          provider,
        );
        await afterAuthAction?.call(res.user);
        return Right(res);
      }
    } catch (e, s) {
      log(e.toString(), name: _l, stackTrace: s);
      return Left(e);
    }
  }

  @override
  Future<Either<Object?, UserCredential>> reAuthWithOAuth({
    required final AuthEnums type,
    required final AuthProvider provider,
  }) async {
    try {
      if (kIsWeb) {
        final UserCredential res = await currentUser!.reauthenticateWithPopup(
          provider,
        );
        return Right(res);
      } else {
        final UserCredential res =
            await currentUser!.reauthenticateWithProvider(
          provider,
        );
        return Right(res);
      }
    } catch (e, s) {
      log(e.toString(), name: _l, stackTrace: s);
      return Left(e);
    }
  }

  @override
  Future<Either<Object?, UserCredential>> anonymouslySignIn({
    final AuthActionCallback afterAuthAction,
  }) async {
    try {
      final UserCredential res = await auth.signInAnonymously();
      await afterAuthAction?.call(res.user);
      return Right(res);
    } catch (e, s) {
      log(e.toString(), name: _l, stackTrace: s);
      return Left(e);
    }
  }

  @override
  Future<Either<Object?, bool>> signOut({
    final AuthActionCallback preSignOutAction,
    final FutureVoidCallback? afterSignOutAction,
  }) async {
    try {
      await preSignOutAction?.call(currentUser!);
      await auth.signOut();
      await afterSignOutAction?.call();
      return const Right(true);
    } catch (e, s) {
      log(e.toString(), name: _l, stackTrace: s);
      return Left(e);
    }
  }

  @override
  Future<Either<Object?, bool>> deleteUser({
    final AuthActionCallback preDeleteAction,
    final FutureVoidCallback? afterDeleteAction,
  }) async {
    try {
      await preDeleteAction?.call(currentUser!);
      await currentUser!.delete();
      await auth.signOut();
      await afterDeleteAction?.call();
      return const Right(true);
    } catch (e, s) {
      log(e.toString(), name: _l, stackTrace: s);
      return Left(e);
    }
  }
}
