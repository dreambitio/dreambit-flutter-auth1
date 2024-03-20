part of '../../../one_day_auth.dart';

abstract interface class IDeleteUserController implements AuthController {
  Future<void> delete({
    final AuthActionCallback preDeleteAction,
    final FutureVoidCallback? afterDeleteAction,
  });

  void setAwaiting();

  void setInitial();
}

class DeleteUserController extends ChangeNotifier
    with OneDayAuthStateMixin
    implements IDeleteUserController {
  DeleteUserController([final OneDayAuthState? value]) {
    state = value ?? initalState;
  }

  @override
  OneDayAuthState initalState = const DeleteUserInitial();

  @override
  Future<void> delete({
    final AuthActionCallback preDeleteAction,
    final FutureVoidCallback? afterDeleteAction,
  }) async {
    try {
      state = const DeleteUserLoading();
      final Either<Object?, bool> res =
          await FirebaseAuthService.instance.deleteUser(
        preDeleteAction: preDeleteAction,
        afterDeleteAction: afterDeleteAction,
      );
      res.fold(
        (l) {
          if (AuthExceptions.isUserNotFound(l)) {
            _userNotFound();
          } else {
            state = OneDayAuthException(l);
          }
        },
        (r) => state = const OneDayAuthUnauthorized(),
      );
    } catch (e) {
      state = OneDayAuthException(e);
    }
  }

  Future<void> _userNotFound({
    final AuthActionCallback preDeleteAction,
    final FutureVoidCallback? afterDeleteAction,
  }) async {
    final Either<Object?, bool> res =
        await FirebaseAuthService.instance.signOut(
      preSignOutAction: preDeleteAction,
      afterSignOutAction: afterDeleteAction,
    );
    res.fold(
      (l) => state = OneDayAuthException(l),
      (r) => state = const OneDayAuthUnauthorized(),
    );
  }

  @override
  void setAwaiting() => state = const DeleteUserReAuthAwaiting();

  @override
  void setInitial() => state = initalState;
}
