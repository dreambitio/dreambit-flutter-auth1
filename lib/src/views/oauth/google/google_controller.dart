part of '../../../../one_day_auth.dart';

abstract interface class IGoogleSignInController implements AuthController {
  Future<void> signIn({
    final AuthActionCallback afterAuthAction,
  });
}

class GoogleSignInController extends ChangeNotifier
    with OneDayAuthStateMixin
    implements IGoogleSignInController {
  GoogleSignInController([final String? webClientId]) {
    _webClientId = webClientId;
    state = initalState;
  }

  @override
  OneDayAuthState initalState = const OAuthInitial();

  late final String? _webClientId;

  @override
  Future<void> signIn({
    final AuthActionCallback afterAuthAction,
  }) async {
    state = const OAuthLoading();
    final Either<Object?, UserCredential> res =
        await FirebaseAuthService.instance.googleSignIn(
      webClientId: _webClientId,
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
