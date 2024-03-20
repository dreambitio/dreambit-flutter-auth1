part of '../../one_day_auth.dart';

class ReAuthPhoneCodeInitial extends PhoneCodeBase {
  ReAuthPhoneCodeInitial([super.codeSentResult]);
}

class ReAuthPhoneCodeWebContextCancelled extends OneDayAuthState {
  ReAuthPhoneCodeWebContextCancelled();
}

class ReAuthPhoneCodeAwaiting extends PhoneCodeBase {
  ReAuthPhoneCodeAwaiting([super.codeSentResult]);
}

class ReAuthPhoneCodeLoading extends PhoneCodeBase {
  ReAuthPhoneCodeLoading([super.codeSentResult]);
}

class ReAuthPhoneCodeCompleted extends PhoneCodeCompleted {
  ReAuthPhoneCodeCompleted(super.userCredential);
}

class ReAuthPhoneCodeException extends PhoneCodeException {
  ReAuthPhoneCodeException(super.exeption, {super.codeSentResult});
}
