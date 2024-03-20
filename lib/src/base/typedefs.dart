part of '../../one_day_auth.dart';

typedef FutureVoidCallback = Future<void> Function();

typedef EmailPasswordCallback = Future<void> Function({
  required String email,
  required String password,
  AuthActionCallback afterSignInAction,
  AuthActionCallback afterSignUpAction,
});

typedef AuthActionCallback = Future<void> Function(User? user)?;

typedef ConfirmCodeCallback = Future<void> Function({
  required String code,
  AuthActionCallback afterAuthAction,
});

typedef ConfirmPhoneWithCodeCallback = Future<void> Function({
  required String code,
  AuthActionCallback afterAuthAction,
});

typedef SignInCallback = Future<void> Function({
  AuthActionCallback afterAuthAction,
});

typedef ChangePasswordCallback = Future<void> Function({
  required String password,
  required String newPassword,
});

typedef EmailPasswordBuilder = Widget Function({
  required BuildContext context,
  required AuthActions action,
  required OneDayAuthState state,
  required bool isLoading,
  required VoidCallback changeAction,
  required EmailPasswordCallback onSubmit,
  required Object? exception,
});

typedef PhoneBuilder = Widget Function({
  required BuildContext context,
  required AuthActions action,
  required OneDayAuthState state,
  required bool isLoading,
  required VoidCallback changeAction,
  required Future<void> Function(String phoneNumber) sendCode,
  required Object? exception,
});

typedef PhoneCodeBuilder = Widget Function({
  required BuildContext context,
  required OneDayAuthState state,
  required AuthActions action,
  required CodeSentResult codeSentResult,
  required bool isLoading,
  required ConfirmCodeCallback confirm,
  required FutureVoidCallback sendCode,
  required Object? exception,
});

typedef PhoneWithCodeBuilder = Widget Function({
  required BuildContext context,
  required OneDayAuthState state,
  required AuthActions action,
  required CodeSentResult? codeSentResult,
  required bool phoneAwaiting,
  required bool codeAwaiting,
  required bool isCodeSent,
  required VoidCallback changeAction,
  required VoidCallback setInitialState,
  required Future<void> Function(String phoneNumber) sendCode,
  required ConfirmPhoneWithCodeCallback confirm,
  required Object? exception,
});

typedef OAuthBuilder = Widget Function({
  required BuildContext context,
  required OneDayAuthState state,
  required bool isLoading,
  required SignInCallback signIn,
  required Object? exception,
});

typedef AuthAnonymouslyBuilder = Widget Function({
  required BuildContext context,
  required OneDayAuthState state,
  required bool isLoading,
  required SignInCallback signIn,
  required Object? exception,
});

typedef SignOutBuilder = Widget Function({
  required BuildContext context,
  required OneDayAuthState state,
  required bool isLoading,
  required FutureVoidCallback signOut,
  required Object? exception,
});

typedef EmailVerificationBuilder = Widget Function({
  required BuildContext context,
  required OneDayAuthState state,
  required bool isLoading,
  required FutureVoidCallback sendMail,
  required FutureVoidCallback checkVerification,
  required Object? exception,
});

typedef DeleteUserBuilder = Widget Function({
  required BuildContext context,
  required OneDayAuthState state,
  required VoidCallback setInitial,
  required VoidCallback setAwaiting,
  required bool isLoading,
  required FutureVoidCallback deleteUser,
  required Object? exception,
});

typedef ReAuthPasswordBuilder = Widget Function({
  required BuildContext context,
  required OneDayAuthState state,
  required bool isLoading,
  required Future<void> Function(String password) reAuth,
  required Object? exception,
});

typedef ReAuthPhoneCodeBuilder = Widget Function({
  required BuildContext context,
  required OneDayAuthState state,
  required bool isLoading,
  required bool codeAwaiting,
  required VoidCallback setInitialState,
  required Future<void> Function(String code) reAuth,
  required Object? exception,
});

typedef ForgottenPasswordBuilder = Widget Function({
  required BuildContext context,
  required OneDayAuthState state,
  required bool isLoading,
  required bool isMailSent,
  required Future<void> Function(String email) sendMail,
  required Object? exception,
});

typedef ChangePasswordBuilder = Widget Function({
  required BuildContext context,
  required OneDayAuthState state,
  required bool isLoading,
  required ChangePasswordCallback changePassword,
  required VoidCallback setInitialState,
  required Object? exception,
});
