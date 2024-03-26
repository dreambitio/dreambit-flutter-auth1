part of '../../../one_day_auth.dart';

abstract interface class IPhoneCodeController implements AuthController {
  Future<void> confirm({
    required final String code,
    final AuthActionCallback afterAuthAction,
  });

  Future<void> sendCode();

  CodeSentResult? get codeSentResult;
}

class PhoneCodeController extends ChangeNotifier
    with OneDayAuthStateMixin
    implements IPhoneCodeController {
  PhoneCodeController(
    OneDayAuthState sValue, [
    AuthActions aValue = AuthActions.signIn,
  ]) {
    state = sValue;
    action = aValue;
  }

  @override
  Future<void> confirm({
    required final String code,
    final AuthActionCallback afterAuthAction,
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
  Future<void> sendCode() async {
    if (codeSentResult?.phoneNumber == null) {
      state = PhoneCodeException(null, codeSentResult: codeSentResult);
      return;
    }
    state = PhoneCodeLoading(codeSentResult);
    final Either<Object?, CodeSentResult> res =
        await FirebaseAuthService.instance.verifyPhoneNumber(
      phoneNumber: codeSentResult!.phoneNumber,
    );
    res.fold(
      (l) {
        if (AuthExceptions.isWebContextCancelled(l)) {
          return state = PhoneCodeInitial(codeSentResult);
        }
        return state = PhoneCodeException(l, codeSentResult: codeSentResult);
      },
      (r) => state = PhoneCodeInitial(r),
    );
  }

  @override
  CodeSentResult? get codeSentResult => state is PhoneCodeBase
      ? (state as PhoneCodeBase).codeSentResult
      : state is PhoneCodeException
          ? (state as PhoneCodeException).codeSentResult
          : null;

  @override
  OneDayAuthState initalState = PhoneCodeInitial();
}
