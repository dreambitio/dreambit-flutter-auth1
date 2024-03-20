part of '../../../../one_day_auth.dart';

abstract interface class IGitHubSignInController implements AuthController {
  Future<void> signIn({
    final AuthActionCallback afterAuthAction,
  });
}

class GitHubSignInController extends ChangeNotifier
    with OneDayAuthStateMixin
    implements IGitHubSignInController {
  GitHubSignInController([final OneDayAuthState? value]) {
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
        await FirebaseAuthService.instance.gitHubSignIn(
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
