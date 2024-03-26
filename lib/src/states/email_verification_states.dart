part of '../../one_day_auth.dart';

class EmailVerification extends OneDayAuthState {
  const EmailVerification();
}

class EmailVerified extends OneDayAuthState {
  const EmailVerified();
}

class EmailVerificationUnavailable extends OneDayAuthState {
  const EmailVerificationUnavailable();
}

class EmailVerificationLoading extends OneDayAuthLoading {
  const EmailVerificationLoading();
}

class EmailVerificationAwaiting extends OneDayAuthState {
  const EmailVerificationAwaiting();
}

class EmailVerificationCheckAwaiting extends EmailVerificationAwaiting {
  const EmailVerificationCheckAwaiting();
}
