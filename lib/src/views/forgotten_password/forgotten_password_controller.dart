part of '../../../one_day_auth.dart';

abstract interface class IForgottenPasswordController
    implements AuthController {
  Future<void> sendMail(final String email);
}

class ForgottenPasswordController extends ChangeNotifier
    with OneDayAuthStateMixin
    implements IForgottenPasswordController {
  ForgottenPasswordController([final OneDayAuthState? value]) {
    state = value ?? initalState;
  }

  @override
  OneDayAuthState initalState = const ForgottenPasswordInitial();

  @override
  Future<void> sendMail(final String email) async {
    state = const ForgottenPasswordLoading();
    final Either<Object?, bool> res =
        await FirebaseAuthService.instance.resetPassword(
      email: email,
    );
    res.fold(
      (l) => state = OneDayAuthException(l),
      (r) => state = ForgottenPasswordMailSent(email),
    );
  }
}
