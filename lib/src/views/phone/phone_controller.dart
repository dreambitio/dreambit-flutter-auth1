part of '../../../one_day_auth.dart';

abstract interface class IPhoneController implements AuthController {
  Future<void> sendCode(final String phoneNumber);
}

class PhoneController extends ChangeNotifier
    with OneDayAuthStateMixin
    implements IPhoneController {
  PhoneController([AuthActions value = AuthActions.signIn]) {
    state = initalState;
    action = value;
  }

  @override
  OneDayAuthState initalState = PhoneInitial();

  @override
  Future<void> sendCode(final String phoneNumber) async {
    state = PhoneLoading();
    final Either<Object?, CodeSentResult> res =
        await FirebaseAuthService.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
    );
    res.fold(
      (l) {
        if (AuthExceptions.isWebContextCancelled(l)) {
          return state = initalState;
        }
        return state = OneDayAuthException(l);
      },
      (r) => state = PhoneCodeSent(r),
    );
  }
}
