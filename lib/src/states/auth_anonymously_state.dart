part of '../../one_day_auth.dart';

class AuthAnonymouslyInitial extends OneDayAuthState {
  const AuthAnonymouslyInitial();
}

class AuthAnonymouslyLoading extends OneDayAuthLoading {
  const AuthAnonymouslyLoading();
}

class AuthAnonymouslyAuthorized extends OneDayAuthAuthorized {
  final UserCredential userCredential;

  AuthAnonymouslyAuthorized(this.userCredential);
}
