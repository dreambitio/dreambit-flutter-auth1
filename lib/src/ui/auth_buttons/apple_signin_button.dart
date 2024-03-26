part of '../../../one_day_auth.dart';

/// UI component for Apple sign in
class AppleSignInButton extends StatelessWidget {
  /// Sing in [VoidCallback]
  final VoidCallback? onPressed;

  /// show loader and disable [onPressed]
  final bool isLoading;

  /// button color
  final Color buttonColor;

  /// Apple icon color
  final Color iconColor;

  /// title: Continue with Apple
  final String? title;

  /// title [TextStyle]
  final TextStyle? titleStyle;

  /// use only material style [Widget]
  final bool useMaterialStyle;

  /// material progress indicator color
  final Color materialProgressIndicatorColor;

  /// cupertino progress indicator color
  final Color cupertinoProgressIndicatorColor;

  const AppleSignInButton({
    required this.onPressed,
    this.isLoading = false,
    this.buttonColor = const Color(0xFF262626),
    this.iconColor = Colors.white,
    this.title,
    this.titleStyle,
    this.useMaterialStyle = false,
    this.cupertinoProgressIndicatorColor = Colors.white,
    this.materialProgressIndicatorColor = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AuthMainButton(
      onPressed: onPressed,
      color: buttonColor,
      loading: isLoading,
      useMaterialStyle: useMaterialStyle,
      cupertinoProgressIndicatorColor: cupertinoProgressIndicatorColor,
      materialProgressIndicatorColor: materialProgressIndicatorColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.apple,
            size: 24,
            color: iconColor,
          ),
          const SizedBox(width: 8),
          Text(
            title ?? AuthLocalizations.labelsOf(context).continueWithApple,
            style: titleStyle ??
                AuthStyles.mainButtonStyle(
                  size: 16,
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}
