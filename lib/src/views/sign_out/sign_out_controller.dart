part of '../../../one_day_auth.dart';

abstract interface class ISignOutController implements AuthController {
  Future<void> signOut({
    final AuthActionCallback preSignOutAction,
    final FutureVoidCallback? afterSignOutAction,
  });
}

class SignOutController extends ChangeNotifier
    with OneDayAuthStateMixin
    implements ISignOutController {
  SignOutController([final OneDayAuthState? value]) {
    state = value ?? initalState;
  }

  @override
  OneDayAuthState initalState = const SignOutInitial();

  @override
  Future<void> signOut({
    final AuthActionCallback preSignOutAction,
    final FutureVoidCallback? afterSignOutAction,
  }) async {
    state = const SignOutLoading();
    final Either<Object?, bool> res =
        await FirebaseAuthService.instance.signOut(
      preSignOutAction: preSignOutAction,
      afterSignOutAction: afterSignOutAction,
    );
    res.fold(
      (l) => state = OneDayAuthException(l),
      (r) => state = const OneDayAuthUnauthorized(),
    );
  }
}
