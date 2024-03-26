part of '../../../one_day_auth.dart';

abstract interface class IReAuthPasswordController implements AuthController {
  Future<void> reAuth(final String password);
}

class ReAuthPasswordController extends ChangeNotifier
    with OneDayAuthStateMixin
    implements IReAuthPasswordController {
  ReAuthPasswordController([OneDayAuthState? value]) {
    state = value ?? initalState;
  }

  @override
  OneDayAuthState initalState = const ReAuthPasswordInitial();

  @override
  Future<void> reAuth(final String password) async {
    final String? email = FirebaseAuthService.instance.currentUser?.email;
    if (email.isNullOrEmptyText) {
      state = OneDayAuthException();
      return;
    }
    state = const ReAuthPasswordLoading();
    final Either<Object?, UserCredential> res =
        await FirebaseAuthService.instance.signInEmailPassword(
      email: email!,
      password: password,
    );
    res.fold(
      (l) => state = OneDayAuthException(l),
      (r) => state = const ReAuthPasswordCompleted(),
    );
  }
}
