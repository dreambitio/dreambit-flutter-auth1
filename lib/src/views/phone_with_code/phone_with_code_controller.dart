part of '../../../one_day_auth.dart';

abstract interface class IPhoneWithCodeController implements AuthController {
  Future<void> sendCode(final String phoneNumber);

  Future<void> confirm({
    required final String code,
    final AuthActionCallback afterAuthAction,
  });

  CodeSentResult? get codeSentResult;
}

class PhoneWithCodeController extends ChangeNotifier
    with OneDayAuthStateMixin
    implements IPhoneWithCodeController {
  PhoneWithCodeController([AuthActions value = AuthActions.signIn]) {
    state = initalState;
    action = value;
  }

  @override
  OneDayAuthState initalState = PhoneCodeInitial();

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

  @override
  Future<void> confirm({
    required final String code,
    AuthActionCallback afterAuthAction,
  }) async {
    if (codeSentResult == null) {
      state = OneDayAuthException();
      return;
    }
    state = PhoneCodeLoading(codeSentResult);
    final Either<Object?, UserCredential> res =
        await FirebaseAuthService.instance.signInPhoneCode(
      code: code,
      codeSentResult: codeSentResult!,
      afterAuthAction: afterAuthAction,
    );
    res.fold(
      (l) => state = PhoneCodeException(l, codeSentResult: codeSentResult),
      (r) => state = PhoneCodeCompleted(r),
    );
  }

  @override
  CodeSentResult? get codeSentResult => state is PhoneCodeBase
      ? (state as PhoneCodeBase).codeSentResult
      : state is PhoneCodeException
          ? (state as PhoneCodeException).codeSentResult
          : null;

  void setInitialState() {
    if (state is PhoneCodeInitial) return;
    state = initalState;
  }
}
