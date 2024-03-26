part of '../../one_day_auth.dart';

class EmailPasswordInitial extends OneDayAuthState {
  const EmailPasswordInitial();
}

class EmailPasswordLoading extends OneDayAuthLoading {
  const EmailPasswordLoading();
}

class EmailPasswordSignedUp extends OneDayAuthAuthorized {
  final UserCredential userCredential;

  EmailPasswordSignedUp(this.userCredential);
}

class EmailPasswordSignedIn extends OneDayAuthAuthorized {
  final UserCredential userCredential;

  EmailPasswordSignedIn(this.userCredential);
}
