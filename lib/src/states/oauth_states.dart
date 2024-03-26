part of '../../one_day_auth.dart';

class OAuthInitial extends OneDayAuthState {
  const OAuthInitial();
}

class OAuthLoading extends OneDayAuthLoading {
  const OAuthLoading();
}

class OAuthAuthorized extends OneDayAuthAuthorized {
  final UserCredential userCredential;

  OAuthAuthorized(this.userCredential);
}
