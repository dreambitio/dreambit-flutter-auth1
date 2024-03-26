part of '../../../one_day_auth.dart';

abstract interface class IReAuthPhoneCodeController implements AuthController {
  Future<void> reAuth(final String code);

  Future<void> sendCode();

  CodeSentResult? get codeSentResult;
}

class ReAuthPhoneCodeController extends ChangeNotifier
    with OneDayAuthStateMixin
    implements IReAuthPhoneCodeController {
  ReAuthPhoneCodeController() {
    sendCode();
  }

  @override
  OneDayAuthState initalState = ReAuthPhoneCodeAwaiting();

  @override
  Future<void> reAuth(final String code) async {
    if (codeSentResult == null) {
      state = OneDayAuthException();
      return;
    }
    state = ReAuthPhoneCodeLoading(codeSentResult);
    final Either<Object?, UserCredential> res =
        await FirebaseAuthService.instance.signInPhoneCode(
      codeSentResult: codeSentResult!,
      code: code,
    );
    res.fold(
      (l) => state = ReAuthPhoneCodeException(
        l,
        codeSentResult: codeSentResult,
      ),
      (r) => state = ReAuthPhoneCodeCompleted(r),
    );
  }

  @override
  Future<void> sendCode() async {
    final String? phoneNumber =
        FirebaseAuthService.instance.currentUser?.phoneNumber;
    if (phoneNumber == null) {
      state = OneDayAuthException();
      return;
    }
    state = ReAuthPhoneCodeAwaiting();
    final Either<Object?, CodeSentResult> res =
        await FirebaseAuthService.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
    );
    res.fold(
      (l) {
        if (AuthExceptions.isWebContextCancelled(l)) {
          return state = ReAuthPhoneCodeWebContextCancelled();
        }
        return state = ReAuthPhoneCodeException(
          l,
          codeSentResult: codeSentResult,
        );
      },
      (r) => state = ReAuthPhoneCodeInitial(r),
    );
  }

  @override
  CodeSentResult? get codeSentResult => state is PhoneCodeBase
      ? (state as PhoneCodeBase).codeSentResult
      : state is PhoneCodeException
          ? (state as PhoneCodeException).codeSentResult
          : null;

  void setInitialState() {
    if (state is ReAuthPhoneCodeInitial) return;
    state = ReAuthPhoneCodeInitial(codeSentResult);
  }
}
