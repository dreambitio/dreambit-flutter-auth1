import 'langs/en.dart';

abstract class AuthLocalizationLabels {
  const AuthLocalizationLabels();

  String get yes;

  String get cancel;

  String get confirm;

  String get signOutQ;

  String get signOutDescription;

  String get deleteAccountQ;

  String get deleteAccountDescription;

  String get changePassword;

  String get confirmYourPassword;

  String get password;

  String get newPassword;

  String get invalidPassword;

  String get confirmNewPassword;

  String get confirmNewPasswordDescription;

  String get code;

  String get invalidCode;

  String get enterVerificationCode;

  String get weSentCodeToYourPhone;

  String get continueWithApple;

  String get continueWithFacebook;

  String get continueWithGitHub;

  String get continueWithGoogle;

  String get continueWithMicrosoft;

  String get continueWithTwitterX;

  String get somethingWentWrong;

  String get invalidEmail;

  String get invalidPhoneNumber;

  String get missingEmail;

  String get invalidCredential;

  String get userNotFound;

  String get authorizationError;

  String get emailAlreadyInUse;

  String get accountExistsWithDifferentCredential;

  String get accessToAccountTemporarilyDisabled;

  String get passwordInvalidOrUserDoesNotHavePassword;

  String get providerIsAssociatedWithDifferentAccount;

  String get codeIsInvalidTryAgain;

  String get passwordSixCharacters;

  String get pleaseLogInAgainBeforeRetrying;

  String get interactionWasCancelled;

  String get serviceIsCurrentlyUnavailable;

  String get suppliedCredentialsDoNotCorrespondPreviouslyUser;
}

class DefaultLocalizations extends EnLocalizations {
  const DefaultLocalizations();
}
