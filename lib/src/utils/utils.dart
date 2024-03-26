part of '../../one_day_auth.dart';

/// Utils for authorization functional
class AuthUtils {
  /// default redirect uri
  static String defaultRedirectUri(final String authProjectId) {
    return 'https://$authProjectId.firebaseapp.com/__/auth/handler';
  }

  /// twitter redirect uri for Android (bundleId) and iOS (bundleURLScheme)
  static String twitterRedirectUri({
    required final String authProjectId,
    String? bundleURLScheme,
    String? bundleId,
    String? redirectUri,
  }) {
    if (!redirectUri.isNullOrEmptyText) return redirectUri ?? '';
    final String defaultUri = defaultRedirectUri(authProjectId);
    if (kIsWeb) {
      return defaultUri;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      if (bundleURLScheme.isNullOrEmptyText) {
        return defaultUri;
      }
      return '$bundleURLScheme://';
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      if (bundleId.isNullOrEmptyText) {
        return defaultUri;
      }
      return '$bundleId://';
    }
    return defaultUri;
  }

  /// is user provider data contain password
  static bool isUserAuthIsPassword(final User? user) {
    return user?.providerData.containPassword() ?? false;
  }

  /// is current platform is iOS application
  static bool get isIos =>
      kIsWeb ? false : defaultTargetPlatform == TargetPlatform.iOS;

  /// is target platform is macOS or iOS
  static bool get isApple =>
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.iOS;
}
