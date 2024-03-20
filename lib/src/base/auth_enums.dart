part of '../../one_day_auth.dart';

enum AuthActions {
  signUp,
  signIn,
}

enum AuthenticateActions {
  authorization,
  reAuthenticate,
}

enum AuthEnums {
  undefined('undefined'),
  phone('phone'),
  password('password'),
  apple('apple.com'),
  facebook('facebook.com'),
  github('github.com'),
  google('google.com'),
  microsoft('microsoft.com'),
  twitter('twitter.com');

  const AuthEnums(this.value);

  /// provider name
  final String value;

  /// map: provider name - enum
  static final Map<String, AuthEnums> map = <String, AuthEnums>{
    AuthEnums.undefined.value: AuthEnums.undefined,
    AuthEnums.password.value: AuthEnums.password,
    AuthEnums.phone.value: AuthEnums.phone,
    AuthEnums.apple.value: AuthEnums.apple,
    AuthEnums.facebook.value: AuthEnums.facebook,
    AuthEnums.github.value: AuthEnums.github,
    AuthEnums.google.value: AuthEnums.google,
    AuthEnums.microsoft.value: AuthEnums.microsoft,
    AuthEnums.twitter.value: AuthEnums.twitter,
  };

  /// apple, github, microsoft, twitter
  AuthProvider? get commonProvider {
    switch (this) {
      case AuthEnums.apple:
        return AppleAuthProvider();
      case AuthEnums.github:
        return GithubAuthProvider();
      case AuthEnums.microsoft:
        return MicrosoftAuthProvider();
      case AuthEnums.twitter:
        return TwitterAuthProvider();
      default:
        return null;
    }
  }
}
