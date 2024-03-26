part of '../../one_day_auth.dart';

/// Verify phone number result
class CodeSentResult {
  final String phoneNumber;
  final String verificationId;
  final int? forceResendingToken;
  final ConfirmationResult? confirmationResult;
  final DateTime? timeStamp;

  const CodeSentResult({
    required this.phoneNumber,
    required this.verificationId,
    this.forceResendingToken,
    this.confirmationResult,
    this.timeStamp,
  });

  CodeSentResult copyWith({
    final String? phoneNumber,
    final String? verificationId,
    final int? forceResendingToken,
    final DateTime? timeStamp,
  }) {
    return CodeSentResult(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      verificationId: verificationId ?? this.verificationId,
      forceResendingToken: forceResendingToken ?? this.forceResendingToken,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }
}
