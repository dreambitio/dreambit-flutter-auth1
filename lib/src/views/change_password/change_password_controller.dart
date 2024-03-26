part of '../../../one_day_auth.dart';

abstract interface class IChangePasswordController implements AuthController {
  Future<void> changePassword({
    required final String password,
    required final String newPassword,
  });
}

class ChangePasswordController extends ChangeNotifier
    with OneDayAuthStateMixin
    implements IChangePasswordController {
  ChangePasswordController([final OneDayAuthState? value]) {
    state = value ?? initalState;
  }

  @override
  OneDayAuthState initalState = const ChangePasswordInitial();

  void setInitialState() {
    if (state is ChangePasswordInitial) return;
    state = initalState;
  }

  @override
  Future<void> changePassword({
    required final String password,
    required final String newPassword,
  }) async {
    state = const ChangePasswordLoading();
    final Either<Object?, bool> res =
        await FirebaseAuthService.instance.changePassword(
      password: password,
      newPassword: newPassword,
    );
    res.fold(
      (l) => state = OneDayAuthException(l),
      (r) => state = const ChangePasswordCompleted(),
    );
  }
}
