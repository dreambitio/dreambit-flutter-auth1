part of '../../../one_day_auth.dart';

abstract interface class IEmailPasswordController implements AuthController {
  Future<void> signIn({
    required final String email,
    required final String password,
    final AuthActionCallback afterSignInAction,
    final AuthActionCallback afterSignUpAction,
  });

  Future<void> signUp({
    required final String email,
    required final String password,
    final AuthActionCallback afterSignInAction,
    final AuthActionCallback afterSignUpAction,
  });
}

class EmailPasswordController extends ChangeNotifier
    with OneDayAuthStateMixin
    implements IEmailPasswordController {
  EmailPasswordController([AuthActions value = AuthActions.signIn]) {
    state = initalState;
    action = value;
  }

  @override
  OneDayAuthState initalState = const EmailPasswordInitial();

  @override
  Future<void> signIn({
    required final String email,
    required final String password,
    final AuthActionCallback afterSignInAction,
    final AuthActionCallback afterSignUpAction,
  }) async {
    state = const EmailPasswordLoading();
    final Either<Object?, UserCredential> res =
        await FirebaseAuthService.instance.signInEmailPassword(
      email: email,
      password: password,
      afterSignInAction: afterSignInAction,
    );
    res.fold(
      (l) => state = OneDayAuthException(l),
      (r) => state = EmailPasswordSignedIn(r),
    );
  }

  @override
  Future<void> signUp({
    required final String email,
    required final String password,
    final AuthActionCallback afterSignInAction,
    final AuthActionCallback afterSignUpAction,
  }) async {
    state = const EmailPasswordLoading();
    final Either<Object?, UserCredential> res =
        await FirebaseAuthService.instance.signUpEmailPassword(
      email: email,
      password: password,
      afterSignUpAction: afterSignUpAction,
    );
    res.fold(
      (l) => state = OneDayAuthException(l),
      (r) => state = EmailPasswordSignedUp(r),
    );
  }

  @override
  void changeAction([AuthActions? value]) {
    state = initalState;
    super.changeAction(value);
  }
}
