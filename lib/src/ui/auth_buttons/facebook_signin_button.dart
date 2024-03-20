part of '../../../one_day_auth.dart';

/// UI component for Facebook sign in
class FacebookSignInButton extends StatelessWidget {
  /// Sing in [VoidCallback]
  final VoidCallback? onPressed;

  /// show loader and disable [onPressed]
  final bool isLoading;

  /// button color
  final Color buttonColor;

  /// Facebook icon color
  final Color iconColor;

  /// title: Continue with Facebook
  final String? title;

  /// title [TextStyle]
  final TextStyle? titleStyle;

  /// use only material style [Widget]
  final bool useMaterialStyle;

  /// material progress indicator color
  final Color materialProgressIndicatorColor;

  /// cupertino progress indicator color
  final Color cupertinoProgressIndicatorColor;

  const FacebookSignInButton({
    required this.onPressed,
    this.isLoading = false,
    this.buttonColor = const Color(0xFF1D5AEF),
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
            Icons.facebook,
            size: 24,
            color: iconColor,
          ),
          const SizedBox(width: 8),
          Text(
            title ?? AuthLocalizations.labelsOf(context).continueWithFacebook,
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
