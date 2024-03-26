part of '../../one_day_auth.dart';

/// List [UserInfo] extension
extension ListUserInfoExtension on List<UserInfo>? {
  /// get first provider
  AuthEnums getAuthProvider() {
    for (final UserInfo v in this ?? []) {
      final AuthEnums? res = AuthEnums.map[v.providerId];
      return res ?? AuthEnums.undefined;
    }
    return AuthEnums.undefined;
  }

  /// contain password provider
  bool containPassword() {
    for (final UserInfo v in this ?? []) {
      if (v.providerId == AuthEnums.password.name) {
        return true;
      }
    }
    return false;
  }
}

/// [String]? extension
extension ServiceStringNullableExtension on String? {
  /// is null or isEmpty
  bool get isNullOrEmptyText => this?.trim().isEmpty ?? true;

  /// get uri
  Uri get defaultUri => Uri.parse(toString());

  /// is email valid
  bool get isValidDefaultEmail {
    if (isNullOrEmptyText) return false;
    return ServiceRegExp.emailRegExp.hasMatch(this!);
  }

  /// is password valid
  bool get isValidDefaultPassword {
    if (isNullOrEmptyText) return false;
    if (this!.contains(' ')) return false;
    return this!.length >= 4;
  }

  /// is phone number valid
  bool get isValidDefaultPhoneNumber {
    if (isNullOrEmptyText) return false;
    if (this!.length < 9) return false;
    return ServiceRegExp.numRegExp.hasMatch(this!);
  }

  /// is code valid
  bool get isValidDefaultCode {
    if (isNullOrEmptyText) return false;
    if (this!.length < 6) return false;
    return ServiceRegExp.numRegExp.hasMatch(this!);
  }

  /// clear phone number
  String get clearDefaultPhoneNumber {
    if (isNullOrEmptyText) return '';
    final String prefix = this!.contains('+') ? '' : '+';
    return prefix + this!.replaceAll(' ', '');
  }
}
