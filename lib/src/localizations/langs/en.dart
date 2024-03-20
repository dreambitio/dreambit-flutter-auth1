import '../default_localizations.dart';

class EnLocalizations extends AuthLocalizationLabels {
  const EnLocalizations();
  @override
  String get yes => 'Yes';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get signOutQ => 'Sign out?';

  @override
  String get signOutDescription => 'Are you sure you want to sign out?';

  @override
  String get deleteAccountQ => 'Delete account?';

  @override
  String get deleteAccountDescription =>
      'Are you sure you want to delete your account?';

  @override
  String get changePassword => 'Change password';

  @override
  String get confirmYourPassword => 'Confirm your password.';

  @override
  String get password => 'Password';

  @override
  String get newPassword => 'New password';

  @override
  String get invalidPassword => 'Invalid password';

  @override
  String get confirmNewPassword => 'Confirm new password';

  @override
  String get confirmNewPasswordDescription =>
      'Confirm your password and enter a new one.';

  @override
  String get code => 'Code';

  @override
  String get invalidCode => 'Invalid code';

  @override
  String get enterVerificationCode => 'Enter verification code';

  @override
  String get weSentCodeToYourPhone =>
      'Weʼve sent you a code to your phone number.';

  @override
  String get continueWithApple => 'Continue with Apple';

  @override
  String get continueWithFacebook => 'Continue with Facebook';

  @override
  String get continueWithGitHub => 'Continue with GitHub';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueWithMicrosoft => 'Continue with Microsoft';

  @override
  String get continueWithTwitterX => 'Continue with X';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get invalidEmail => 'Invalid email';

  @override
  String get invalidPhoneNumber => 'Invalid phone number';

  @override
  String get missingEmail => 'Email is missing';

  @override
  String get invalidCredential =>
      'The supplied auth credential is malformed or has expired.';

  @override
  String get userNotFound => 'Account doesnʼt exist';

  @override
  String get authorizationError => 'Authorization error';

  @override
  String get emailAlreadyInUse => 'An account with this email already exists';

  @override
  String get accountExistsWithDifferentCredential =>
      'An account already exists with the same email address but different sign-in credentials.';

  @override
  String get accessToAccountTemporarilyDisabled =>
      'Access to this account has been temporarily disabled';

  @override
  String get passwordInvalidOrUserDoesNotHavePassword =>
      'The password is invalid or the user does not have a password';

  @override
  String get providerIsAssociatedWithDifferentAccount =>
      'This provider is associated with a different user account';

  @override
  String get codeIsInvalidTryAgain =>
      'The code you entered is invalid, please try again';

  @override
  String get passwordSixCharacters =>
      'Password should be at least 6 characters';

  @override
  String get pleaseLogInAgainBeforeRetrying =>
      'Please log in again before retrying.';

  @override
  String get interactionWasCancelled => 'The interaction was cancelled';

  @override
  String get serviceIsCurrentlyUnavailable =>
      'The service is currently unavailable';

  @override
  String get suppliedCredentialsDoNotCorrespondPreviouslyUser =>
      'The supplied credentials do not correspond to the previously signed in user';
}
