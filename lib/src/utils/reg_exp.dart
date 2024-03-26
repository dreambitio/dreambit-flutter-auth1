part of '../../one_day_auth.dart';

/// Regular expression patterns and formatters
class ServiceRegExp {
  /// email regular expression pattern
  static final RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
  );

  /// numbers regular expression pattern
  static final RegExp numRegExp = RegExp(r'[0-9]');

  /// default phone [TextInputFormatter]
  static final List<TextInputFormatter> phoneFormatter = [
    LengthLimitingTextInputFormatter(12),
    FilteringTextInputFormatter.allow(
      ServiceRegExp.numRegExp,
    ),
  ];

  /// default code [TextInputFormatter]
  static final List<TextInputFormatter> codeFormatter = [
    LengthLimitingTextInputFormatter(6),
    FilteringTextInputFormatter.allow(
      ServiceRegExp.numRegExp,
    ),
  ];
}
