part of '../../../../one_day_auth.dart';

abstract interface class IAppleSignInController implements AuthController {
  Future<void> signIn({
    final AuthActionCallback afterAuthAction,
  });
}

class AppleSignInController extends ChangeNotifier
    with OneDayAuthStateMixin
    implements IAppleSignInController {
  AppleSignInController([final OneDayAuthState? value]) {
    state = value ?? initalState;
  }

  @override
  OneDayAuthState initalState = const OAuthInitial();

  @override
  Future<void> signIn({
    final AuthActionCallback afterAuthAction,
  }) async {
    state = const OAuthLoading();
    final Either<Object?, UserCredential> res =
        await FirebaseAuthService.instance.appleSignIn(
      afterAuthAction: afterAuthAction,
    );
    res.fold(
      (l) {
        if (l == null || AuthExceptions.isWebContextCancelled(l)) {
          return state = initalState;
        }
        return state = OneDayAuthException(l);
      },
      (r) => state = OAuthAuthorized(r),
    );
  }
}
