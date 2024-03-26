part of '../../../../one_day_auth.dart';

abstract interface class ITwitterSignInController implements AuthController {
  Future<void> signIn({
    final AuthActionCallback afterAuthAction,
  });
}

class TwitterSignInController extends ChangeNotifier
    with OneDayAuthStateMixin
    implements ITwitterSignInController {
  TwitterSignInController([final OneDayAuthState? value]) {
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
        await FirebaseAuthService.instance.twitterSignIn(
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
