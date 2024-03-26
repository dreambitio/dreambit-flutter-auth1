# One Day Auth

Authentication package for Flutter based on [firebase_auth](https://github.com/firebase/flutterfire/tree/master/packages/firebase_auth/firebase_auth). This package provides advanced functionality for managing user authentication in Android, iOS, and web applications.

Integrated with [firebase_auth](https://github.com/firebase/flutterfire/tree/master/packages/firebase_auth/firebase_auth), `one_day_auth` package allows easy configuration of various authentication methods, including email and password authentication, phone number authentication, as well as social media account authentication such as Google, Apple, Facebook, Twitter, GitHub and sign in anonymously.

The package automatically handles all aspects of authentication, allowing developers to focus on implementing the application's functionality without spending time on authentication details.

Use our Flutter library to quickly and efficiently implement a secure and advanced authentication mechanism in your application!

## Installing

Git

```yaml
  one_day_auth:
    git:
      url: # git https url
      ref: # branch, if needed
```

Local

```yaml
  one_day_auth:
    path: # local path
```

Before using the package, make sure that the basic settings are configured.

- [Email and password](https://firebase.google.com/docs/auth/flutter/password-auth)
- [Phone](https://firebase.google.com/docs/auth/flutter/phone-auth)
- [Social account authentication](https://firebase.google.com/docs/auth/flutter/federated-auth)
- [Anonymous](https://firebase.google.com/docs/auth/flutter/anonymous-auth)

## Builders

The library contains such builders: `EmailPasswordBuilder`, `PhoneBuilder`, `PhoneCodeBuilder`, `PhoneWithCodeBuilder`, `OAuthBuilder`, `AuthAnonymouslyBuilder`, `SignOutBuilder`, `EmailVerificationBuilder`, `DeleteUserBuilder`, `ReAuthPasswordBuilder`, `ReAuthPhoneCodeBuilder`, `ForgottenPasswordBuilder`, `ChangePasswordBuilder`. These builders are part of the main views.

## Views

The view contains a listener, a builder, and basic parameters required for functionality.

- `EmailPasswordView` - sign in / sign up with password (email/password fields)
- `PhoneView` - sign in / sign up with phone (phone field)
- `PhoneCodeView` sign in / sign up with phone (code field)
- `PhoneWithCodeView` sign in / sign up with phone (phone/code fields)
- `ForgottenPasswordView` - forgotten password functionality
- `EmailVerificationView` - email verification functionality
- `SignOutView` - sign out functionality
- `DeleteUserView` - delete user functionality
- `ChangePasswordView` - change password functionality
- `ReAuthPasswordView` - password re-authentication
- `ReAuthPhoneCodeView` - phone re-authentication
- `AppleSignInView` - sign in with Apple
- `FacebookSignInView` - sign in with Facebook
- `GitHubSignInView` - sign in with GitHub
- `GoogleSignInView` - sign in with Google
- `TwitterSignInView` - sign in with Twitter
- `AuthAnonymouslyView` - sign in anonymously

## UI

### Email and password screen

States: `EmailPasswordInitial`, `EmailPasswordLoading`, `EmailPasswordSignedUp`, `EmailPasswordSignedIn`, `OneDayAuthException`

```dart
EmailPasswordView(
  initialAuthAction: AuthActions.signIn, // initial auth action signIn/signUp
  listener: (OneDayAuthState state) {
    // listener
  },
  builder: ({
    required BuildContext context,
    required AuthActions action,
    required OneDayAuthState state,
    required bool isLoading,
    required Object? exception,
    required VoidCallback changeAction,
    required EmailPasswordCallback onSubmit,
  }) {
    // UI
  },
)
```

### Screen with phone number

States: `PhoneInitial`, `PhoneLoading`, `PhoneCodeSent`, `OneDayAuthException`

```dart
PhoneView(
  initialAuthAction: AuthActions.signIn, // initial auth action signIn/signUp
  listener: (OneDayAuthState state, AuthActions action) {
    // listener
  },
  builder: ({
    required BuildContext context,
    required OneDayAuthState state,
    required AuthActions action,
    required bool isLoading,
    required Object? exception,
    required VoidCallback changeAction,
    required Future<void> Function(String phoneNumber) sendCode,
  }) {
    // UI
  },
)
```

### Screen with code

States: `PhoneCodeInitial`, `PhoneCodeLoading`, `PhoneCodeException`, `PhoneCodeCompleted`, `OneDayAuthException`

```dart
PhoneCodeView(
  initialAuthAction: AuthActions.signIn, // initial auth action signIn/signUp
  codeSentResult: codeSentResult,
  listener: (OneDayAuthState state, AuthActions action) {
    // listener
  },
  builder: ({
    required BuildContext context,
    required AuthActions action,
    required OneDayAuthState state,
    required CodeSentResult codeSentResult,
    required bool isLoading,
    required Object? exception,
    required FutureVoidCallback sendCode,
    required ConfirmCodeCallback confirm,
  }) {
    // UI
  },
)
```

### Phone and code screen

States: `PhoneCodeInitial`, `PhoneLoading`, `PhoneCodeSent`, `PhoneCodeLoading`, `PhoneCodeException`, `PhoneCodeCompleted`, `OneDayAuthException`

```dart
PhoneWithCodeView(
  initialAuthAction: AuthActions.signIn, // initial auth action signIn/signUp
  listener: (OneDayAuthState state, AuthActions action) {
    // listener
  },
  builder: ({
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
  }) {
    // UI
  },
)
```

### Forgotten password functionality

States: `ForgottenPasswordInitial`, `ForgottenPasswordLoading`, `ForgottenPasswordMailSent`, `OneDayAuthException`

```dart
ForgottenPasswordView(
  listener: (OneDayAuthState state) {
    // listener
  },
  builder: ({
    required BuildContext context,
    required OneDayAuthState state,
    required bool isLoading,
    required bool isMailSent,
    required Future<void> Function(String email) sendMail,
    required Object? exception,
  }) {
    // UI
  },
)
```

### Email verification functionality

States: `EmailVerification`, `EmailVerified`, `EmailVerificationUnavailable`, `EmailVerificationLoading`, `EmailVerificationAwaiting`, `EmailVerificationCheckAwaiting`, `OneDayAuthException`

```dart
EmailVerificationView(
  listener: (OneDayAuthState state) {
    // listener
  },
  builder: ({
    required BuildContext context,
    required OneDayAuthState state,
    required bool isLoading,
    required FutureVoidCallback sendMail,
    required FutureVoidCallback checkVerification,
    required Object? exception,
  }) {
    // UI
  },
)
```

### Sign out functionality

States: `SignOutInitial`, `SignOutLoading`, `OneDayAuthException`

```dart
SignOutView(
  listener: (OneDayAuthState state) {
    // listener
  },
  builder: ({
    required BuildContext context,
    required OneDayAuthState state,
    required bool isLoading,
    required FutureVoidCallback signOut,
    required Object? exception,
  }) {
    // UI
  },
)
```

### Delete user functionality

States: `DeleteUserInitial`, `DeleteUserReAuthAwaiting`, `DeleteUserLoading`, `OneDayAuthException`

```dart
DeleteUserView(
  googleWebClientId: webClientId, // if required for functionality
  facebookAppId: facebookClientId, // if required for functionality
  preDeleteAction: (User? user) async {
    // before deletion action, if required for functionality
  },
  listener: (OneDayAuthState state) {
    // listener
  },
  builder: ({
    required BuildContext context,
    required OneDayAuthState state,
    required VoidCallback setInitial,
    required VoidCallback setAwaiting,
    required bool isLoading,
    required FutureVoidCallback deleteUser,
    required Object? exception,
  }) {
    // UI
  },
)
```

### Change password functionality

States: `ChangePasswordInitial`, `ChangePasswordInvalidCurrentPassword`, `ChangePasswordLoading`, `ChangePasswordCompleted`, `OneDayAuthException`

```dart
ChangePasswordView(
  listener: (OneDayAuthState state) {
    // listener
  },
  builder: ({
    required BuildContext context,
    required OneDayAuthState state,
    required bool isLoading,
    required ChangePasswordCallback changePassword,
    required VoidCallback setInitialState,
    required Object? exception,
  }) {
    // UI
  },
)
```

### Password re-authentication

States: `ReAuthPasswordInitial`, `ReAuthPasswordLoading`, `ReAuthPasswordCompleted`, `OneDayAuthException`

```dart
ReAuthPasswordView(
  listener: (OneDayAuthState state) {
    // listener
  },
  builder: ({
    required BuildContext context,
    required OneDayAuthState state,
    required bool isLoading,
    required Future<void> Function(String password) reAuth,
    required Object? exception,
  }) {
    // UI
  },
)
```

### Phone re-authentication

States: `ReAuthPhoneCodeInitial`, `ReAuthPhoneCodeWebContextCancelled`, `ReAuthPhoneCodeAwaiting`, `ReAuthPhoneCodeLoading`, `ReAuthPhoneCodeCompleted`, `ReAuthPhoneCodeException`, `OneDayAuthException`

```dart
ReAuthPhoneCodeView(
  listener: (OneDayAuthState state) {
    // listener
  },
  builder: ({
    required BuildContext context,
    required OneDayAuthState state,
    required bool isLoading,
    required bool codeAwaiting,
    required VoidCallback setInitialState,
    required Future<void> Function(String code) reAuth,
    required Object? exception,
  }) {
    // UI
  },
)
```

### Sign in with Apple

States: `OAuthInitial`, `OAuthLoading`, `OAuthAuthorized`, `OneDayAuthException`

```dart
AppleSignInView(
  listener: (OneDayAuthState state) {
    // listener
  },
  builder: ({
    required BuildContext context,
    required OneDayAuthState state,
    required bool isLoading,
    required SignInCallback signIn,
    required Object? exception,
  }) {
    // UI
  },
)
```

### Sign in with Facebook

States: `OAuthInitial`, `OAuthLoading`, `OAuthAuthorized`, `OneDayAuthException`

```dart
FacebookSignInView(
  appId: facebookClientId,
  listener: (OneDayAuthState state) {
    // listener
  },
  builder: ({
    required BuildContext context,
    required OneDayAuthState state,
    required bool isLoading,
    required SignInCallback signIn,
    required Object? exception,
  }) {
    // UI
  },
)
```

### Sign in with GitHub

States: `OAuthInitial`, `OAuthLoading`, `OAuthAuthorized`, `OneDayAuthException`

```dart
GitHubSignInView(
  listener: (OneDayAuthState state) {
    // listener
  },
  builder: ({
    required BuildContext context,
    required OneDayAuthState state,
    required bool isLoading,
    required SignInCallback signIn,
    required Object? exception,
  }) {
    // UI
  },
)
```

### Sign in with Google

States: `OAuthInitial`, `OAuthLoading`, `OAuthAuthorized`, `OneDayAuthException`

```dart
GoogleSignInView(
  webClientId: webClientId,
  listener: (OneDayAuthState state) {
    // listener
  },
  builder: ({
    required BuildContext context,
    required OneDayAuthState state,
    required bool isLoading,
    required SignInCallback signIn,
    required Object? exception,
  }) {
    // UI
  },
)
```

### Sign in with Twitter

States: `OAuthInitial`, `OAuthLoading`, `OAuthAuthorized`, `OneDayAuthException`

```dart
TwitterSignInView(
  listener: (OneDayAuthState state) {
    // listener
  },
  builder: ({
    required BuildContext context,
    required OneDayAuthState state,
    required bool isLoading,
    required SignInCallback signIn,
    required Object? exception,
  }) {
    // UI
  },
)
```

### Sign in anonymously

States: `AuthAnonymouslyInitial`, `AuthAnonymouslyLoading`, `AuthAnonymouslyAuthorized`, `OneDayAuthException`

```dart
AuthAnonymouslyView(
  listener: (OneDayAuthState state) {
    // listener
  },
  builder: ({
    required BuildContext context,
    required OneDayAuthState state,
    required bool isLoading,
    required SignInCallback signIn,
    required Object? exception,
  }) {
    // UI
  },
)
```

## Default UI

The package contains default dialogs and buttons for authentication.

`AuthDialogs` contains:

- `showDefaultActionDialog`
- `showReAuthPasswordDialog`
- `showReAuthPhoneCodeDialog`
- `showChangePasswordDialog`

Example:

```dart
final bool res = await AuthDialogs.showDefaultActionDialog(
  context: context,
  title: AuthLocalizations.labelsOf(context).deleteAccountQ,
  subtitle: AuthLocalizations.labelsOf(context).deleteAccountDescription,
);
```

Default sign in buttons:

- `AppleSignInButton`
- `FacebookSignInButton`
- `GitHubSignInButton`
- `GoogleSignInButton`
- `TwitterXSignInButton`

Example:

```dart
GoogleSignInView(
  webClientId: webClientId,
  listener: (OneDayAuthState state) {
    // listener
  },
  builder: ({
    required BuildContext context,
    required OneDayAuthState state,
    required bool isLoading,
    required SignInCallback signIn,
    required Object? exception,
  }) {
    return GoogleSignInButton(
      onPressed: signIn,
      isLoading: isLoading,
    );
  },
)
```

## Listener

Example of how various actions can be handled:

```dart
listener: (OneDayAuthState state) {
  if (state is OAuthAuthorized) {
    _authorizedRoute();
  } else if (state is OneDayAuthException) {
    AppSnackBar.show(
      context: context,
      subtitle: AuthExceptions.exceptionMessage(
        context: context,
        exception: state.exception,
      ),
    );
  }
}
```

## Utilities

The package contains default utilities `AuthUtils`, `ServiceRegExp`, `ServiceStringNullableExtension`, `ListUserInfoExtension`, `AuthLocalizations`, for exceptions handling/localization `AuthExceptions`. There is also the option to utilize `FirebaseAuthService.instance`.
