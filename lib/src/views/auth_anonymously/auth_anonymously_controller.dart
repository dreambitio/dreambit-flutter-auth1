part of '../../../../one_day_auth.dart';

abstract interface class IAuthAnonymouslyController implements AuthController {
  Future<void> signIn({
    final AuthActionCallback afterAuthAction,
  });
}

class AuthAnonymouslyController extends ChangeNotifier
    with OneDayAuthStateMixin
    implements IAuthAnonymouslyController {
  AuthAnonymouslyController([final OneDayAuthState? value]) {
    state = value ?? initalState;
  }

  @override
  OneDayAuthState initalState = const AuthAnonymouslyInitial();

  @override
  Future<void> signIn({
    final AuthActionCallback afterAuthAction,
  }) async {
    state = const AuthAnonymouslyLoading();
    final Either<Object?, UserCredential> res =
        await FirebaseAuthService.instance.anonymouslySignIn(
      afterAuthAction: afterAuthAction,
    );
    res.fold(
      (l) {
        if (l == null || AuthExceptions.isWebContextCancelled(l)) {
          return state = initalState;
        }
        return state = OneDayAuthException(l);
      },
      (r) => state = AuthAnonymouslyAuthorized(r),
    );
  }
}
