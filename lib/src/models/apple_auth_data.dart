part of '../../one_day_auth.dart';

/// Required data for android/web Apple authorization
class AppleAuthData {
  /// client id
  final String clientId;

  /// redirect uri
  final String? redirectUri;

  const AppleAuthData({
    required this.clientId,
    this.redirectUri,
  });
}
