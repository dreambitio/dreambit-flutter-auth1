part of '../../one_day_auth.dart';

class ForgottenPasswordInitial extends OneDayAuthState {
  const ForgottenPasswordInitial();
}

class ForgottenPasswordLoading extends OneDayAuthLoading {
  const ForgottenPasswordLoading();
}

class ForgottenPasswordMailSent extends OneDayAuthState {
  final String? email;

  ForgottenPasswordMailSent([this.email]);
}
