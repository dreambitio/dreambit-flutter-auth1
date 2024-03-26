part of '../../one_day_auth.dart';

abstract interface class AuthController {
  OneDayAuthState get initalState;
}

abstract class OneDayAuthState {
  const OneDayAuthState();
}

class OneDayAuthUnauthorized extends OneDayAuthState {
  const OneDayAuthUnauthorized();
}

class OneDayAuthAuthorized extends OneDayAuthState {
  const OneDayAuthAuthorized();
}

class OneDayAuthLoading extends OneDayAuthState {
  const OneDayAuthLoading();
}

class OneDayAuthException extends OneDayAuthState {
  final Object? exception;

  OneDayAuthException([this.exception]);
}

mixin OneDayAuthStateMixin on ChangeNotifier {
  OneDayAuthState _state = const OneDayAuthUnauthorized();

  OneDayAuthState get state => _state;

  set state(final OneDayAuthState value) {
    oldState = state;
    _state = value;
    notifyListeners();
  }

  OneDayAuthState _oldState = const OneDayAuthUnauthorized();

  OneDayAuthState get oldState => _oldState;

  set oldState(final OneDayAuthState value) {
    _oldState = value;
  }

  AuthActions _action = AuthActions.signIn;

  AuthActions get action => _action;

  set action(final AuthActions value) {
    _action = value;
    notifyListeners();
  }

  void changeAction([final AuthActions? value]) {
    action = value ??
        (action == AuthActions.signUp
            ? AuthActions.signIn
            : AuthActions.signUp);
  }
}
