part of '../../one_day_auth.dart';

/// Required data for Twitter authorization
class TwitterAuthData {
  /// Twitter api key
  final String apiKey;

  /// Twitter api key secret
  final String apiSecretKey;

  /// bundle url scheme
  final String bundleURLScheme;

  /// bundle id
  final String bundleId;

  /// custom redirect uri
  final String? redirectUri;

  const TwitterAuthData({
    required this.apiKey,
    required this.apiSecretKey,
    required this.bundleURLScheme,
    required this.bundleId,
    this.redirectUri,
  });
}
