part of '../../../../one_day_auth.dart';

abstract interface class IFacebookSignInController implements AuthController {
  Future<void> signIn({
    final AuthActionCallback afterAuthAction,
  });
}

class FacebookSignInController extends ChangeNotifier
    with OneDayAuthStateMixin
    implements IFacebookSignInController {
  FacebookSignInController(String appId) {
    _appId = appId;
    state = initalState;
  }

  late final String _appId;

  @override
  OneDayAuthState initalState = const OAuthInitial();

  @override
  Future<void> signIn({
    final AuthActionCallback afterAuthAction,
  }) async {
    state = const OAuthLoading();
    final Either<Object?, UserCredential> res =
        await FirebaseAuthService.instance.facebookSignIn(
      appId: _appId,
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
