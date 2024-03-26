part of '../../../one_day_auth.dart';

abstract class PhoneCodeBase extends OneDayAuthState {
  final CodeSentResult? codeSentResult;

  PhoneCodeBase([this.codeSentResult]);
}

class PhoneInitial extends OneDayAuthState {
  PhoneInitial();
}

class PhoneLoading extends OneDayAuthLoading {
  PhoneLoading();
}

class PhoneCodeInitial extends PhoneCodeBase {
  PhoneCodeInitial([super.codeSentResult]);
}

class PhoneCodeLoading extends PhoneCodeBase {
  PhoneCodeLoading([super.codeSentResult]);
}

class PhoneCodeSent extends PhoneCodeBase {
  PhoneCodeSent([super.codeSentResult]);
}

class PhoneCodeCompleted extends OneDayAuthAuthorized {
  final UserCredential userCredential;

  PhoneCodeCompleted(this.userCredential);
}

class PhoneCodeException extends OneDayAuthException {
  final CodeSentResult? codeSentResult;

  PhoneCodeException(
    super.exeption, {
    this.codeSentResult,
  });
}
