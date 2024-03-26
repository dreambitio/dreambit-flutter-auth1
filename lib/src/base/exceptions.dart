part of '../../one_day_auth.dart';

/// Exceptions for auth functional
class AuthExceptions {
  static const String invalidEmail = 'invalid-email';
  static const String invalidPhoneNumber = 'invalid-phone-number';
  static const String missingEmail = 'missing-email';
  static const String invalidCredential = 'invalid-credential';
  static const String userNotFound = 'user-not-found';
  static const String signInFailed = 'sign-in-failed';
  static const String emailAlreadyInUse = 'email-already-in-use';
  static const String accountExistsWithDifferentCredential =
      'account-exists-with-different-credential';
  static const String tooManyRequests = 'too-many-requests';
  static const String wrongPassword = 'wrong-password';
  static const String credentialAlreadyInUse = 'credential-already-in-use';
  static const String invalidVerificationCode = 'invalid-verification-code';
  static const String weakPassword = 'weak-password';
  static const String requiresRecentLogin = 'requires-recent-login';
  static const String popupClosed = 'popup-closed';
  static const String popupClosedSecond = 'popup_closed';
  static const String webContextCancelled = 'web-context-cancelled';
  static const String webContextCanceled = 'web-context-canceled';
  static const String operationNotAllowed = 'operation-not-allowed';
  static const String userMismatch = 'user-mismatch';
  static const String unknown = 'unknown';

  /// invalid-credential [FirebaseAuthException]
  static bool isInvalidCredential(final Object? exception) {
    if (exception is FirebaseAuthException) {
      return exception.code == invalidCredential;
    }
    return false;
  }

  /// requires-recent-login [FirebaseAuthException]
  static bool isReAuthException(final Object? exception) {
    if (exception is FirebaseAuthException) {
      return exception.code == requiresRecentLogin;
    }
    return false;
  }

  /// weak-password [FirebaseAuthException]
  static bool isWeakPasswordException(final Object? exception) {
    if (exception is FirebaseException) {
      return exception.code == weakPassword;
    }
    return false;
  }

  /// web-context-cancelled [FirebaseAuthException]
  static bool isWebContextCancelled(final Object? exception) {
    if (exception is FirebaseException) {
      return exception.code == webContextCancelled ||
          exception.code == webContextCanceled;
    }
    return false;
  }

  /// user-not-found [FirebaseAuthException]
  static bool isUserNotFound(final Object? exception) {
    if (exception is FirebaseException) {
      return exception.code == userNotFound;
    }
    return false;
  }

  /// get exception [OneDayAuthException]
  static Object? getAuthException(final OneDayAuthState state) {
    if (state is OneDayAuthException) {
      return state.exception;
    }
    return null;
  }

  /// exception message [FirebaseAuthException]
  static String messageFirebaseAuthException({
    required final BuildContext context,
    String? code,
  }) {
    final AuthLocalizationLabels l = AuthLocalizations.labelsOf(context);
    switch (code) {
      case invalidEmail:
        return l.invalidEmail;
      case invalidPhoneNumber:
        return l.invalidPhoneNumber;
      case missingEmail:
        return l.missingEmail;
      case invalidCredential:
        return l.invalidCredential;
      case userNotFound:
        return l.userNotFound;
      case signInFailed:
        return l.authorizationError;
      case emailAlreadyInUse:
        return l.emailAlreadyInUse;
      case accountExistsWithDifferentCredential:
        return l.accountExistsWithDifferentCredential;
      case tooManyRequests:
        return l.accessToAccountTemporarilyDisabled;
      case wrongPassword:
        return l.passwordInvalidOrUserDoesNotHavePassword;
      case credentialAlreadyInUse:
        return l.providerIsAssociatedWithDifferentAccount;
      case invalidVerificationCode:
        return l.codeIsInvalidTryAgain;
      case weakPassword:
        return l.passwordSixCharacters;
      case requiresRecentLogin:
        return l.pleaseLogInAgainBeforeRetrying;
      case popupClosed:
      case popupClosedSecond:
      case webContextCancelled:
      case webContextCanceled:
        return l.interactionWasCancelled;
      case operationNotAllowed:
        return l.serviceIsCurrentlyUnavailable;
      case userMismatch:
        return l.suppliedCredentialsDoNotCorrespondPreviouslyUser;
      case unknown:
      default:
        return l.somethingWentWrong;
    }
  }

  /// exception message [Object]
  static String exceptionMessage({
    required final BuildContext context,
    required final Object? exception,
  }) {
    final AuthLocalizationLabels l = AuthLocalizations.labelsOf(context);
    if (exception is FirebaseAuthException) {
      return messageFirebaseAuthException(
        context: context,
        code: exception.code,
      );
    }
    return l.somethingWentWrong;
  }
}
