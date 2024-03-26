part of '../../../one_day_auth.dart';

abstract interface class IEmailVerificationController
    implements AuthController {
  Future<void> sendMail();

  Future<void> checkVerification();
}

class EmailVerificationController extends ChangeNotifier
    with OneDayAuthStateMixin
    implements IEmailVerificationController {
  EmailVerificationController() {
    getState();
  }

  void getState(
      [OneDayAuthState verificationState = const EmailVerification()]) {
    final User? user = FirebaseAuthService.instance.currentUser;
    if ((user?.emailVerified ?? false)) {
      state = const EmailVerified();
    } else if (!(user?.email?.isNullOrEmptyText ?? true) &&
        !(user?.emailVerified ?? true)) {
      state = verificationState;
    } else {
      state = initalState;
    }
  }

  @override
  OneDayAuthState initalState = const EmailVerificationUnavailable();

  @override
  Future<void> sendMail() async {
    state = const EmailVerificationLoading();
    final Either<Object?, bool> res =
        await FirebaseAuthService.instance.emailVerification();
    res.fold(
      (l) => state = OneDayAuthException(l),
      (r) => state = const EmailVerificationAwaiting(),
    );
  }

  @override
  Future<void> checkVerification() async {
    state = const EmailVerificationCheckAwaiting();
    await FirebaseAuthService.instance.reloadUser();
    getState(const EmailVerificationAwaiting());
  }
}
